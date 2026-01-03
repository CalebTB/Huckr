import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ultimate_hub/core/errors/failures.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/game_repository.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_remote_datasource.dart';

/// Implementation of GameRepository with offline-first strategy
///
/// Strategy:
/// 1. Always write to local storage first (instant response)
/// 2. Try to sync to remote if online (background)
/// 3. Queue offline changes for later sync
/// 4. Read from local cache when possible
///
/// This ensures the app works perfectly offline while maintaining
/// eventual consistency with the remote database.
class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource localDataSource;
  final GameRemoteDataSource remoteDataSource;
  final Connectivity connectivity;

  GameRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, Game>> createGame(Game game) async {
    try {
      // STEP 1: Write to local immediately (offline-first)
      await localDataSource.cacheGame(game);

      // STEP 2: Try to sync to remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remoteGame = await remoteDataSource.createGame(game);
          // Mark as synced and update local cache
          final syncedGame = remoteGame.copyWith(
            isSynced: true,
            lastSyncedAt: DateTime.now(),
          );
          await localDataSource.updateCachedGame(syncedGame);
          return Right(syncedGame);
        } catch (e) {
          // Remote failed, but local succeeded - that's OK for offline-first
          // The sync service will retry later
          return Right(game);
        }
      }

      // Offline - return local game (will be synced later)
      return Right(game);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Game>> getGame(String gameId) async {
    try {
      // STEP 1: Check local cache first (fast)
      final cachedGame = await localDataSource.getCachedGame(gameId);
      if (cachedGame != null) {
        return Right(cachedGame);
      }

      // STEP 2: Not in cache - fetch from remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remoteGame = await remoteDataSource.getGame(gameId);
          // Cache it for future offline access
          await localDataSource.cacheGame(remoteGame);
          return Right(remoteGame);
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      }

      // Offline and not in cache
      return const Left(NotFoundFailure('Game not found in local cache'));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Game>> updateGame(Game game) async {
    try {
      // STEP 1: Update local immediately
      await localDataSource.updateCachedGame(game);

      // STEP 2: Try to sync to remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remoteGame = await remoteDataSource.updateGame(game);
          // Mark as synced
          final syncedGame = remoteGame.copyWith(
            isSynced: true,
            lastSyncedAt: DateTime.now(),
          );
          await localDataSource.updateCachedGame(syncedGame);
          return Right(syncedGame);
        } catch (e) {
          // Remote failed, but local succeeded
          return Right(game);
        }
      }

      // Offline - return local game
      return Right(game);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGame(String gameId) async {
    try {
      // STEP 1: Delete from local
      await localDataSource.deleteCachedGame(gameId);

      // STEP 2: Try to delete from remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          await remoteDataSource.deleteGame(gameId);
        } catch (e) {
          // Remote failed, but local delete succeeded
          // This is acceptable - the game is gone locally
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Game>>> getAllGames() async {
    try {
      // Always read from local cache (fast, works offline)
      final games = await localDataSource.getAllCachedGames();
      return Right(games);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Game>>> getGamesByTournament(
    String tournamentId,
  ) async {
    try {
      final isOnline = await _isOnline();

      if (isOnline) {
        try {
          // Fetch from remote and cache all games
          final games = await remoteDataSource.getGamesByTournament(
            tournamentId,
          );
          // Cache all games for offline access
          for (final game in games) {
            await localDataSource.cacheGame(game);
          }
          return Right(games);
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      }

      // Offline - filter local cache
      final allGames = await localDataSource.getAllCachedGames();
      final filteredGames = allGames
          .where((g) => g.tournamentId == tournamentId)
          .toList();
      return Right(filteredGames);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, Game>> watchGame(String gameId) {
    try {
      // Subscribe to Realtime updates from Supabase
      return remoteDataSource.watchGame(gameId).map((game) {
        // Also update local cache when we receive updates
        localDataSource.cacheGame(game);
        return Right<Failure, Game>(game);
      }).handleError((error) {
        return Left<Failure, Game>(ServerFailure(error.toString()));
      });
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> syncGame(String gameId) async {
    try {
      final isOnline = await _isOnline();
      if (!isOnline) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // Get game from local cache
      final game = await localDataSource.getCachedGame(gameId);
      if (game == null) {
        return const Left(NotFoundFailure('Game not found in local cache'));
      }

      // Already synced - skip
      if (game.isSynced) {
        return const Right(null);
      }

      // Sync to remote
      try {
        final remoteGame = await remoteDataSource.updateGame(game);
        // Mark as synced
        final syncedGame = remoteGame.copyWith(
          isSynced: true,
          lastSyncedAt: DateTime.now(),
        );
        await localDataSource.updateCachedGame(syncedGame);
        return const Right(null);
      } catch (e) {
        return Left(SyncFailure(e.toString()));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Check if device is online
  Future<bool> _isOnline() async {
    final connectivityResult = await connectivity.checkConnectivity();
    // connectivity_plus 5.x returns ConnectivityResult (not a List)
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet;
  }
}

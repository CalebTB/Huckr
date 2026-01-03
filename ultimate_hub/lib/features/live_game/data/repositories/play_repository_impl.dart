import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ultimate_hub/core/errors/failures.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/play_repository.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_remote_datasource.dart';

/// Implementation of PlayRepository with offline-first strategy
///
/// Strategy:
/// 1. Always write to local storage first (instant response)
/// 2. Try to sync to remote if online (background)
/// 3. Queue offline changes for later sync
/// 4. Read from local cache when possible
///
/// This ensures the app works perfectly offline while maintaining
/// eventual consistency with the remote database.
class PlayRepositoryImpl implements PlayRepository {
  final PlayLocalDataSource localDataSource;
  final PlayRemoteDataSource remoteDataSource;
  final Connectivity connectivity;

  PlayRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, Play>> recordPlay(Play play) async {
    try {
      // STEP 1: Write to local immediately (offline-first)
      await localDataSource.cachePlay(play);

      // STEP 2: Try to sync to remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remotePlay = await remoteDataSource.createPlay(play);
          // Mark as synced and update local cache
          final syncedPlay = remotePlay.copyWith(
            isSynced: true,
            syncedAt: DateTime.now(),
          );
          await localDataSource.updateCachedPlay(syncedPlay);
          return Right(syncedPlay);
        } catch (e) {
          // Remote failed, but local succeeded - that's OK for offline-first
          // The sync service will retry later
          return Right(play);
        }
      }

      // Offline - return local play (will be synced later)
      return Right(play);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Play>>> getPlaysForGame(String gameId) async {
    try {
      // STEP 1: Check local cache first (fast)
      final cachedPlays = await localDataSource.getPlaysForGame(gameId);

      // STEP 2: If online, fetch from remote and update cache
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remotePlays = await remoteDataSource.getPlaysForGame(gameId);
          // Cache all plays for offline access
          for (final play in remotePlays) {
            await localDataSource.cachePlay(play);
          }
          return Right(remotePlays);
        } catch (e) {
          // Remote failed - fall back to cached plays
          return Right(cachedPlays);
        }
      }

      // Offline - return cached plays
      return Right(cachedPlays);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Play>>> getPlaysForPoint(String pointId) async {
    try {
      // STEP 1: Check local cache first (fast)
      final cachedPlays = await localDataSource.getPlaysForPoint(pointId);

      // STEP 2: If online, fetch from remote and update cache
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remotePlays = await remoteDataSource.getPlaysForPoint(pointId);
          // Cache all plays for offline access
          for (final play in remotePlays) {
            await localDataSource.cachePlay(play);
          }
          return Right(remotePlays);
        } catch (e) {
          // Remote failed - fall back to cached plays
          return Right(cachedPlays);
        }
      }

      // Offline - return cached plays
      return Right(cachedPlays);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Play>> updatePlay(Play play) async {
    try {
      // STEP 1: Update local immediately
      await localDataSource.updateCachedPlay(play);

      // STEP 2: Try to sync to remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          final remotePlay = await remoteDataSource.updatePlay(play);
          // Mark as synced
          final syncedPlay = remotePlay.copyWith(
            isSynced: true,
            syncedAt: DateTime.now(),
          );
          await localDataSource.updateCachedPlay(syncedPlay);
          return Right(syncedPlay);
        } catch (e) {
          // Remote failed, but local succeeded
          return Right(play);
        }
      }

      // Offline - return local play
      return Right(play);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlay(String playId) async {
    try {
      // STEP 1: Delete from local
      await localDataSource.deleteCachedPlay(playId);

      // STEP 2: Try to delete from remote if online
      final isOnline = await _isOnline();
      if (isOnline) {
        try {
          await remoteDataSource.deletePlay(playId);
        } catch (e) {
          // Remote failed, but local delete succeeded
          // This is acceptable - the play is gone locally
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Play>>> watchPlaysForGame(String gameId) {
    try {
      // Subscribe to Realtime updates from Supabase
      return remoteDataSource.watchPlaysForGame(gameId).map((plays) {
        // Also update local cache when we receive updates
        for (final play in plays) {
          localDataSource.cachePlay(play);
        }
        return Right<Failure, List<Play>>(plays);
      }).handleError((error) {
        return Left<Failure, List<Play>>(ServerFailure(error.toString()));
      });
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> syncPlaysForGame(String gameId) async {
    try {
      final isOnline = await _isOnline();
      if (!isOnline) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // Get unsynced plays for this game from local cache
      final unsyncedPlays =
          await localDataSource.getUnsyncedPlaysForGame(gameId);

      if (unsyncedPlays.isEmpty) {
        return const Right(null);
      }

      // Sync each unsynced play to remote
      for (final play in unsyncedPlays) {
        try {
          final remotePlay = await remoteDataSource.updatePlay(play);
          // Mark as synced
          final syncedPlay = remotePlay.copyWith(
            isSynced: true,
            syncedAt: DateTime.now(),
          );
          await localDataSource.updateCachedPlay(syncedPlay);
        } catch (e) {
          // Continue syncing other plays even if one fails
          continue;
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(SyncFailure(e.toString()));
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

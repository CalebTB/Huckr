import 'package:dartz/dartz.dart';
import 'package:ultimate_hub/core/errors/failures.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';

/// Repository interface for Game entity operations
///
/// Defines the contract for game data operations that combine local (Hive)
/// and remote (Supabase) data sources with offline-first strategy.
///
/// Uses Either<Failure, T> pattern from dartz for error handling
abstract class GameRepository {
  /// Create a new game
  ///
  /// Writes to local storage immediately, then syncs to remote if online
  /// Returns the created game or a failure
  Future<Either<Failure, Game>> createGame(Game game);

  /// Get a game by ID
  ///
  /// Checks local cache first, falls back to remote if not found and online
  /// Returns the game or a failure (NotFoundFailure if game doesn't exist)
  Future<Either<Failure, Game>> getGame(String gameId);

  /// Update an existing game
  ///
  /// Updates local storage immediately, then syncs to remote if online
  /// Returns the updated game or a failure
  Future<Either<Failure, Game>> updateGame(Game game);

  /// Delete a game
  ///
  /// Deletes from local storage immediately, then from remote if online
  /// Returns success or a failure
  Future<Either<Failure, void>> deleteGame(String gameId);

  /// Get all games from local storage
  ///
  /// Returns all cached games or a failure
  /// Useful for viewing game history offline
  Future<Either<Failure, List<Game>>> getAllGames();

  /// Get games by tournament ID
  ///
  /// Fetches from remote if online and caches locally
  /// Falls back to local cache if offline
  /// Returns list of games or a failure
  Future<Either<Failure, List<Game>>> getGamesByTournament(String tournamentId);

  /// Stream a game in real-time (for spectator mode)
  ///
  /// Uses Supabase Realtime to stream live updates
  /// Returns a stream of Either<Failure, Game>
  /// Emits updates whenever the game changes on the server
  Stream<Either<Failure, Game>> watchGame(String gameId);

  /// Manually sync a game to remote
  ///
  /// Forces a sync of local game data to Supabase
  /// Returns success or a failure (NetworkFailure if offline, SyncFailure if sync fails)
  Future<Either<Failure, void>> syncGame(String gameId);
}

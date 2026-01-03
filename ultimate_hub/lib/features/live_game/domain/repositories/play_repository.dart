import 'package:dartz/dartz.dart';
import 'package:ultimate_hub/core/errors/failures.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';

/// Repository interface for Play entity operations
///
/// Defines the contract for play data operations that combine local (Hive)
/// and remote (Supabase) data sources with offline-first strategy.
///
/// Plays are append-only (natural CRDT) - each play has a UUID and timestamp
/// which makes conflict resolution simple: merge by sorting on timestamp
///
/// Uses Either<Failure, T> pattern from dartz for error handling
abstract class PlayRepository {
  /// Record a new play
  ///
  /// Writes to local storage immediately, then syncs to remote if online
  /// Returns the recorded play or a failure
  Future<Either<Failure, Play>> recordPlay(Play play);

  /// Get all plays for a game
  ///
  /// Returns plays from local cache sorted by timestamp
  /// This is the primary way to query plays (always from local for performance)
  Future<Either<Failure, List<Play>>> getPlaysForGame(String gameId);

  /// Get all plays for a specific point
  ///
  /// Returns plays from local cache sorted by play number
  /// Useful for point-by-point replay and statistics
  Future<Either<Failure, List<Play>>> getPlaysForPoint(String pointId);

  /// Update a play (for corrections)
  ///
  /// Updates local storage immediately, then syncs to remote if online
  /// Returns the updated play or a failure
  /// Note: Use sparingly - plays are typically append-only
  Future<Either<Failure, Play>> updatePlay(Play play);

  /// Delete a play (undo)
  ///
  /// Deletes from local storage immediately, then from remote if online
  /// Returns success or a failure
  /// Note: Typically used for immediate undo, not historical changes
  Future<Either<Failure, void>> deletePlay(String playId);

  /// Stream plays for a game in real-time
  ///
  /// Uses Supabase Realtime to stream live play updates
  /// Returns a stream of Either<Failure, List<Play>>
  /// Emits updates whenever new plays are recorded
  /// Useful for spectator mode - see plays as they happen
  Stream<Either<Failure, List<Play>>> watchPlaysForGame(String gameId);

  /// Manually sync plays for a game to remote
  ///
  /// Forces a sync of all unsynced plays for a game to Supabase
  /// Returns success or a failure (NetworkFailure if offline, SyncFailure if sync fails)
  /// Typically called by background sync service, but can be manual
  Future<Either<Failure, void>> syncPlaysForGame(String gameId);
}

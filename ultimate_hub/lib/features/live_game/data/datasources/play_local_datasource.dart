import 'package:hive/hive.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';

/// Abstract interface for local play data source
///
/// Defines the contract for local storage operations using Hive
/// All operations are synchronous as Hive operations are fast
abstract class PlayLocalDataSource {
  /// Cache a play to local storage
  Future<void> cachePlay(Play play);

  /// Get a cached play by ID
  /// Returns null if play not found
  Future<Play?> getCachedPlay(String playId);

  /// Get all plays for a specific game
  /// Returns plays sorted by timestamp ascending (chronological order)
  Future<List<Play>> getPlaysForGame(String gameId);

  /// Get all plays for a specific point
  /// Returns plays sorted by play_number ascending
  Future<List<Play>> getPlaysForPoint(String pointId);

  /// Update a cached play
  Future<void> updateCachedPlay(Play play);

  /// Delete a cached play
  Future<void> deleteCachedPlay(String playId);

  /// Get all plays that haven't been synced to remote
  /// Used by sync service to push local changes
  Future<List<Play>> getUnsyncedPlays();

  /// Get unsynced plays for a specific game
  /// Useful for partial syncing
  Future<List<Play>> getUnsyncedPlaysForGame(String gameId);

  /// Clear all cached plays
  /// Useful for testing or complete data reset
  Future<void> clearAll();
}

/// Implementation of PlayLocalDataSource using Hive
///
/// Uses the 'plays' Hive box opened in main.dart
/// All plays are stored with their ID as the key for fast lookups
class PlayLocalDataSourceImpl implements PlayLocalDataSource {
  final Box<Play> playBox;

  PlayLocalDataSourceImpl({required this.playBox});

  @override
  Future<void> cachePlay(Play play) async {
    await playBox.put(play.id, play);
  }

  @override
  Future<Play?> getCachedPlay(String playId) async {
    return playBox.get(playId);
  }

  @override
  Future<List<Play>> getPlaysForGame(String gameId) async {
    // Filter by game_id and sort by timestamp
    final plays = playBox.values
        .where((play) => play.gameId == gameId)
        .toList();

    // Sort by timestamp ascending (chronological order)
    plays.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return plays;
  }

  @override
  Future<List<Play>> getPlaysForPoint(String pointId) async {
    // Filter by point_id and sort by play_number
    final plays = playBox.values
        .where((play) => play.pointId == pointId)
        .toList();

    // Sort by play_number ascending
    plays.sort((a, b) => a.playNumber.compareTo(b.playNumber));

    return plays;
  }

  @override
  Future<void> updateCachedPlay(Play play) async {
    // Hive allows put to update existing entries
    await playBox.put(play.id, play);
  }

  @override
  Future<void> deleteCachedPlay(String playId) async {
    await playBox.delete(playId);
  }

  @override
  Future<List<Play>> getUnsyncedPlays() async {
    // Filter plays where isSynced is false
    return playBox.values.where((play) => !play.isSynced).toList();
  }

  @override
  Future<List<Play>> getUnsyncedPlaysForGame(String gameId) async {
    // Filter by game_id and isSynced is false
    return playBox.values
        .where((play) => play.gameId == gameId && !play.isSynced)
        .toList();
  }

  @override
  Future<void> clearAll() async {
    await playBox.clear();
  }
}

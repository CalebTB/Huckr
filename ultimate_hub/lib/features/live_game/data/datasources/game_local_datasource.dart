import 'package:hive/hive.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';

/// Abstract interface for local game data source
///
/// Defines the contract for local storage operations using Hive
/// All operations are synchronous as Hive operations are fast
abstract class GameLocalDataSource {
  /// Cache a game to local storage
  Future<void> cacheGame(Game game);

  /// Get a cached game by ID
  /// Returns null if game not found
  Future<Game?> getCachedGame(String gameId);

  /// Get all cached games
  /// Returns empty list if no games cached
  Future<List<Game>> getAllCachedGames();

  /// Update a cached game
  Future<void> updateCachedGame(Game game);

  /// Delete a cached game
  Future<void> deleteCachedGame(String gameId);

  /// Get all games that haven't been synced to remote
  /// Used by sync service to push local changes
  Future<List<Game>> getUnsyncedGames();

  /// Clear all cached games
  /// Useful for testing or complete data reset
  Future<void> clearAll();
}

/// Implementation of GameLocalDataSource using Hive
///
/// Uses the 'games' Hive box opened in main.dart
/// All games are stored with their ID as the key for fast lookups
class GameLocalDataSourceImpl implements GameLocalDataSource {
  final Box<Game> gameBox;

  GameLocalDataSourceImpl({required this.gameBox});

  @override
  Future<void> cacheGame(Game game) async {
    await gameBox.put(game.id, game);
  }

  @override
  Future<Game?> getCachedGame(String gameId) async {
    return gameBox.get(gameId);
  }

  @override
  Future<List<Game>> getAllCachedGames() async {
    // Convert box values to list
    // Sort by created_at descending (newest first)
    final games = gameBox.values.toList();
    games.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return games;
  }

  @override
  Future<void> updateCachedGame(Game game) async {
    // Hive allows put to update existing entries
    await gameBox.put(game.id, game);
  }

  @override
  Future<void> deleteCachedGame(String gameId) async {
    await gameBox.delete(gameId);
  }

  @override
  Future<List<Game>> getUnsyncedGames() async {
    // Filter games where isSynced is false
    return gameBox.values.where((game) => !game.isSynced).toList();
  }

  @override
  Future<void> clearAll() async {
    await gameBox.clear();
  }
}

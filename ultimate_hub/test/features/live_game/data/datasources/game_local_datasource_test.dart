import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/core/enums/game_status.dart';
import 'package:ultimate_hub/core/storage/hive_adapters.dart';

void main() {
  late Box<Game> gameBox;
  late GameLocalDataSourceImpl dataSource;
  late Directory testDir;

  setUpAll(() async {
    // Initialize Hive for testing with a temporary directory
    testDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(testDir.path);
    registerHiveAdapters();
  });

  tearDownAll(() async {
    // Clean up test directory
    await testDir.delete(recursive: true);
  });

  setUp(() async {
    // Use a unique box name for each test to avoid conflicts
    gameBox = await Hive.openBox<Game>('test_games_${DateTime.now().millisecondsSinceEpoch}');
    dataSource = GameLocalDataSourceImpl(gameBox: gameBox);
  });

  tearDown(() async {
    // Clean up after each test
    await gameBox.clear();
    await gameBox.close();
  });

  group('GameLocalDataSource', () {
    test('cacheGame should store a game in Hive', () async {
      // Arrange
      final game = Game(
        id: 'game_1',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Home Team',
        awayTeamName: 'Away Team',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act
      await dataSource.cacheGame(game);

      // Assert
      final cachedGame = gameBox.get('game_1');
      expect(cachedGame, isNotNull);
      expect(cachedGame!.id, equals('game_1'));
      expect(cachedGame.homeTeamName, equals('Home Team'));
    });

    test('getCachedGame should return a game by ID', () async {
      // Arrange
      final game = Game(
        id: 'game_2',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Home Team',
        awayTeamName: 'Away Team',
        homeScore: 5,
        awayScore: 3,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.inProgress,
        currentPoint: 9,
        isDelayed: false,
        isBeingTracked: true,
        isSynced: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await dataSource.cacheGame(game);

      // Act
      final result = await dataSource.getCachedGame('game_2');

      // Assert
      expect(result, isNotNull);
      expect(result!.id, equals('game_2'));
      expect(result.homeScore, equals(5));
      expect(result.awayScore, equals(3));
    });

    test('getCachedGame should return null for non-existent ID', () async {
      // Act
      final result = await dataSource.getCachedGame('non_existent');

      // Assert
      expect(result, isNull);
    });

    test('getAllCachedGames should return all games sorted by created_at descending', () async {
      // Arrange
      final game1 = Game(
        id: 'game_1',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Game 1',
        awayTeamName: 'Away 1',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now(),
      );

      final game2 = Game(
        id: 'game_2',
        homeTeamId: 'team_3',
        awayTeamId: 'team_4',
        homeTeamName: 'Game 2',
        awayTeamName: 'Away 2',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await dataSource.cacheGame(game1);
      await dataSource.cacheGame(game2);

      // Act
      final result = await dataSource.getAllCachedGames();

      // Assert
      expect(result, hasLength(2));
      expect(result[0].id, equals('game_2')); // Newer game first
      expect(result[1].id, equals('game_1'));
    });

    test('updateCachedGame should update an existing game', () async {
      // Arrange
      final originalGame = Game(
        id: 'game_3',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Home Team',
        awayTeamName: 'Away Team',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await dataSource.cacheGame(originalGame);

      // Act - Update the game
      final updatedGame = originalGame.copyWith(
        homeScore: 7,
        awayScore: 5,
        status: GameStatus.inProgress,
      );
      await dataSource.updateCachedGame(updatedGame);

      // Assert
      final result = await dataSource.getCachedGame('game_3');
      expect(result!.homeScore, equals(7));
      expect(result.awayScore, equals(5));
      expect(result.status, equals(GameStatus.inProgress));
    });

    test('deleteCachedGame should remove a game from cache', () async {
      // Arrange
      final game = Game(
        id: 'game_4',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Home Team',
        awayTeamName: 'Away Team',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await dataSource.cacheGame(game);

      // Act
      await dataSource.deleteCachedGame('game_4');

      // Assert
      final result = await dataSource.getCachedGame('game_4');
      expect(result, isNull);
    });

    test('getUnsyncedGames should return only unsynced games', () async {
      // Arrange
      final syncedGame = Game(
        id: 'game_synced',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Synced Game',
        awayTeamName: 'Away Team',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final unsyncedGame = Game(
        id: 'game_unsynced',
        homeTeamId: 'team_3',
        awayTeamId: 'team_4',
        homeTeamName: 'Unsynced Game',
        awayTeamName: 'Away Team',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await dataSource.cacheGame(syncedGame);
      await dataSource.cacheGame(unsyncedGame);

      // Act
      final result = await dataSource.getUnsyncedGames();

      // Assert
      expect(result, hasLength(1));
      expect(result[0].id, equals('game_unsynced'));
      expect(result[0].isSynced, isFalse);
    });

    test('clearAll should remove all games from cache', () async {
      // Arrange
      final game1 = Game(
        id: 'game_1',
        homeTeamId: 'team_1',
        awayTeamId: 'team_2',
        homeTeamName: 'Game 1',
        awayTeamName: 'Away 1',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final game2 = Game(
        id: 'game_2',
        homeTeamId: 'team_3',
        awayTeamId: 'team_4',
        homeTeamName: 'Game 2',
        awayTeamName: 'Away 2',
        homeScore: 0,
        awayScore: 0,
        gameToPoints: 15,
        hardCapPoints: 17,
        softCapMinutes: 75,
        hardCapMinutes: 90,
        status: GameStatus.scheduled,
        currentPoint: 1,
        isDelayed: false,
        isBeingTracked: false,
        isSynced: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await dataSource.cacheGame(game1);
      await dataSource.cacheGame(game2);

      // Act
      await dataSource.clearAll();

      // Assert
      final result = await dataSource.getAllCachedGames();
      expect(result, isEmpty);
    });
  });
}

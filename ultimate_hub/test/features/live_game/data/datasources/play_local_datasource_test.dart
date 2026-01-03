import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/core/enums/play_type.dart';
import 'package:ultimate_hub/core/storage/hive_adapters.dart';

void main() {
  late Box<Play> playBox;
  late PlayLocalDataSourceImpl dataSource;
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
    playBox = await Hive.openBox<Play>('test_plays_${DateTime.now().millisecondsSinceEpoch}');
    dataSource = PlayLocalDataSourceImpl(playBox: playBox);
  });

  tearDown(() async {
    // Clean up after each test
    await playBox.clear();
    await playBox.close();
  });

  group('PlayLocalDataSource', () {
    test('cachePlay should store a play in Hive', () async {
      // Arrange
      final play = Play(
        id: 'play_1',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      // Act
      await dataSource.cachePlay(play);

      // Assert
      final cachedPlay = playBox.get('play_1');
      expect(cachedPlay, isNotNull);
      expect(cachedPlay!.id, equals('play_1'));
      expect(cachedPlay.type, equals(PlayType.throwDisc));
    });

    test('getCachedPlay should return a play by ID', () async {
      // Arrange
      final play = Play(
        id: 'play_2',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.catch_,
        playerId: 'player_1',
        playerName: 'John Doe',
        timestamp: DateTime.now(),
        isSynced: true,
      );
      await dataSource.cachePlay(play);

      // Act
      final result = await dataSource.getCachedPlay('play_2');

      // Assert
      expect(result, isNotNull);
      expect(result!.id, equals('play_2'));
      expect(result.type, equals(PlayType.catch_));
      expect(result.playerName, equals('John Doe'));
    });

    test('getCachedPlay should return null for non-existent ID', () async {
      // Act
      final result = await dataSource.getCachedPlay('non_existent');

      // Assert
      expect(result, isNull);
    });

    test('getPlaysForGame should return plays sorted by timestamp ascending', () async {
      // Arrange
      final now = DateTime.now();
      final play1 = Play(
        id: 'play_1',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: now.subtract(const Duration(seconds: 10)),
        isSynced: false,
      );

      final play2 = Play(
        id: 'play_2',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.catch_,
        timestamp: now,
        isSynced: false,
      );

      final play3 = Play(
        id: 'play_3',
        gameId: 'game_2',
        pointId: 'point_2',
        playNumber: 1,
        teamId: 'team_2',
        type: PlayType.throwDisc,
        timestamp: now,
        isSynced: false,
      );

      await dataSource.cachePlay(play2);
      await dataSource.cachePlay(play1);
      await dataSource.cachePlay(play3);

      // Act
      final result = await dataSource.getPlaysForGame('game_1');

      // Assert
      expect(result, hasLength(2));
      expect(result[0].id, equals('play_1')); // Older play first
      expect(result[1].id, equals('play_2'));
    });

    test('getPlaysForPoint should return plays sorted by play_number ascending', () async {
      // Arrange
      final now = DateTime.now();
      final play1 = Play(
        id: 'play_1',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 3,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: now,
        isSynced: false,
      );

      final play2 = Play(
        id: 'play_2',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.catch_,
        timestamp: now,
        isSynced: false,
      );

      final play3 = Play(
        id: 'play_3',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: now,
        isSynced: false,
      );

      await dataSource.cachePlay(play1);
      await dataSource.cachePlay(play2);
      await dataSource.cachePlay(play3);

      // Act
      final result = await dataSource.getPlaysForPoint('point_1');

      // Assert
      expect(result, hasLength(3));
      expect(result[0].playNumber, equals(1));
      expect(result[1].playNumber, equals(2));
      expect(result[2].playNumber, equals(3));
    });

    test('updateCachedPlay should update an existing play', () async {
      // Arrange
      final originalPlay = Play(
        id: 'play_4',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );
      await dataSource.cachePlay(originalPlay);

      // Act - Update the play
      final updatedPlay = originalPlay.copyWith(
        type: PlayType.goal,
        isSynced: true,
      );
      await dataSource.updateCachedPlay(updatedPlay);

      // Assert
      final result = await dataSource.getCachedPlay('play_4');
      expect(result!.type, equals(PlayType.goal));
      expect(result.isSynced, isTrue);
    });

    test('deleteCachedPlay should remove a play from cache', () async {
      // Arrange
      final play = Play(
        id: 'play_5',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );
      await dataSource.cachePlay(play);

      // Act
      await dataSource.deleteCachedPlay('play_5');

      // Assert
      final result = await dataSource.getCachedPlay('play_5');
      expect(result, isNull);
    });

    test('getUnsyncedPlays should return only unsynced plays', () async {
      // Arrange
      final syncedPlay = Play(
        id: 'play_synced',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: true,
      );

      final unsyncedPlay = Play(
        id: 'play_unsynced',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.catch_,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      await dataSource.cachePlay(syncedPlay);
      await dataSource.cachePlay(unsyncedPlay);

      // Act
      final result = await dataSource.getUnsyncedPlays();

      // Assert
      expect(result, hasLength(1));
      expect(result[0].id, equals('play_unsynced'));
      expect(result[0].isSynced, isFalse);
    });

    test('getUnsyncedPlaysForGame should return unsynced plays for a specific game', () async {
      // Arrange
      final unsyncedPlayGame1 = Play(
        id: 'play_1',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      final syncedPlayGame1 = Play(
        id: 'play_2',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.catch_,
        timestamp: DateTime.now(),
        isSynced: true,
      );

      final unsyncedPlayGame2 = Play(
        id: 'play_3',
        gameId: 'game_2',
        pointId: 'point_2',
        playNumber: 1,
        teamId: 'team_2',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      await dataSource.cachePlay(unsyncedPlayGame1);
      await dataSource.cachePlay(syncedPlayGame1);
      await dataSource.cachePlay(unsyncedPlayGame2);

      // Act
      final result = await dataSource.getUnsyncedPlaysForGame('game_1');

      // Assert
      expect(result, hasLength(1));
      expect(result[0].id, equals('play_1'));
      expect(result[0].gameId, equals('game_1'));
      expect(result[0].isSynced, isFalse);
    });

    test('clearAll should remove all plays from cache', () async {
      // Arrange
      final play1 = Play(
        id: 'play_1',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 1,
        teamId: 'team_1',
        type: PlayType.throwDisc,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      final play2 = Play(
        id: 'play_2',
        gameId: 'game_1',
        pointId: 'point_1',
        playNumber: 2,
        teamId: 'team_1',
        type: PlayType.catch_,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      await dataSource.cachePlay(play1);
      await dataSource.cachePlay(play2);

      // Act
      await dataSource.clearAll();

      // Assert
      final result = await dataSource.getPlaysForGame('game_1');
      expect(result, isEmpty);
    });
  });
}

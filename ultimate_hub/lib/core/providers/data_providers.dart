import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ultimate_hub/core/services/supabase_client.dart';
import 'package:ultimate_hub/core/services/sync_service.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/game_repository.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/play_repository.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_remote_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_remote_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/repositories/game_repository_impl.dart';
import 'package:ultimate_hub/features/live_game/data/repositories/play_repository_impl.dart';

part 'data_providers.g.dart';

// ============================================================================
// EXTERNAL DEPENDENCIES
// ============================================================================

/// Provides the Supabase client instance
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return SupabaseService.client;
}

/// Provides the Connectivity instance for network status
@riverpod
Connectivity connectivity(ConnectivityRef ref) {
  return Connectivity();
}

// ============================================================================
// HIVE BOXES
// ============================================================================

/// Provides the Hive box for Game entities
@riverpod
Box<Game> gameBox(GameBoxRef ref) {
  return Hive.box<Game>('games');
}

/// Provides the Hive box for Play entities
@riverpod
Box<Play> playBox(PlayBoxRef ref) {
  return Hive.box<Play>('plays');
}

// ============================================================================
// LOCAL DATA SOURCES (HIVE)
// ============================================================================

/// Provides the local data source for Game entities
@riverpod
GameLocalDataSource gameLocalDataSource(GameLocalDataSourceRef ref) {
  return GameLocalDataSourceImpl(
    gameBox: ref.watch(gameBoxProvider),
  );
}

/// Provides the local data source for Play entities
@riverpod
PlayLocalDataSource playLocalDataSource(PlayLocalDataSourceRef ref) {
  return PlayLocalDataSourceImpl(
    playBox: ref.watch(playBoxProvider),
  );
}

// ============================================================================
// REMOTE DATA SOURCES (SUPABASE)
// ============================================================================

/// Provides the remote data source for Game entities
@riverpod
GameRemoteDataSource gameRemoteDataSource(GameRemoteDataSourceRef ref) {
  return GameRemoteDataSourceImpl(
    client: ref.watch(supabaseClientProvider),
  );
}

/// Provides the remote data source for Play entities
@riverpod
PlayRemoteDataSource playRemoteDataSource(PlayRemoteDataSourceRef ref) {
  return PlayRemoteDataSourceImpl(
    client: ref.watch(supabaseClientProvider),
  );
}

// ============================================================================
// REPOSITORIES
// ============================================================================

/// Provides the Game repository with offline-first strategy
@riverpod
GameRepository gameRepository(GameRepositoryRef ref) {
  return GameRepositoryImpl(
    localDataSource: ref.watch(gameLocalDataSourceProvider),
    remoteDataSource: ref.watch(gameRemoteDataSourceProvider),
    connectivity: ref.watch(connectivityProvider),
  );
}

/// Provides the Play repository with offline-first strategy
@riverpod
PlayRepository playRepository(PlayRepositoryRef ref) {
  return PlayRepositoryImpl(
    localDataSource: ref.watch(playLocalDataSourceProvider),
    remoteDataSource: ref.watch(playRemoteDataSourceProvider),
    connectivity: ref.watch(connectivityProvider),
  );
}

// ============================================================================
// SYNC SERVICE
// ============================================================================

/// Provides the background sync service
///
/// This is a singleton that should be started in main.dart
/// and stopped when the app is disposed
@Riverpod(keepAlive: true)
SyncService syncService(SyncServiceRef ref) {
  final service = SyncService(
    gameLocalDataSource: ref.watch(gameLocalDataSourceProvider),
    gameRemoteDataSource: ref.watch(gameRemoteDataSourceProvider),
    playLocalDataSource: ref.watch(playLocalDataSourceProvider),
    playRemoteDataSource: ref.watch(playRemoteDataSourceProvider),
    connectivity: ref.watch(connectivityProvider),
  );

  // Start the sync service when created
  service.start();

  // Dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}

/// Provides a stream of sync status updates
@riverpod
Stream<SyncStatus> syncStatusStream(SyncStatusStreamRef ref) {
  final service = ref.watch(syncServiceProvider);
  return service.statusStream;
}

/// Provides the current sync status
@riverpod
SyncStatus syncStatus(SyncStatusRef ref) {
  final service = ref.watch(syncServiceProvider);
  return service.status;
}

/// Provides statistics about unsynced items
@riverpod
Future<SyncStats> unsyncedStats(UnsyncedStatsRef ref) async {
  final service = ref.watch(syncServiceProvider);
  return service.getUnsyncedStats();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseClientHash() => r'bc5785f8ca5188342719fbe4d4b9f7de9f1535a6';

/// Provides the Supabase client instance
///
/// Copied from [supabaseClient].
@ProviderFor(supabaseClient)
final supabaseClientProvider = AutoDisposeProvider<SupabaseClient>.internal(
  supabaseClient,
  name: r'supabaseClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseClientRef = AutoDisposeProviderRef<SupabaseClient>;
String _$connectivityHash() => r'da8080dfc40288eff97ff9cb96e9d9577714a9a0';

/// Provides the Connectivity instance for network status
///
/// Copied from [connectivity].
@ProviderFor(connectivity)
final connectivityProvider = AutoDisposeProvider<Connectivity>.internal(
  connectivity,
  name: r'connectivityProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$connectivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConnectivityRef = AutoDisposeProviderRef<Connectivity>;
String _$gameBoxHash() => r'fe4b3a5ef44316c6123c9c19130caa905620129b';

/// Provides the Hive box for Game entities
///
/// Copied from [gameBox].
@ProviderFor(gameBox)
final gameBoxProvider = AutoDisposeProvider<Box<Game>>.internal(
  gameBox,
  name: r'gameBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameBoxRef = AutoDisposeProviderRef<Box<Game>>;
String _$playBoxHash() => r'365b3912fe9a60440b23ca87c6764f3e540f50c6';

/// Provides the Hive box for Play entities
///
/// Copied from [playBox].
@ProviderFor(playBox)
final playBoxProvider = AutoDisposeProvider<Box<Play>>.internal(
  playBox,
  name: r'playBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayBoxRef = AutoDisposeProviderRef<Box<Play>>;
String _$gameLocalDataSourceHash() =>
    r'95062ca1643cafa3ead0da9e5483e560fd747a52';

/// Provides the local data source for Game entities
///
/// Copied from [gameLocalDataSource].
@ProviderFor(gameLocalDataSource)
final gameLocalDataSourceProvider =
    AutoDisposeProvider<GameLocalDataSource>.internal(
  gameLocalDataSource,
  name: r'gameLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameLocalDataSourceRef = AutoDisposeProviderRef<GameLocalDataSource>;
String _$playLocalDataSourceHash() =>
    r'3cab642fa884900d50bbfd8790cacb283e5a754f';

/// Provides the local data source for Play entities
///
/// Copied from [playLocalDataSource].
@ProviderFor(playLocalDataSource)
final playLocalDataSourceProvider =
    AutoDisposeProvider<PlayLocalDataSource>.internal(
  playLocalDataSource,
  name: r'playLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayLocalDataSourceRef = AutoDisposeProviderRef<PlayLocalDataSource>;
String _$gameRemoteDataSourceHash() =>
    r'139a05aabb4768bf8baa7f48423a9d9396cc02c9';

/// Provides the remote data source for Game entities
///
/// Copied from [gameRemoteDataSource].
@ProviderFor(gameRemoteDataSource)
final gameRemoteDataSourceProvider =
    AutoDisposeProvider<GameRemoteDataSource>.internal(
  gameRemoteDataSource,
  name: r'gameRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameRemoteDataSourceRef = AutoDisposeProviderRef<GameRemoteDataSource>;
String _$playRemoteDataSourceHash() =>
    r'304dee6d416b001528131cf7e45ce12e5a982fd6';

/// Provides the remote data source for Play entities
///
/// Copied from [playRemoteDataSource].
@ProviderFor(playRemoteDataSource)
final playRemoteDataSourceProvider =
    AutoDisposeProvider<PlayRemoteDataSource>.internal(
  playRemoteDataSource,
  name: r'playRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayRemoteDataSourceRef = AutoDisposeProviderRef<PlayRemoteDataSource>;
String _$gameRepositoryHash() => r'68bbe92fe2a660837d774bcf56ea7934741ad8a5';

/// Provides the Game repository with offline-first strategy
///
/// Copied from [gameRepository].
@ProviderFor(gameRepository)
final gameRepositoryProvider = AutoDisposeProvider<GameRepository>.internal(
  gameRepository,
  name: r'gameRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameRepositoryRef = AutoDisposeProviderRef<GameRepository>;
String _$playRepositoryHash() => r'6a23e82d1f24652ced73083589e88e8ffd880783';

/// Provides the Play repository with offline-first strategy
///
/// Copied from [playRepository].
@ProviderFor(playRepository)
final playRepositoryProvider = AutoDisposeProvider<PlayRepository>.internal(
  playRepository,
  name: r'playRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayRepositoryRef = AutoDisposeProviderRef<PlayRepository>;
String _$syncServiceHash() => r'657cdc4290e52d8a6a184ca6cd3d27e08b5c84bb';

/// Provides the background sync service
///
/// This is a singleton that should be started in main.dart
/// and stopped when the app is disposed
///
/// Copied from [syncService].
@ProviderFor(syncService)
final syncServiceProvider = Provider<SyncService>.internal(
  syncService,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncServiceRef = ProviderRef<SyncService>;
String _$syncStatusStreamHash() => r'67bef23364bb6e8e75ab1b31ed102b0811f830c4';

/// Provides a stream of sync status updates
///
/// Copied from [syncStatusStream].
@ProviderFor(syncStatusStream)
final syncStatusStreamProvider = AutoDisposeStreamProvider<SyncStatus>.internal(
  syncStatusStream,
  name: r'syncStatusStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncStatusStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncStatusStreamRef = AutoDisposeStreamProviderRef<SyncStatus>;
String _$syncStatusHash() => r'6bd6b3e99c8e6e6fe4b4f754143c68b74093b709';

/// Provides the current sync status
///
/// Copied from [syncStatus].
@ProviderFor(syncStatus)
final syncStatusProvider = AutoDisposeProvider<SyncStatus>.internal(
  syncStatus,
  name: r'syncStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncStatusRef = AutoDisposeProviderRef<SyncStatus>;
String _$unsyncedStatsHash() => r'2384c302f96331866b88847c573c04d48b4df333';

/// Provides statistics about unsynced items
///
/// Copied from [unsyncedStats].
@ProviderFor(unsyncedStats)
final unsyncedStatsProvider = AutoDisposeFutureProvider<SyncStats>.internal(
  unsyncedStats,
  name: r'unsyncedStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unsyncedStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UnsyncedStatsRef = AutoDisposeFutureProviderRef<SyncStats>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

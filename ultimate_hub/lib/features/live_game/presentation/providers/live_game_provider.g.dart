// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$liveGameHash() => r'd8bd69769faf0cce52c0043d7140a1ad8fc906d4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$LiveGame extends BuildlessAutoDisposeAsyncNotifier<Game> {
  late final String gameId;

  FutureOr<Game> build(
    String gameId,
  );
}

/// Provider for managing live game state
///
/// Handles game loading, score updates, possession changes, status transitions,
/// and persistence to Hive with background Supabase sync
///
/// Copied from [LiveGame].
@ProviderFor(LiveGame)
const liveGameProvider = LiveGameFamily();

/// Provider for managing live game state
///
/// Handles game loading, score updates, possession changes, status transitions,
/// and persistence to Hive with background Supabase sync
///
/// Copied from [LiveGame].
class LiveGameFamily extends Family<AsyncValue<Game>> {
  /// Provider for managing live game state
  ///
  /// Handles game loading, score updates, possession changes, status transitions,
  /// and persistence to Hive with background Supabase sync
  ///
  /// Copied from [LiveGame].
  const LiveGameFamily();

  /// Provider for managing live game state
  ///
  /// Handles game loading, score updates, possession changes, status transitions,
  /// and persistence to Hive with background Supabase sync
  ///
  /// Copied from [LiveGame].
  LiveGameProvider call(
    String gameId,
  ) {
    return LiveGameProvider(
      gameId,
    );
  }

  @override
  LiveGameProvider getProviderOverride(
    covariant LiveGameProvider provider,
  ) {
    return call(
      provider.gameId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'liveGameProvider';
}

/// Provider for managing live game state
///
/// Handles game loading, score updates, possession changes, status transitions,
/// and persistence to Hive with background Supabase sync
///
/// Copied from [LiveGame].
class LiveGameProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LiveGame, Game> {
  /// Provider for managing live game state
  ///
  /// Handles game loading, score updates, possession changes, status transitions,
  /// and persistence to Hive with background Supabase sync
  ///
  /// Copied from [LiveGame].
  LiveGameProvider(
    String gameId,
  ) : this._internal(
          () => LiveGame()..gameId = gameId,
          from: liveGameProvider,
          name: r'liveGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$liveGameHash,
          dependencies: LiveGameFamily._dependencies,
          allTransitiveDependencies: LiveGameFamily._allTransitiveDependencies,
          gameId: gameId,
        );

  LiveGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameId,
  }) : super.internal();

  final String gameId;

  @override
  FutureOr<Game> runNotifierBuild(
    covariant LiveGame notifier,
  ) {
    return notifier.build(
      gameId,
    );
  }

  @override
  Override overrideWith(LiveGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: LiveGameProvider._internal(
        () => create()..gameId = gameId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameId: gameId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LiveGame, Game> createElement() {
    return _LiveGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LiveGameProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LiveGameRef on AutoDisposeAsyncNotifierProviderRef<Game> {
  /// The parameter `gameId` of this provider.
  String get gameId;
}

class _LiveGameProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LiveGame, Game>
    with LiveGameRef {
  _LiveGameProviderElement(super.provider);

  @override
  String get gameId => (origin as LiveGameProvider).gameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

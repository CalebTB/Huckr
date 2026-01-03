// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_log_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playLogHash() => r'ea383e3b132284aa48b3770072c7c8bf200f22d0';

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

abstract class _$PlayLog extends BuildlessAutoDisposeNotifier<PlayLogState> {
  late final String gameId;

  PlayLogState build(
    String gameId,
  );
}

/// Provider for managing play history and possession chain
///
/// Handles adding players to chain, recording terminal events (goals, turnovers),
/// undo operations, and persistence to Hive with background Supabase sync
///
/// Copied from [PlayLog].
@ProviderFor(PlayLog)
const playLogProvider = PlayLogFamily();

/// Provider for managing play history and possession chain
///
/// Handles adding players to chain, recording terminal events (goals, turnovers),
/// undo operations, and persistence to Hive with background Supabase sync
///
/// Copied from [PlayLog].
class PlayLogFamily extends Family<PlayLogState> {
  /// Provider for managing play history and possession chain
  ///
  /// Handles adding players to chain, recording terminal events (goals, turnovers),
  /// undo operations, and persistence to Hive with background Supabase sync
  ///
  /// Copied from [PlayLog].
  const PlayLogFamily();

  /// Provider for managing play history and possession chain
  ///
  /// Handles adding players to chain, recording terminal events (goals, turnovers),
  /// undo operations, and persistence to Hive with background Supabase sync
  ///
  /// Copied from [PlayLog].
  PlayLogProvider call(
    String gameId,
  ) {
    return PlayLogProvider(
      gameId,
    );
  }

  @override
  PlayLogProvider getProviderOverride(
    covariant PlayLogProvider provider,
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
  String? get name => r'playLogProvider';
}

/// Provider for managing play history and possession chain
///
/// Handles adding players to chain, recording terminal events (goals, turnovers),
/// undo operations, and persistence to Hive with background Supabase sync
///
/// Copied from [PlayLog].
class PlayLogProvider
    extends AutoDisposeNotifierProviderImpl<PlayLog, PlayLogState> {
  /// Provider for managing play history and possession chain
  ///
  /// Handles adding players to chain, recording terminal events (goals, turnovers),
  /// undo operations, and persistence to Hive with background Supabase sync
  ///
  /// Copied from [PlayLog].
  PlayLogProvider(
    String gameId,
  ) : this._internal(
          () => PlayLog()..gameId = gameId,
          from: playLogProvider,
          name: r'playLogProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playLogHash,
          dependencies: PlayLogFamily._dependencies,
          allTransitiveDependencies: PlayLogFamily._allTransitiveDependencies,
          gameId: gameId,
        );

  PlayLogProvider._internal(
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
  PlayLogState runNotifierBuild(
    covariant PlayLog notifier,
  ) {
    return notifier.build(
      gameId,
    );
  }

  @override
  Override overrideWith(PlayLog Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayLogProvider._internal(
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
  AutoDisposeNotifierProviderElement<PlayLog, PlayLogState> createElement() {
    return _PlayLogProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayLogProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayLogRef on AutoDisposeNotifierProviderRef<PlayLogState> {
  /// The parameter `gameId` of this provider.
  String get gameId;
}

class _PlayLogProviderElement
    extends AutoDisposeNotifierProviderElement<PlayLog, PlayLogState>
    with PlayLogRef {
  _PlayLogProviderElement(super.provider);

  @override
  String get gameId => (origin as PlayLogProvider).gameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

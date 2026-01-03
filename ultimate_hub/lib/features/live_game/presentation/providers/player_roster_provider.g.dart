// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_roster_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerRosterHash() => r'17cb64658fd56f4a6bd98344e595aecb04bc75d4';

/// Provider for managing offense/defense player rosters
///
/// Handles add-as-you-score player management with separate offense and defense lists
/// Local state only (not persisted to Hive yet - Phase 2 feature)
///
/// Copied from [PlayerRoster].
@ProviderFor(PlayerRoster)
final playerRosterProvider =
    AutoDisposeNotifierProvider<PlayerRoster, PlayerRosterState>.internal(
  PlayerRoster.new,
  name: r'playerRosterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerRosterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlayerRoster = AutoDisposeNotifier<PlayerRosterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'player_roster_provider.g.dart';

/// Represents a player in the roster
@immutable
class RosterPlayer {
  final String id;
  final String name;
  final String? jerseyNumber;
  final String teamId;

  const RosterPlayer({
    required this.id,
    required this.name,
    this.jerseyNumber,
    required this.teamId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterPlayer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    final number = jerseyNumber != null ? ' #$jerseyNumber' : '';
    return '$name$number';
  }
}

/// State for player roster management
@immutable
class PlayerRosterState {
  final Map<String, List<RosterPlayer>> offenseRoster;
  final Map<String, List<RosterPlayer>> defenseRoster;

  const PlayerRosterState({
    this.offenseRoster = const {},
    this.defenseRoster = const {},
  });

  PlayerRosterState copyWith({
    Map<String, List<RosterPlayer>>? offenseRoster,
    Map<String, List<RosterPlayer>>? defenseRoster,
  }) {
    return PlayerRosterState(
      offenseRoster: offenseRoster ?? this.offenseRoster,
      defenseRoster: defenseRoster ?? this.defenseRoster,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerRosterState &&
          runtimeType == other.runtimeType &&
          mapEquals(offenseRoster, other.offenseRoster) &&
          mapEquals(defenseRoster, other.defenseRoster);

  @override
  int get hashCode => offenseRoster.hashCode ^ defenseRoster.hashCode;
}

/// Provider for managing offense/defense player rosters
///
/// Handles add-as-you-score player management with separate offense and defense lists
/// Local state only (not persisted to Hive yet - Phase 2 feature)
@riverpod
class PlayerRoster extends _$PlayerRoster {
  final _uuid = const Uuid();

  @override
  PlayerRosterState build() {
    return const PlayerRosterState();
  }

  /// Add a player to the roster
  void addPlayer({
    required String teamId,
    required String name,
    String? jerseyNumber,
    bool isDefense = false,
  }) {
    final player = RosterPlayer(
      id: _uuid.v4(),
      name: name,
      jerseyNumber: jerseyNumber,
      teamId: teamId,
    );

    if (isDefense) {
      final currentDefense = state.defenseRoster[teamId] ?? [];
      // Check if player already exists (by name and number)
      if (_playerExists(currentDefense, name, jerseyNumber)) return;

      final updatedDefense = {...state.defenseRoster};
      updatedDefense[teamId] = [...currentDefense, player];

      state = state.copyWith(defenseRoster: updatedDefense);
    } else {
      final currentOffense = state.offenseRoster[teamId] ?? [];
      // Check if player already exists (by name and number)
      if (_playerExists(currentOffense, name, jerseyNumber)) return;

      final updatedOffense = {...state.offenseRoster};
      updatedOffense[teamId] = [...currentOffense, player];

      state = state.copyWith(offenseRoster: updatedOffense);
    }
  }

  /// Remove a player from the roster
  void removePlayer(String playerId, {required bool isDefense}) {
    if (isDefense) {
      final updatedDefense = <String, List<RosterPlayer>>{};
      for (final entry in state.defenseRoster.entries) {
        updatedDefense[entry.key] =
            entry.value.where((p) => p.id != playerId).toList();
      }
      state = state.copyWith(defenseRoster: updatedDefense);
    } else {
      final updatedOffense = <String, List<RosterPlayer>>{};
      for (final entry in state.offenseRoster.entries) {
        updatedOffense[entry.key] =
            entry.value.where((p) => p.id != playerId).toList();
      }
      state = state.copyWith(offenseRoster: updatedOffense);
    }
  }

  /// Get offense roster for a team
  List<RosterPlayer> getOffenseRoster(String teamId) {
    return state.offenseRoster[teamId] ?? [];
  }

  /// Get defense roster for a team
  List<RosterPlayer> getDefenseRoster(String teamId) {
    return state.defenseRoster[teamId] ?? [];
  }

  /// Clear all rosters (useful for starting a new game)
  void clearAllRosters() {
    state = const PlayerRosterState();
  }

  /// Check if a player with the same name and number already exists
  bool _playerExists(
    List<RosterPlayer> roster,
    String name,
    String? jerseyNumber,
  ) {
    return roster.any((p) =>
        p.name == name &&
        (jerseyNumber == null || p.jerseyNumber == jerseyNumber));
  }
}

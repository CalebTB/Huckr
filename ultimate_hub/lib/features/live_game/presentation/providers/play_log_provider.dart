import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/core/enums/play_type.dart';
import 'package:ultimate_hub/core/providers/data_providers.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/play_repository.dart';
import 'package:uuid/uuid.dart';

part 'play_log_provider.g.dart';

/// Represents a player click in the possession chain
@immutable
class PlayerClick {
  final String playerId;
  final String playerName;
  final String? jerseyNumber;
  final String teamId;

  const PlayerClick({
    required this.playerId,
    required this.playerName,
    this.jerseyNumber,
    required this.teamId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerClick &&
          runtimeType == other.runtimeType &&
          playerId == other.playerId;

  @override
  int get hashCode => playerId.hashCode;

  @override
  String toString() {
    final number = jerseyNumber != null ? ' #$jerseyNumber' : '';
    return '$playerName$number';
  }
}

/// State for play log management
@immutable
class PlayLogState {
  final List<Play> plays;
  final List<PlayerClick> possessionChain;
  final bool isLoading;
  final String? error;

  const PlayLogState({
    this.plays = const [],
    this.possessionChain = const [],
    this.isLoading = false,
    this.error,
  });

  PlayLogState copyWith({
    List<Play>? plays,
    List<PlayerClick>? possessionChain,
    bool? isLoading,
    String? error,
  }) {
    return PlayLogState(
      plays: plays ?? this.plays,
      possessionChain: possessionChain ?? this.possessionChain,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayLogState &&
          runtimeType == other.runtimeType &&
          listEquals(plays, other.plays) &&
          listEquals(possessionChain, other.possessionChain) &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode =>
      plays.hashCode ^
      possessionChain.hashCode ^
      isLoading.hashCode ^
      error.hashCode;
}

/// Provider for managing play history and possession chain
///
/// Handles adding players to chain, recording terminal events (goals, turnovers),
/// undo operations, and persistence to Hive with background Supabase sync
@riverpod
class PlayLog extends _$PlayLog {
  PlayRepository get _repository => ref.read(playRepositoryProvider);
  final _uuid = const Uuid();

  @override
  PlayLogState build(String gameId) {
    // Load plays for this game on initialization (after provider is initialized)
    Future.microtask(() => _loadPlays(gameId));
    return const PlayLogState(isLoading: true);
  }

  Future<void> _loadPlays(String gameId) async {

    final result = await _repository.getPlaysForGame(gameId);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (plays) => state = state.copyWith(
        plays: plays,
        isLoading: false,
        error: null,
      ),
    );
  }

  /// Add a player to the possession chain
  void addPlayerToChain(PlayerClick player) {
    state = state.copyWith(
      possessionChain: [...state.possessionChain, player],
    );
  }

  /// Remove a player and all subsequent players from the chain
  /// Used for in-point undo
  void removePlayerFromChain(PlayerClick player) {
    final index = state.possessionChain.indexOf(player);
    if (index == -1) return;

    state = state.copyWith(
      possessionChain: state.possessionChain.sublist(0, index),
    );
  }

  /// Clear the possession chain (e.g., after point ends)
  void clearChain() {
    state = state.copyWith(possessionChain: []);
  }

  /// Record a goal and auto-track assists
  Future<void> recordGoal({
    required String gameId,
    required int currentPoint,
    String? zone,
  }) async {
    if (state.possessionChain.isEmpty) return;

    final scorer = state.possessionChain.last;
    final chain = state.possessionChain;

    // Auto-track assists from chain
    final assist = chain.length >= 2 ? chain[chain.length - 2] : null;
    final hockeyAssist = chain.length >= 3 ? chain[chain.length - 3] : null;

    // Store assist info in notes field for now
    String? notes;
    if (assist != null) {
      notes = 'Assist: ${assist.playerName}';
      if (hockeyAssist != null) {
        notes += ', Hockey Assist: ${hockeyAssist.playerName}';
      }
    }
    if (zone != null) {
      notes = notes != null ? '$notes | Zone: $zone' : 'Zone: $zone';
    }

    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: scorer.playerId,
      playerName: scorer.playerName,
      playerJerseyNumber: scorer.jerseyNumber != null
          ? int.tryParse(scorer.jerseyNumber!)
          : null,
      teamId: scorer.teamId,
      type: PlayType.goal,
      targetPlayerId: assist?.playerId,
      targetPlayerName: assist?.playerName,
      notes: notes,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
    clearChain();
  }

  /// Record a catch (touch tracking)
  Future<void> recordCatch({
    required String gameId,
    required int currentPoint,
  }) async {
    if (state.possessionChain.isEmpty) return;

    final catcher = state.possessionChain.last;

    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: catcher.playerId,
      playerName: catcher.playerName,
      playerJerseyNumber: catcher.jerseyNumber != null
          ? int.tryParse(catcher.jerseyNumber!)
          : null,
      teamId: catcher.teamId,
      type: PlayType.catch_,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
  }

  /// Record a turnover (drop, throwaway, stall, OB)
  Future<void> recordTurnover({
    required String gameId,
    required int currentPoint,
    required PlayType turnoverType,
    String? zone,
  }) async {
    if (state.possessionChain.isEmpty) return;

    final thrower = state.possessionChain.last;

    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: thrower.playerId,
      playerName: thrower.playerName,
      playerJerseyNumber: thrower.jerseyNumber != null
          ? int.tryParse(thrower.jerseyNumber!)
          : null,
      teamId: thrower.teamId,
      type: turnoverType,
      turnoverType: turnoverType.name,
      notes: zone != null ? 'Zone: $zone' : null,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
    clearChain();
  }

  /// Record a block or interception
  Future<void> recordDefensivePlay({
    required String gameId,
    required int currentPoint,
    required PlayerClick defender,
    required PlayType playType,
  }) async {
    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: defender.playerId,
      playerName: defender.playerName,
      playerJerseyNumber: defender.jerseyNumber != null
          ? int.tryParse(defender.jerseyNumber!)
          : null,
      teamId: defender.teamId,
      type: playType,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
    clearChain();
  }

  /// Record a pull
  Future<void> recordPull({
    required String gameId,
    required int currentPoint,
    required PlayerClick puller,
    String? zone,
  }) async {
    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: puller.playerId,
      playerName: puller.playerName,
      playerJerseyNumber: puller.jerseyNumber != null
          ? int.tryParse(puller.jerseyNumber!)
          : null,
      teamId: puller.teamId,
      type: PlayType.pull,
      notes: zone != null ? 'Zone: $zone' : null,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
  }

  /// Record a timeout
  Future<void> recordTimeout({
    required String gameId,
    required int currentPoint,
    required String teamId,
  }) async {
    final play = Play(
      id: _uuid.v4(),
      gameId: gameId,
      pointId: 'point-$currentPoint',
      playNumber: state.plays.length + 1,
      playerId: '',
      playerName: 'Team Timeout',
      teamId: teamId,
      type: PlayType.timeout,
      timestamp: DateTime.now(),
      isSynced: false,
    );

    await _recordPlay(play);
  }

  /// Undo the last play
  /// Optionally restores the possession chain if it was a terminal event
  Future<void> undoLastPlay() async {
    if (state.plays.isEmpty) return;

    final lastPlay = state.plays.last;

    // Delete from repository
    final result = await _repository.deletePlay(lastPlay.id);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (_) {
        // Remove from local state
        final updatedPlays = List<Play>.from(state.plays)..removeLast();
        state = state.copyWith(plays: updatedPlays, error: null);

        // Restore chain if it was a goal or turnover
        // Note: This is a simplified version - full implementation would need
        // to track chain history for proper restoration
        if (lastPlay.type == PlayType.goal || lastPlay.isTurnover) {
          // Chain restoration logic would go here
          // For now, we'll leave the chain empty and let user rebuild it
        }
      },
    );
  }

  /// Internal helper to record play and persist
  Future<void> _recordPlay(Play play) async {
    // Persist to repository (Hive + background Supabase sync)
    final result = await _repository.recordPlay(play);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (createdPlay) {
        // Add to local state
        state = state.copyWith(
          plays: [...state.plays, createdPlay],
          error: null,
        );
      },
    );
  }
}

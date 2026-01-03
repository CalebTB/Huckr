import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/core/enums/game_status.dart';
import 'package:ultimate_hub/core/providers/data_providers.dart';
import 'package:ultimate_hub/features/live_game/domain/repositories/game_repository.dart';

part 'live_game_provider.g.dart';

/// Provider for managing live game state
///
/// Handles game loading, score updates, possession changes, status transitions,
/// and persistence to Hive with background Supabase sync
@riverpod
class LiveGame extends _$LiveGame {
  GameRepository get _repository => ref.read(gameRepositoryProvider);

  @override
  Future<Game> build(String gameId) async {
    // Load game from repository on initialization
    final result = await _repository.getGame(gameId);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (game) => game,
    );
  }

  /// Start the game (warmup → inProgress)
  /// Records startedAt timestamp
  Future<void> startGame() async {
    final game = await future;
    final updatedGame = game.copyWith(
      status: GameStatus.warmup,
      startedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Transition from warmup to in progress
  Future<void> beginPlay() async {
    final game = await future;
    if (game.status != GameStatus.warmup) return;

    final updatedGame = game.copyWith(
      status: GameStatus.inProgress,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Increment score for a team
  Future<void> incrementScore(String teamId) async {
    final game = await future;

    final updatedGame = game.copyWith(
      homeScore: teamId == game.homeTeamId ? game.homeScore + 1 : game.homeScore,
      awayScore: teamId == game.awayTeamId ? game.awayScore + 1 : game.awayScore,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Decrement score for a team (used for undo)
  Future<void> decrementScore(String teamId) async {
    final game = await future;

    final updatedGame = game.copyWith(
      homeScore: teamId == game.homeTeamId && game.homeScore > 0
          ? game.homeScore - 1
          : game.homeScore,
      awayScore: teamId == game.awayTeamId && game.awayScore > 0
          ? game.awayScore - 1
          : game.awayScore,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// End the current point and prepare for next
  /// Increments currentPoint and swaps possession
  Future<void> endPoint() async {
    final game = await future;

    // Determine next possession (swap teams)
    final nextPossession = game.currentPossession == game.homeTeamId
        ? game.awayTeamId
        : game.homeTeamId;

    final updatedGame = game.copyWith(
      currentPoint: game.currentPoint + 1,
      currentPossession: nextPossession,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Update current possession
  Future<void> updatePossession(String teamId) async {
    final game = await future;
    final updatedGame = game.copyWith(
      currentPossession: teamId,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Activate halftime status and save halftime scores
  Future<void> startHalftime() async {
    final game = await future;
    final updatedGame = game.copyWith(
      status: GameStatus.halftime,
      halftimeStartedAt: DateTime.now(),
      halftimeHomeScore: game.homeScore,
      halftimeAwayScore: game.awayScore,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Resume from halftime
  Future<void> resumeFromHalftime() async {
    final game = await future;
    if (game.status != GameStatus.halftime) return;

    final updatedGame = game.copyWith(
      status: GameStatus.inProgress,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Activate soft cap
  Future<void> activateSoftCap() async {
    final game = await future;
    final updatedGame = game.copyWith(
      status: GameStatus.softCap,
      softCapStartedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Activate hard cap
  Future<void> activateHardCap() async {
    final game = await future;
    final updatedGame = game.copyWith(
      status: GameStatus.hardCap,
      hardCapStartedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Start a delay
  Future<void> startDelay() async {
    final game = await future;
    final updatedGame = game.copyWith(
      isDelayed: true,
      delayStartedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Resume from delay
  Future<void> resumeFromDelay() async {
    final game = await future;
    if (!game.isDelayed) return;

    final updatedGame = game.copyWith(
      isDelayed: false,
      status: GameStatus.inProgress,
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Complete the game
  /// Sets status to completed and records endedAt timestamp
  Future<void> completeGame() async {
    final game = await future;
    final updatedGame = game.copyWith(
      status: GameStatus.completed,
      endedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Update game notes (post-game notes for injuries, comments, etc.)
  Future<void> updateGameNotes(String notes) async {
    final game = await future;
    final updatedGame = game.copyWith(
      gameNotes: notes.trim().isEmpty ? null : notes.trim(),
      updatedAt: DateTime.now(),
    );
    await _updateGame(updatedGame);
  }

  /// Internal helper to update game and persist
  Future<void> _updateGame(Game game) async {
    // Optimistically update state
    state = AsyncData(game);

    // Persist to repository (Hive + background Supabase sync)
    final result = await _repository.updateGame(game);
    result.fold(
      (failure) {
        // Revert to previous state on failure
        state = AsyncError(failure, StackTrace.current);
      },
      (updatedGame) {
        // Confirm update with server response
        state = AsyncData(updatedGame);
      },
    );
  }
}

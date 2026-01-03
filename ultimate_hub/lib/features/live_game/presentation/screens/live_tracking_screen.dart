import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/enums/play_type.dart';
import '../../../../core/enums/game_status.dart';
import '../../domain/entities/game.dart';
import '../providers/live_game_provider.dart';
import '../providers/play_log_provider.dart';
import '../widgets/possession_chain.dart';
import '../widgets/player_roster_buttons.dart';
import '../widgets/terminal_outcome_buttons.dart';
import '../widgets/score_board.dart';
import '../widgets/play_by_play_feed.dart';
import '../widgets/simple_score_buttons.dart';

/// Live Tracking Screen - Name-clicking workflow
///
/// Refactored to use Riverpod providers and name-clicking UI
/// - PossessionChain: Visual player touch sequence
/// - PlayerRosterButtons: Grid of player names for clicking
/// - TerminalOutcomeButtons: Goal/Drop/Throwaway/etc
class LiveTrackingScreen extends ConsumerStatefulWidget {
  final String gameId;

  const LiveTrackingScreen({super.key, required this.gameId});

  @override
  ConsumerState<LiveTrackingScreen> createState() =>
      _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  // UI state only (not game state - that's in providers)
  bool _showPlayByPlay = false;
  final Stopwatch _gameStopwatch = Stopwatch();
  bool _isGameRunning = false;
  bool _trackPlayers = false; // Simple mode: optional player tracking
  Timer? _uiUpdateTimer;

  // Simple mode score history (for undo)
  final List<String> _simpleScoreHistory = [];

  // Timeout tracking (local state for now - TODO: move to Game entity)
  int _homeTimeouts = 2;
  int _awayTimeouts = 2;

  @override
  void initState() {
    super.initState();
    // Start game clock
    _gameStopwatch.start();
    _isGameRunning = true;

    // Start UI update timer to refresh countdown every second
    _startUiUpdateTimer();

    // Ensure game is in progress status
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final game = await ref.read(liveGameProvider(widget.gameId).future);
      if (game.status == GameStatus.scheduled || game.status == GameStatus.warmup) {
        print('🎮 Setting game to inProgress');
        await ref.read(liveGameProvider(widget.gameId).notifier).beginPlay();
      }
    });

    // Periodically check cap status (every 30 seconds)
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 30));
      if (!mounted) return false;
      final gameAsync = ref.read(liveGameProvider(widget.gameId));
      gameAsync.whenData((game) => _checkCapStatus(game));
      return mounted;
    });
  }

  @override
  void dispose() {
    _uiUpdateTimer?.cancel();
    _gameStopwatch.stop();
    super.dispose();
  }

  void _startUiUpdateTimer() {
    _uiUpdateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {}); // Trigger rebuild to update timer display
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameAsync = ref.watch(liveGameProvider(widget.gameId));

    return gameAsync.when(
      data: (game) => _buildGameScreen(game),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
              const SizedBox(height: 16),
              Text('Error loading game: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameScreen(game) {
    final playLogState = ref.watch(playLogProvider(widget.gameId));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(game),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
            // Score Board with integrated timer
            ScoreBoard(
              homeTeamName: game.homeTeamName,
              awayTeamName: game.awayTeamName,
              homeScore: game.homeScore,
              awayScore: game.awayScore,
              possession: game.currentPossession ?? game.homeTeamId,
              currentPoint: game.currentPoint,
              homeTimeouts: _homeTimeouts,
              awayTimeouts: _awayTimeouts,
              timeString: _getTimeString(game),
              timeLabel: _getTimeLabel(game),
              timerColor: _getTimerColor(game),
              capBadge: _getCapBadge(game),
              onTimerTap: _toggleGameClock,
              halftimeHomeScore: game.halftimeHomeScore,
              halftimeAwayScore: game.halftimeAwayScore,
              isHalftime: game.status == GameStatus.halftime,
            ),

            const SizedBox(height: 8),

            // SIMPLE MODE: Just score buttons
            if (!_trackPlayers)
              Expanded(
                child: SimpleScoreButtons(
                  homeTeamName: game.homeTeamName,
                  awayTeamName: game.awayTeamName,
                  onHomeScore: () => _handleSimpleScore(game, game.homeTeamId),
                  onAwayScore: () => _handleSimpleScore(game, game.awayTeamId),
                  onTimeout: () => _handleSimpleTimeout(game),
                  onUndo: _simpleScoreHistory.isNotEmpty
                      ? () => _handleSimpleUndo(game)
                      : null,
                ),
              ),

            // ADVANCED MODE: Player tracking UI
            if (_trackPlayers) ...[
              PossessionChain(
                gameId: widget.gameId,
                showPullIndicator: playLogState.possessionChain.isEmpty &&
                    game.currentPoint == 1,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PlayerRosterButtons(
                    gameId: widget.gameId,
                    teamId: game.currentPossession ?? game.homeTeamId,
                    isDefense: false,
                    onPlayerTap: (player) {
                      ref
                          .read(playLogProvider(widget.gameId).notifier)
                          .addPlayerToChain(player);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildPlayByPlayToggle(playLogState.plays.length),
              if (_showPlayByPlay)
                SizedBox(
                  height: 200,
                  child: PlayByPlayFeed(
                    plays: playLogState.plays
                        .map((p) => {
                              'type': p.type.displayName,
                              'playType': p.type,
                              'player': p.playerName ?? 'Unknown',
                              'timestamp': p.timestamp,
                            })
                        .toList(),
                  ),
                ),
              TerminalOutcomeButtons(
                chainIsEmpty: playLogState.possessionChain.isEmpty,
                onGoal: () => _handleGoal(game),
                onDrop: () => _handleTurnover(game, PlayType.drop),
                onThrowaway: () => _handleTurnover(game, PlayType.throwaway),
                onStall: () => _handleTurnover(game, PlayType.stall),
                onOutOfBounds: () => _handleTurnover(game, PlayType.outOfBounds),
                onBlock: () => _handleBlock(game),
                onTimeout: () => _handleTimeout(game),
              ),
            ],
          ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(game) {
    final playLogState = ref.watch(playLogProvider(widget.gameId));

    return AppBar(
      backgroundColor: AppTheme.background,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _showExitConfirmation(context, game),
      ),
      title: Text('Point ${game.currentPoint}'),
      actions: [
        // Toggle player tracking
        if (game.isSimpleTracking)
          IconButton(
            icon: Icon(
              _trackPlayers ? Icons.people : Icons.people_outline,
              color: _trackPlayers ? AppTheme.accent : null,
            ),
            onPressed: () => setState(() => _trackPlayers = !_trackPlayers),
            tooltip: _trackPlayers ? 'Disable Player Tracking' : 'Enable Player Tracking',
          ),
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: playLogState.plays.isNotEmpty
              ? () => _undoLastPlay(game)
              : null,
          tooltip: 'Undo',
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showGameMenu(context, game),
        ),
      ],
    );
  }

  Widget _buildPlayByPlayToggle(int playCount) {
    return InkWell(
      onTap: () => setState(() => _showPlayByPlay = !_showPlayByPlay),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showPlayByPlay
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              'Play by Play ($playCount)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // GAME LOGIC
  // ============================================

  void _toggleGameClock() {
    setState(() {
      if (_isGameRunning) {
        _gameStopwatch.stop();
      } else {
        _gameStopwatch.start();
      }
      _isGameRunning = !_isGameRunning;
    });
  }

  /// Calculate timer countdown string (MM:SS format)
  String _getTimeString(game) {
    final elapsed = _gameStopwatch.elapsed;
    final elapsedSeconds = elapsed.inSeconds;
    final softCapSeconds = (game.softCapMinutes as int) * 60;
    final hardCapSeconds = (game.hardCapMinutes as int) * 60;

    int remainingSeconds;

    if (elapsedSeconds >= hardCapSeconds) {
      // Hard cap reached - show overtime
      remainingSeconds = elapsedSeconds - hardCapSeconds;
    } else if (elapsedSeconds >= softCapSeconds) {
      // Counting down to hard cap
      remainingSeconds = hardCapSeconds - elapsedSeconds;
    } else {
      // Counting down to soft cap
      remainingSeconds = softCapSeconds - elapsedSeconds;
    }

    final minutes = remainingSeconds.abs() ~/ 60;
    final seconds = remainingSeconds.abs() % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get timer phase label
  String _getTimeLabel(game) {
    final elapsed = _gameStopwatch.elapsed;
    final elapsedSeconds = elapsed.inSeconds;
    final softCapSeconds = (game.softCapMinutes as int) * 60;
    final hardCapSeconds = (game.hardCapMinutes as int) * 60;

    if (elapsedSeconds >= hardCapSeconds) {
      return 'OVERTIME';
    } else if (elapsedSeconds >= softCapSeconds) {
      return 'TO HARD CAP';
    } else {
      return 'TO SOFT CAP';
    }
  }

  /// Get timer color based on cap status
  Color _getTimerColor(game) {
    final elapsed = _gameStopwatch.elapsed;
    final minutes = elapsed.inMinutes;

    if (minutes >= game.hardCapMinutes) {
      return AppTheme.error;
    } else if (minutes >= game.softCapMinutes) {
      return AppTheme.warning;
    } else if (minutes >= game.softCapMinutes - 5) {
      return AppTheme.accent;
    }
    return AppTheme.textPrimary;
  }

  /// Get cap badge text (null if no cap active)
  String? _getCapBadge(game) {
    final elapsed = _gameStopwatch.elapsed;
    final minutes = elapsed.inMinutes;

    if (minutes >= game.hardCapMinutes) {
      return 'HARD CAP';
    } else if (minutes >= game.softCapMinutes) {
      return 'SOFT CAP';
    }
    return null;
  }

  /// Check and update game status based on elapsed time (soft/hard cap)
  Future<void> _checkCapStatus(Game game) async {
    final elapsed = _gameStopwatch.elapsed;
    final minutes = elapsed.inMinutes;

    // Debug logging
    print('🔍 DEBUG: Checking cap status');
    print('   Score: ${game.homeScore}-${game.awayScore}, Halftime at: ${game.halftimeAt}');
    print('   Game status: ${game.status}');
    print('   Minutes elapsed: $minutes');

    // Check hard cap first
    if (minutes >= game.hardCapMinutes &&
        game.status != GameStatus.hardCap &&
        game.status != GameStatus.completed) {
      await ref.read(liveGameProvider(widget.gameId).notifier).activateHardCap();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🔴 HARD CAP - Next point wins!'),
            backgroundColor: AppTheme.error,
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
    // Then check soft cap
    else if (minutes >= game.softCapMinutes &&
        game.status != GameStatus.softCap &&
        game.status != GameStatus.hardCap &&
        game.status != GameStatus.completed) {
      await ref.read(liveGameProvider(widget.gameId).notifier).activateSoftCap();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '🟡 SOFT CAP - Play to ${game.homeScore > game.awayScore ? game.homeScore + 1 : game.awayScore + 1}'),
            backgroundColor: AppTheme.warning,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
    // Check halftime - when either team reaches halftimeAt points
    else if ((game.homeScore >= game.halftimeAt || game.awayScore >= game.halftimeAt) &&
        game.halftimeHomeScore == null &&
        game.status != GameStatus.completed &&
        game.status != GameStatus.cancelled) {
      print('✅ HALFTIME TRIGGERED!');

      // Capture current scores for notification (before async call)
      final halftimeHome = game.homeScore;
      final halftimeAway = game.awayScore;

      await ref.read(liveGameProvider(widget.gameId).notifier).startHalftime();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⏸️ Halftime - $halftimeHome-$halftimeAway'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handleGoal(game) async {
    final playLogNotifier = ref.read(playLogProvider(widget.gameId).notifier);
    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);

    // Clear halftime indicator when play resumes
    // Resume from halftime status if needed
    if (game.status == GameStatus.halftime) {
      await liveGameNotifier.resumeFromHalftime();
    }

    // Only track play details if player tracking is enabled
    if (_trackPlayers) {
      // Record goal with auto-tracked assists
      // Note: Zone tracking removed - can add Red Zone tracking later if needed
      await playLogNotifier.recordGoal(
        gameId: widget.gameId,
        currentPoint: game.currentPoint,
        zone: null,
      );
    }

    // Increment score
    final scoringTeamId = game.currentPossession ?? game.homeTeamId;
    await liveGameNotifier.incrementScore(scoringTeamId);

    // End point and swap possession
    await liveGameNotifier.endPoint();

    // Fetch updated game with new score
    final updatedGame = await ref.read(liveGameProvider(widget.gameId).future);

    // Check cap status with updated game
    await _checkCapStatus(updatedGame);

    // Check for game end
    if (updatedGame.homeScore >= updatedGame.gameToPoints ||
        updatedGame.awayScore >= updatedGame.gameToPoints) {
      _showGameEndDialog(updatedGame);
    }
  }

  Future<void> _handleTurnover(game, PlayType turnoverType) async {
    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);

    // Only record turnover if player tracking is enabled
    if (_trackPlayers) {
      final playLogNotifier = ref.read(playLogProvider(widget.gameId).notifier);
      await playLogNotifier.recordTurnover(
        gameId: widget.gameId,
        currentPoint: game.currentPoint,
        turnoverType: turnoverType,
      );
    }

    // Always swap possession
    final newPossession =
        game.currentPossession == game.homeTeamId ? game.awayTeamId : game.homeTeamId;
    await liveGameNotifier.updatePossession(newPossession);
  }

  Future<void> _handleBlock(game) async {
    if (!mounted) return;

    final defensiveTeamId = game.currentPossession == game.homeTeamId
        ? game.awayTeamId
        : game.homeTeamId;
    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);

    // If not tracking players, just swap possession
    if (!_trackPlayers) {
      await liveGameNotifier.updatePossession(defensiveTeamId);
      return;
    }

    // Show defense roster to select blocker
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Who got the block?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: PlayerRosterButtons(
                  gameId: widget.gameId,
                  teamId: defensiveTeamId,
                  isDefense: true,
                  onPlayerTap: (defender) async {
                    Navigator.of(context).pop();

                    final playLogNotifier =
                        ref.read(playLogProvider(widget.gameId).notifier);

                    // Record block
                    await playLogNotifier.recordDefensivePlay(
                      gameId: widget.gameId,
                      currentPoint: game.currentPoint,
                      defender: defender,
                      playType: PlayType.block,
                    );

                    // Swap possession
                    await liveGameNotifier.updatePossession(defensiveTeamId);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleTimeout(game) async {
    // Only record timeout if player tracking is enabled
    if (_trackPlayers) {
      final playLogNotifier = ref.read(playLogProvider(widget.gameId).notifier);
      await playLogNotifier.recordTimeout(
        gameId: widget.gameId,
        currentPoint: game.currentPoint,
        teamId: game.currentPossession ?? game.homeTeamId,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Timeout called'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // ============================================
  // SIMPLE MODE HANDLERS
  // ============================================

  Future<void> _handleSimpleScore(game, String teamId) async {
    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);

    // Clear halftime indicator when play resumes
    // Resume from halftime status if needed
    if (game.status == GameStatus.halftime) {
      await liveGameNotifier.resumeFromHalftime();
    }

    // Track for undo
    _simpleScoreHistory.add(teamId);

    // Increment score
    await liveGameNotifier.incrementScore(teamId);

    // Fetch updated game with new score
    final updatedGame = await ref.read(liveGameProvider(widget.gameId).future);

    // Check cap status with updated game
    await _checkCapStatus(updatedGame);

    // Check for game end
    if (updatedGame.homeScore >= updatedGame.gameToPoints ||
        updatedGame.awayScore >= updatedGame.gameToPoints) {
      _showGameEndDialog(updatedGame);
    }
  }

  void _handleSimpleTimeout(game) {
    // Determine which team called timeout (based on possession)
    final isHomeTimeout = game.currentPossession == game.homeTeamId;

    setState(() {
      if (isHomeTimeout && _homeTimeouts > 0) {
        _homeTimeouts--;
      } else if (!isHomeTimeout && _awayTimeouts > 0) {
        _awayTimeouts--;
      }
    });

    if (mounted) {
      final teamName = isHomeTimeout ? game.homeTeamName : game.awayTeamName;
      final remaining = isHomeTimeout ? _homeTimeouts : _awayTimeouts;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$teamName timeout ($remaining remaining)'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleSimpleUndo(game) async {
    if (_simpleScoreHistory.isEmpty) return;

    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);

    // Get last team that scored
    final lastScoringTeam = _simpleScoreHistory.removeLast();

    // Decrement their score
    await liveGameNotifier.decrementScore(lastScoringTeam);

    if (mounted) {
      final teamName = lastScoringTeam == game.homeTeamId
          ? game.homeTeamName
          : game.awayTeamName;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Undid $teamName score'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  // ============================================
  // ADVANCED MODE HANDLERS
  // ============================================

  Future<void> _undoLastPlay(game) async {
    final playLogNotifier = ref.read(playLogProvider(widget.gameId).notifier);
    final liveGameNotifier = ref.read(liveGameProvider(widget.gameId).notifier);
    final playLogState = ref.read(playLogProvider(widget.gameId));

    if (playLogState.plays.isEmpty) return;

    final lastPlay = playLogState.plays.last;

    // Undo the play
    await playLogNotifier.undoLastPlay();

    // Reverse game state changes
    if (lastPlay.type == PlayType.goal) {
      // Decrement score
      await liveGameNotifier.decrementScore(lastPlay.teamId);

      // Note: In a full implementation, we'd restore the previous point
      // For now, we'll just show a message
    } else if (lastPlay.type.isTurnover || lastPlay.type.isDefensivePlay) {
      // Swap possession back
      final previousPossession =
          game.currentPossession == game.homeTeamId ? game.awayTeamId : game.homeTeamId;
      await liveGameNotifier.updatePossession(previousPossession);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Undid: ${lastPlay.type.displayName}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _showExitConfirmation(BuildContext context, game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Game?'),
        content: const Text(
          'Are you sure you want to exit? Game progress has been saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/game/summary/${widget.gameId}');
            },
            child: const Text('Save & Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  void _showGameMenu(BuildContext context, game) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Change Possession'),
                onTap: () async {
                  Navigator.pop(context);
                  final newPossession = game.currentPossession == game.homeTeamId
                      ? game.awayTeamId
                      : game.homeTeamId;
                  await ref
                      .read(liveGameProvider(widget.gameId).notifier)
                      .updatePossession(newPossession);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.flag, color: AppTheme.accent),
                title: const Text('End Game'),
                onTap: () {
                  Navigator.pop(context);
                  _showGameEndDialog(game);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showGameEndDialog(game) async {
    final notesController = TextEditingController();

    // Fetch latest game state to ensure we have halftime scores
    final latestGame = await ref.read(liveGameProvider(widget.gameId).future);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Game'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Final Score: ${latestGame.homeTeamName} ${latestGame.homeScore} - ${latestGame.awayScore} ${latestGame.awayTeamName}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            if (latestGame.halftimeHomeScore != null && latestGame.halftimeAwayScore != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Halftime: ${latestGame.halftimeHomeScore}-${latestGame.halftimeAwayScore}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Game Notes (optional)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: notesController,
              maxLines: 3,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: 'Injuries, notable plays, comments...',
                hintStyle: TextStyle(color: AppTheme.textTertiary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.primaryGreen),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Continue Playing'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Save notes if provided
              if (notesController.text.trim().isNotEmpty) {
                await ref
                    .read(liveGameProvider(widget.gameId).notifier)
                    .updateGameNotes(notesController.text);
              }

              // Mark game as completed
              await ref
                  .read(liveGameProvider(widget.gameId).notifier)
                  .completeGame();

              if (context.mounted) {
                Navigator.pop(context);
                context.go('/game/summary/${widget.gameId}');
              }
            },
            child: const Text('End Game'),
          ),
        ],
      ),
    );
  }
}

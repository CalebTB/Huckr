import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/enums/play_type.dart';
import '../widgets/field_canvas.dart';
import '../widgets/score_board.dart';
import '../widgets/game_clock.dart';
import '../widgets/action_buttons.dart';
import '../widgets/play_by_play_feed.dart';

/// Live Tracking Screen - Main game tracking interface
/// ESPN-style live tracking with field visualization
class LiveTrackingScreen extends ConsumerStatefulWidget {
  final String gameId;
  
  const LiveTrackingScreen({super.key, required this.gameId});

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  // Game state (will be moved to Riverpod provider)
  int _homeScore = 0;
  int _awayScore = 0;
  int _currentPoint = 1;
  final String _homeTeamName = 'Home';
  final String _awayTeamName = 'Away';
  String _possession = 'home'; // 'home' or 'away'

  // Field tracking state
  double? _discX;
  double? _discY;
  // ignore: unused_field - will be used for player tracking
  String? _selectedPlayerId;
  String? _selectedPlayerName;
  
  // UI state
  bool _showPlayByPlay = false;
  bool _isLandscape = false;
  
  // Mock plays for demo
  final List<Map<String, dynamic>> _plays = [];
  
  // Game clock
  final Stopwatch _gameStopwatch = Stopwatch();
  bool _isGameRunning = false;
  
  @override
  void initState() {
    super.initState();
    // Start game clock
    _gameStopwatch.start();
    _isGameRunning = true;
  }
  
  @override
  void dispose() {
    _gameStopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    if (_isLandscape) {
      return _buildLandscapeLayout();
    }
    return _buildPortraitLayout();
  }

  /// Portrait layout - optimized for one-handed tracking
  Widget _buildPortraitLayout() {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Score Board
          ScoreBoard(
            homeTeamName: _homeTeamName,
            awayTeamName: _awayTeamName,
            homeScore: _homeScore,
            awayScore: _awayScore,
            possession: _possession,
            currentPoint: _currentPoint,
          ),
          
          // Game Clock
          GameClock(
            stopwatch: _gameStopwatch,
            isRunning: _isGameRunning,
            onToggle: _toggleGameClock,
          ),
          
          const SizedBox(height: 8),
          
          // Field Canvas
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FieldCanvas(
                discX: _discX,
                discY: _discY,
                possession: _possession,
                homeTeamName: _homeTeamName,
                awayTeamName: _awayTeamName,
                onFieldTap: _handleFieldTap,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          ActionButtons(
            onAction: _handleAction,
            possession: _possession,
            hasDiscPosition: _discX != null,
          ),
          
          const SizedBox(height: 16),
          
          // Play By Play Toggle
          _buildPlayByPlayToggle(),
          
          // Play By Play Feed (expandable)
          if (_showPlayByPlay)
            SizedBox(
              height: 200,
              child: PlayByPlayFeed(plays: _plays),
            ),
        ],
      ),
    );
  }

  /// Landscape layout - optimized for two-person tracking or tablets
  Widget _buildLandscapeLayout() {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Row(
          children: [
            // Left panel - Score and Controls
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  // Back button and game info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _showExitConfirmation(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Point $_currentPoint',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  
                  // Scores
                  _buildCompactScoreBoard(),
                  
                  const SizedBox(height: 16),
                  
                  // Clock
                  GameClock(
                    stopwatch: _gameStopwatch,
                    isRunning: _isGameRunning,
                    onToggle: _toggleGameClock,
                    compact: true,
                  ),
                  
                  const Divider(height: 32),
                  
                  // Action buttons (vertical)
                  Expanded(
                    child: ActionButtons(
                      onAction: _handleAction,
                      possession: _possession,
                      hasDiscPosition: _discX != null,
                      vertical: true,
                    ),
                  ),
                ],
              ),
            ),
            
            // Divider
            const VerticalDivider(width: 1),
            
            // Center - Field
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FieldCanvas(
                  discX: _discX,
                  discY: _discY,
                  possession: _possession,
                  homeTeamName: _homeTeamName,
                  awayTeamName: _awayTeamName,
                  onFieldTap: _handleFieldTap,
                  landscape: true,
                ),
              ),
            ),
            
            // Divider
            const VerticalDivider(width: 1),
            
            // Right panel - Play by Play
            SizedBox(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Play by Play',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Expanded(
                    child: PlayByPlayFeed(plays: _plays),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.primaryDark,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _showExitConfirmation(context),
      ),
      title: Text('Point $_currentPoint'),
      actions: [
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: _plays.isNotEmpty ? _undoLastPlay : null,
          tooltip: 'Undo',
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showGameMenu(context),
        ),
      ],
    );
  }

  Widget _buildCompactScoreBoard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCompactTeamScore(_homeTeamName, _homeScore, _possession == 'home'),
          Text(
            '-',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          _buildCompactTeamScore(_awayTeamName, _awayScore, _possession == 'away'),
        ],
      ),
    );
  }

  Widget _buildCompactTeamScore(String name, int score, bool hasPossession) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: hasPossession ? AppTheme.primaryGreen : AppTheme.gray400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: hasPossession ? AppTheme.primaryGreen : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (hasPossession)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildPlayByPlayToggle() {
    return InkWell(
      onTap: () => setState(() => _showPlayByPlay = !_showPlayByPlay),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showPlayByPlay ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              color: AppTheme.gray400,
            ),
            const SizedBox(width: 8),
            Text(
              'Play by Play (${_plays.length})',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.gray400,
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

  void _handleFieldTap(double x, double y) {
    setState(() {
      _discX = x;
      _discY = y;
    });
    
    // Show player selector for the team with possession
    _showPlayerSelector();
  }

  void _handleAction(PlayType action) {
    if (_discX == null && action != PlayType.timeout) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tap on the field to mark disc position first'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    // Record the play
    final play = {
      'type': action.displayName,
      'playType': action,
      'x': _discX,
      'y': _discY,
      'timestamp': DateTime.now(),
      'player': _selectedPlayerName ?? 'Unknown',
      'possession': _possession,
    };
    
    setState(() {
      _plays.insert(0, play);
      
      // Handle action outcomes
      switch (action) {
        case PlayType.goal:
          _handleGoal();
          break;
        case PlayType.callahan:
          _handleCallahan();
          break;
        case PlayType.drop:
        case PlayType.throwaway:
        case PlayType.stall:
        case PlayType.outOfBounds:
          _handleTurnover();
          break;
        case PlayType.block:
        case PlayType.interception:
          _handleDefensivePlay();
          break;
        case PlayType.catch_:
          // Just record the catch, possession stays
          break;
        case PlayType.pull:
          // Reset disc position for pull
          _discX = null;
          _discY = null;
          break;
        default:
          break;
      }
      
      // Clear selected player after action
      _selectedPlayerId = null;
      _selectedPlayerName = null;
    });
  }

  void _handleGoal() {
    if (_possession == 'home') {
      _homeScore++;
    } else {
      _awayScore++;
    }
    
    // Start new point
    _currentPoint++;
    _discX = null;
    _discY = null;
    
    // Check for game end
    if (_homeScore >= 15 || _awayScore >= 15) {
      _showGameEndDialog();
    }
  }

  void _handleCallahan() {
    // Callahan is caught by defense, so opposite team scores
    if (_possession == 'home') {
      _awayScore++;
    } else {
      _homeScore++;
    }
    
    // Swap possession for next point
    _possession = _possession == 'home' ? 'away' : 'home';
    
    _currentPoint++;
    _discX = null;
    _discY = null;
  }

  void _handleTurnover() {
    // Swap possession
    _possession = _possession == 'home' ? 'away' : 'home';
  }

  void _handleDefensivePlay() {
    // Swap possession
    _possession = _possession == 'home' ? 'away' : 'home';
  }

  void _undoLastPlay() {
    if (_plays.isEmpty) return;
    
    final lastPlay = _plays.removeAt(0);
    
    setState(() {
      // Reverse the action effects
      final playType = lastPlay['playType'] as PlayType;
      
      switch (playType) {
        case PlayType.goal:
          if (lastPlay['possession'] == 'home') {
            _homeScore--;
          } else {
            _awayScore--;
          }
          _currentPoint--;
          break;
        case PlayType.callahan:
          if (lastPlay['possession'] == 'home') {
            _awayScore--;
          } else {
            _homeScore--;
          }
          _currentPoint--;
          _possession = lastPlay['possession'] as String;
          break;
        case PlayType.drop:
        case PlayType.throwaway:
        case PlayType.stall:
        case PlayType.outOfBounds:
        case PlayType.block:
        case PlayType.interception:
          // Reverse possession change
          _possession = lastPlay['possession'] as String;
          break;
        default:
          break;
      }
      
      // Restore disc position
      _discX = lastPlay['x'] as double?;
      _discY = lastPlay['y'] as double?;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Undid: ${lastPlay['type']}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showPlayerSelector() {
    // TODO: Show player selector modal
    // For now, we'll skip this step
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Game?'),
        content: const Text(
          'Are you sure you want to exit? Game progress will be saved locally.',
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

  void _showGameMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Timeout'),
              onTap: () {
                Navigator.pop(context);
                _handleAction(PlayType.timeout);
              },
            ),
            ListTile(
              leading: const Icon(Icons.healing),
              title: const Text('Injury Stoppage'),
              onTap: () {
                Navigator.pop(context);
                _handleAction(PlayType.injury);
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Change Possession'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _possession = _possession == 'home' ? 'away' : 'home';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Score'),
              onTap: () {
                Navigator.pop(context);
                _showEditScoreDialog();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.flag, color: AppTheme.accentOrange),
              title: const Text('End Game'),
              onTap: () {
                Navigator.pop(context);
                _showGameEndDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditScoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        int tempHome = _homeScore;
        int tempAway = _awayScore;
        
        return AlertDialog(
          title: const Text('Edit Score'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home score
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_homeTeamName),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => setDialogState(() => tempHome--),
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$tempHome',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          IconButton(
                            onPressed: () => setDialogState(() => tempHome++),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Away score
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_awayTeamName),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => setDialogState(() => tempAway--),
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$tempAway',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          IconButton(
                            onPressed: () => setDialogState(() => tempAway++),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _homeScore = tempHome;
                  _awayScore = tempAway;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showGameEndDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Game'),
        content: Text(
          'Final Score: $_homeTeamName $_homeScore - $_awayScore $_awayTeamName\n\n'
          'Save and view game summary?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Playing'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/game/summary/${widget.gameId}');
            },
            child: const Text('End Game'),
          ),
        ],
      ),
    );
  }
}

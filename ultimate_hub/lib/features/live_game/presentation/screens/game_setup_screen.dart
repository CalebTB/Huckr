import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/wind_conditions.dart';
import '../../../../core/constants/game_rules.dart';
import '../../../../core/providers/data_providers.dart';
import '../../../../core/enums/game_status.dart';
import '../../domain/entities/game.dart';

/// Game Setup Screen - Configure game before tracking
class GameSetupScreen extends ConsumerStatefulWidget {
  const GameSetupScreen({super.key});

  @override
  ConsumerState<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends ConsumerState<GameSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _homeTeamController = TextEditingController();
  final _awayTeamController = TextEditingController();
  
  // Game settings
  int _gameToPoints = 15;
  int _hardCapPoints = 17;
  int _softCapMinutes = 75;
  int _hardCapMinutes = 90;
  
  // Wind conditions
  String _windSpeed = 'calm';
  String _windDirection = 'N';

  // Which team is tracking
  String _trackingFor = 'home'; // 'home' or 'away'

  // Tracking mode
  bool _isSimpleTracking = true; // true = simple, false = advanced

  // Loading state
  bool _isCreating = false;
  
  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Game'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Teams Section
            const _SectionHeader(title: 'Teams'),
            const SizedBox(height: 16),
            
            // Home Team
            _TeamInput(
              controller: _homeTeamController,
              label: 'Home Team',
              hint: 'Enter team name',
              isTracking: _trackingFor == 'home',
              onTrackingChanged: () => setState(() => _trackingFor = 'home'),
            ),
            const SizedBox(height: 16),
            
            // VS Divider
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VS',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.gray500,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            
            // Away Team
            _TeamInput(
              controller: _awayTeamController,
              label: 'Away Team',
              hint: 'Enter team name',
              isTracking: _trackingFor == 'away',
              onTrackingChanged: () => setState(() => _trackingFor = 'away'),
            ),

            const SizedBox(height: 32),

            // Tracking Mode Section
            const _SectionHeader(title: 'Tracking Mode'),
            const SizedBox(height: 16),

            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Simple'),
                  icon: Icon(Icons.speed),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Advanced'),
                  icon: Icon(Icons.analytics),
                ),
              ],
              selected: {_isSimpleTracking},
              onSelectionChanged: (Set<bool> selected) {
                setState(() => _isSimpleTracking = selected.first);
              },
            ),
            const SizedBox(height: 8),
            Text(
              _isSimpleTracking
                  ? 'Quick score tracking with goal scorers & assists'
                  : 'Full stats: pulls, field position, assists, play-by-play',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.gray500,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Game Settings Section
            const _SectionHeader(title: 'Game Settings'),
            const SizedBox(height: 16),
            
            // Game To Points
            _SettingRow(
              title: 'Game to',
              value: '$_gameToPoints points',
              onTap: () => _showNumberPicker(
                context: context,
                title: 'Game To Points',
                currentValue: _gameToPoints,
                min: 9,
                max: 21,
                onSelected: (v) => setState(() => _gameToPoints = v),
              ),
            ),
            
            // Hard Cap Points
            _SettingRow(
              title: 'Hard Cap',
              value: '$_hardCapPoints points',
              onTap: () => _showNumberPicker(
                context: context,
                title: 'Hard Cap Points',
                currentValue: _hardCapPoints,
                min: _gameToPoints,
                max: 25,
                onSelected: (v) => setState(() => _hardCapPoints = v),
              ),
            ),
            
            // Soft Cap Time
            _SettingRow(
              title: 'Soft Cap',
              value: '$_softCapMinutes min',
              onTap: () => _showNumberPicker(
                context: context,
                title: 'Soft Cap (minutes)',
                currentValue: _softCapMinutes,
                min: 30,
                max: 120,
                step: 5,
                onSelected: (v) => setState(() => _softCapMinutes = v),
              ),
            ),
            
            // Hard Cap Time
            _SettingRow(
              title: 'Hard Cap Time',
              value: '$_hardCapMinutes min',
              onTap: () => _showNumberPicker(
                context: context,
                title: 'Hard Cap Time (minutes)',
                currentValue: _hardCapMinutes,
                min: _softCapMinutes,
                max: 150,
                step: 5,
                onSelected: (v) => setState(() => _hardCapMinutes = v),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Wind Conditions Section
            const _SectionHeader(title: 'Conditions (Optional)'),
            const SizedBox(height: 16),
            
            // Wind Speed
            _SettingRow(
              title: 'Wind Speed',
              value: WindConditions.speedDescriptions[_windSpeed] ?? 'Unknown',
              onTap: () => _showWindSpeedPicker(context),
            ),
            
            // Wind Direction
            _SettingRow(
              title: 'Wind Direction',
              value: _windDirection,
              onTap: () => _showWindDirectionPicker(context),
            ),
            
            const SizedBox(height: 48),
            
            // Start Game Button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isCreating ? null : _startGame,
                child: _isCreating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text('Start Tracking'),
                        ],
                      ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Quick Start Option
            Center(
              child: TextButton(
                onPressed: _quickStart,
                child: const Text('Quick Start (use defaults)'),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _startGame() async {
    // Set default team names if empty
    if (_homeTeamController.text.isEmpty) {
      _homeTeamController.text = 'Home Team';
    }
    if (_awayTeamController.text.isEmpty) {
      _awayTeamController.text = 'Away Team';
    }

    // Set loading state
    setState(() => _isCreating = true);

    try {
      // Generate IDs
      final gameId = const Uuid().v4();
      final homeTeamId = const Uuid().v4();
      final awayTeamId = const Uuid().v4();
      final now = DateTime.now();

      // Create Game entity
      final game = Game(
        id: gameId,
        homeTeamId: homeTeamId,
        awayTeamId: awayTeamId,
        homeTeamName: _homeTeamController.text,
        awayTeamName: _awayTeamController.text,
        homeScore: 0,
        awayScore: 0,
        gameToPoints: _gameToPoints,
        originalGameToPoints: _gameToPoints, // Store original for halftime calculation
        hardCapPoints: _hardCapPoints,
        // halftimeAt is now calculated dynamically: (_gameToPoints / 2).ceil()
        softCapMinutes: _softCapMinutes,
        hardCapMinutes: _hardCapMinutes,
        status: GameStatus.scheduled,
        currentPoint: 1,
        windSpeed: _windSpeed != 'calm' ? _windSpeed : null,
        windDirection: _windDirection,
        isBeingTracked: true,
        isSimpleTracking: _isSimpleTracking,
        isSynced: false,
        createdAt: now,
        updatedAt: now,
        isDelayed: false,
      );

      // Persist game using repository
      final repository = ref.read(gameRepositoryProvider);
      final result = await repository.createGame(game);

      result.fold(
        // Error case
        (failure) {
          if (mounted) {
            setState(() => _isCreating = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to create game: ${failure.message}'),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: _startGame,
                ),
              ),
            );
          }
        },
        // Success case
        (createdGame) {
          if (mounted) {
            setState(() => _isCreating = false);
            context.go('/game/track/${createdGame.id}');
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isCreating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _quickStart() {
    _homeTeamController.text = 'Home';
    _awayTeamController.text = 'Away';
    _startGame();
  }

  void _showNumberPicker({
    required BuildContext context,
    required String title,
    required int currentValue,
    required int min,
    required int max,
    int step = 1,
    required Function(int) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: ((max - min) ~/ step) + 1,
                  itemBuilder: (context, index) {
                    final value = min + (index * step);
                    final isSelected = value == currentValue;
                    return ListTile(
                      title: Text(
                        '$value',
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? AppTheme.primaryGreen : null,
                        ),
                      ),
                      trailing: isSelected 
                          ? const Icon(Icons.check, color: AppTheme.primaryGreen)
                          : null,
                      onTap: () {
                        onSelected(value);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWindSpeedPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wind Speed',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ...WindConditions.speedDescriptions.entries.map((entry) {
                final isSelected = entry.key == _windSpeed;
                return ListTile(
                  title: Text(entry.value),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppTheme.primaryGreen)
                      : null,
                  onTap: () {
                    setState(() => _windSpeed = entry.key);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showWindDirectionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wind Direction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: WindConditions.directions.map((dir) {
                  final isSelected = dir == _windDirection;
                  return ChoiceChip(
                    label: Text(dir),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _windDirection = dir);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

/// Section Header Widget
class _SectionHeader extends StatelessWidget {
  final String title;
  
  const _SectionHeader({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppTheme.gray400,
      ),
    );
  }
}

/// Team Input Widget
class _TeamInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isTracking;
  final VoidCallback onTrackingChanged;
  
  const _TeamInput({
    required this.controller,
    required this.label,
    required this.hint,
    required this.isTracking,
    required this.onTrackingChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  prefixIcon: const Icon(Icons.group),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTrackingChanged,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isTracking ? Icons.radio_button_checked : Icons.radio_button_off,
                  size: 20,
                  color: isTracking ? AppTheme.primaryGreen : AppTheme.gray500,
                ),
                const SizedBox(width: 8),
                Text(
                  'I\'m tracking for this team',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isTracking ? AppTheme.primaryGreen : AppTheme.gray500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Setting Row Widget
class _SettingRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  
  const _SettingRow({
    required this.title,
    required this.value,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.gray700.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.gray500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

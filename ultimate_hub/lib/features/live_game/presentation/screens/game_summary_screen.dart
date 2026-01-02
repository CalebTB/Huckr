import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

/// Game Summary Screen - Post-game stats and summary
class GameSummaryScreen extends ConsumerWidget {
  final String gameId;
  
  const GameSummaryScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Load game data from provider
    // For now, using mock data
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Summary'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareGame(context),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptions(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Final Score Card
            const _FinalScoreCard(
              homeTeamName: 'Home Team',
              awayTeamName: 'Away Team',
              homeScore: 15,
              awayScore: 12,
              duration: Duration(minutes: 82),
            ),
            
            const SizedBox(height: 24),
            
            // Game Stats
            _GameStatsSection(),
            
            const SizedBox(height: 24),
            
            // Team Comparison
            _TeamComparisonSection(),
            
            const SizedBox(height: 24),
            
            // Point Flow
            _PointFlowSection(),
            
            const SizedBox(height: 24),
            
            // Player Stats
            _PlayerStatsSection(),
            
            const SizedBox(height: 32),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _saveAndUpload(context),
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Save & Upload'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _exportStats(context),
                      icon: const Icon(Icons.download),
                      label: const Text('Export Stats'),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  void _shareGame(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Game'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit game
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Duplicate Game'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppTheme.error),
              title: const Text('Delete Game', 
                style: TextStyle(color: AppTheme.error)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Game?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _saveAndUpload(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Game saved! Upload will sync when online.')),
    );
  }

  void _exportStats(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Export Format',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('CSV'),
              subtitle: const Text('Spreadsheet format'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting CSV...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
              subtitle: const Text('Printable report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating PDF...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('JSON'),
              subtitle: const Text('Raw data format'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting JSON...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Final Score Card
class _FinalScoreCard extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final int homeScore;
  final int awayScore;
  final Duration duration;
  
  const _FinalScoreCard({
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeScore,
    required this.awayScore,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final homeWon = homeScore > awayScore;
    final awayWon = awayScore > homeScore;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen.withValues(alpha: 0.2),
            AppTheme.accentBlue.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // Final label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'FINAL',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Scores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home team
              Expanded(
                child: Column(
                  children: [
                    Text(
                      homeTeamName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: homeWon ? Colors.white : AppTheme.gray400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$homeScore',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: homeWon ? AppTheme.primaryGreen : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (homeWon)
                      const Icon(Icons.emoji_events, color: AppTheme.accentOrange),
                  ],
                ),
              ),
              
              // Divider
              Container(
                height: 80,
                width: 2,
                color: AppTheme.gray700,
              ),
              
              // Away team
              Expanded(
                child: Column(
                  children: [
                    Text(
                      awayTeamName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: awayWon ? Colors.white : AppTheme.gray400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$awayScore',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: awayWon ? AppTheme.primaryGreen : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (awayWon)
                      const Icon(Icons.emoji_events, color: AppTheme.accentOrange),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Duration
          Text(
            'Duration: ${duration.inMinutes} minutes',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Game Stats Section
class _GameStatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Game Stats',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: _StatCard(label: 'Total Points', value: '27')),
              SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'Total Turnovers', value: '18')),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: _StatCard(label: 'Breaks', value: '5')),
              SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'Clean Holds', value: '12')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Team Comparison Section
class _TeamComparisonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team Comparison',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                _ComparisonRow(
                  label: 'Turnovers',
                  homeValue: 8,
                  awayValue: 10,
                  lowerIsBetter: true,
                ),
                Divider(height: 24),
                _ComparisonRow(
                  label: 'Breaks',
                  homeValue: 3,
                  awayValue: 2,
                  lowerIsBetter: false,
                ),
                Divider(height: 24),
                _ComparisonRow(
                  label: 'Hold %',
                  homeValue: 85,
                  awayValue: 75,
                  lowerIsBetter: false,
                  isPercentage: true,
                ),
                Divider(height: 24),
                _ComparisonRow(
                  label: 'Blocks',
                  homeValue: 5,
                  awayValue: 3,
                  lowerIsBetter: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String label;
  final num homeValue;
  final num awayValue;
  final bool lowerIsBetter;
  final bool isPercentage;
  
  const _ComparisonRow({
    required this.label,
    required this.homeValue,
    required this.awayValue,
    required this.lowerIsBetter,
    this.isPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final homeBetter = lowerIsBetter 
        ? homeValue < awayValue 
        : homeValue > awayValue;
    final awayBetter = lowerIsBetter 
        ? awayValue < homeValue 
        : awayValue > homeValue;
    
    final suffix = isPercentage ? '%' : '';
    
    return Row(
      children: [
        // Home value
        Expanded(
          child: Text(
            '$homeValue$suffix',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: homeBetter ? AppTheme.primaryGreen : Colors.white,
              fontWeight: homeBetter ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        
        // Label
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.gray400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        // Away value
        Expanded(
          child: Text(
            '$awayValue$suffix',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: awayBetter ? AppTheme.primaryGreen : Colors.white,
              fontWeight: awayBetter ? FontWeight.w700 : FontWeight.w400,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

/// Point Flow Section - Visual representation of scoring
class _PointFlowSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock point flow data - TODO: Will be used when chart is implemented
    // final points = [
    //   {'home': 1, 'away': 0, 'break': false},
    //   {'home': 1, 'away': 1, 'break': false},
    //   {'home': 2, 'away': 1, 'break': false},
    //   {'home': 2, 'away': 2, 'break': false},
    //   {'home': 3, 'away': 2, 'break': true},
    //   {'home': 4, 'away': 2, 'break': false},
    // ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Point Flow',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Point flow chart coming soon',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.gray500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Player Stats Section
class _PlayerStatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock player stats
    final players = [
      {'name': 'Player 1', 'goals': 3, 'assists': 2, 'blocks': 1, 'turns': 1},
      {'name': 'Player 2', 'goals': 2, 'assists': 4, 'blocks': 0, 'turns': 2},
      {'name': 'Player 3', 'goals': 1, 'assists': 1, 'blocks': 3, 'turns': 0},
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Player Stats',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.gray400,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to full stats view
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Player',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.gray500,
                          ),
                        ),
                      ),
                      ..._buildStatHeaders(context, ['G', 'A', 'D', 'T']),
                    ],
                  ),
                ),
                const Divider(height: 1),
                
                // Player rows
                ...players.map((player) => _PlayerStatRow(
                  name: player['name'] as String,
                  goals: player['goals'] as int,
                  assists: player['assists'] as int,
                  blocks: player['blocks'] as int,
                  turnovers: player['turns'] as int,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStatHeaders(BuildContext context, List<String> headers) {
    return headers.map((h) => SizedBox(
      width: 40,
      child: Text(
        h,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.gray500,
        ),
        textAlign: TextAlign.center,
      ),
    )).toList();
  }
}

class _PlayerStatRow extends StatelessWidget {
  final String name;
  final int goals;
  final int assists;
  final int blocks;
  final int turnovers;
  
  const _PlayerStatRow({
    required this.name,
    required this.goals,
    required this.assists,
    required this.blocks,
    required this.turnovers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          _StatCell(value: goals, highlight: goals > 0),
          _StatCell(value: assists, highlight: assists > 0),
          _StatCell(value: blocks, highlight: blocks > 0, color: AppTheme.accentBlue),
          _StatCell(value: turnovers, highlight: turnovers > 0, color: AppTheme.error),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final int value;
  final bool highlight;
  final Color? color;
  
  const _StatCell({
    required this.value,
    required this.highlight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final displayColor = highlight 
        ? (color ?? AppTheme.primaryGreen) 
        : AppTheme.gray500;
    
    return SizedBox(
      width: 40,
      child: Text(
        '$value',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: displayColor,
          fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

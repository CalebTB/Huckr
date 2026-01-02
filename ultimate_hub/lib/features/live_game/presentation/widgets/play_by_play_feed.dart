import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/enums/play_type.dart';

/// Play by Play Feed - Shows live feed of game events
class PlayByPlayFeed extends StatelessWidget {
  final List<Map<String, dynamic>> plays;
  final bool showTimestamps;
  final ScrollController? scrollController;
  
  const PlayByPlayFeed({
    super.key,
    required this.plays,
    this.showTimestamps = true,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (plays.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: plays.length,
        itemBuilder: (context, index) {
          final play = plays[index];
          final isLatest = index == 0;
          
          return _PlayItem(
            play: play,
            isLatest: isLatest,
            showTimestamp: showTimestamps,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sports_volleyball_outlined,
              size: 48,
              color: AppTheme.gray600,
            ),
            const SizedBox(height: 16),
            Text(
              'No plays yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
            Text(
              'Tap on the field to start tracking',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual Play Item
class _PlayItem extends StatelessWidget {
  final Map<String, dynamic> play;
  final bool isLatest;
  final bool showTimestamp;
  
  const _PlayItem({
    required this.play,
    required this.isLatest,
    required this.showTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    final playType = play['playType'] as PlayType?;
    final type = play['type'] as String? ?? 'Unknown';
    final player = play['player'] as String? ?? 'Unknown';
    final timestamp = play['timestamp'] as DateTime?;
    final possession = play['possession'] as String? ?? 'home';
    
    // Get play styling
    final style = _getPlayStyle(playType);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isLatest 
            ? style.color.withValues(alpha:0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isLatest 
            ? Border.all(color: style.color.withValues(alpha:0.3))
            : null,
      ),
      child: Row(
        children: [
          // Play type icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: style.color.withValues(alpha:0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              style.icon,
              color: style.color,
              size: 18,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Play description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Player name
                    Text(
                      player,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Possession indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: possession == 'home' 
                            ? AppTheme.accentBlue.withValues(alpha:0.2)
                            : AppTheme.accentOrange.withValues(alpha:0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        possession == 'home' ? 'HOME' : 'AWAY',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: possession == 'home' 
                              ? AppTheme.accentBlue 
                              : AppTheme.accentOrange,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  type,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: style.color,
                  ),
                ),
              ],
            ),
          ),
          
          // Timestamp
          if (showTimestamp && timestamp != null)
            Text(
              _formatTime(timestamp),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.gray500,
                fontFamily: 'JetBrainsMono',
              ),
            ),
        ],
      ),
    );
  }

  _PlayStyle _getPlayStyle(PlayType? type) {
    if (type == null) {
      return _PlayStyle(icon: Icons.help_outline, color: AppTheme.gray400);
    }
    
    switch (type) {
      case PlayType.goal:
        return _PlayStyle(icon: Icons.emoji_events, color: AppTheme.accentOrange);
      case PlayType.callahan:
        return _PlayStyle(icon: Icons.star, color: AppTheme.accentPurple);
      case PlayType.catch_:
        return _PlayStyle(icon: Icons.sports_handball, color: AppTheme.primaryGreen);
      case PlayType.throwDisc:
        return _PlayStyle(icon: Icons.arrow_forward, color: AppTheme.primaryGreen);
      case PlayType.drop:
        return _PlayStyle(icon: Icons.arrow_downward, color: AppTheme.error);
      case PlayType.throwaway:
        return _PlayStyle(icon: Icons.close, color: AppTheme.error);
      case PlayType.stall:
        return _PlayStyle(icon: Icons.timer_off, color: AppTheme.error);
      case PlayType.outOfBounds:
        return _PlayStyle(icon: Icons.highlight_off, color: AppTheme.error);
      case PlayType.block:
        return _PlayStyle(icon: Icons.block, color: AppTheme.accentBlue);
      case PlayType.interception:
        return _PlayStyle(icon: Icons.swap_horiz, color: AppTheme.accentBlue);
      case PlayType.pull:
        return _PlayStyle(icon: Icons.sports_volleyball, color: AppTheme.gray400);
      case PlayType.timeout:
        return _PlayStyle(icon: Icons.timer, color: AppTheme.warning);
      case PlayType.injury:
        return _PlayStyle(icon: Icons.healing, color: AppTheme.warning);
      case PlayType.substitution:
        return _PlayStyle(icon: Icons.swap_horiz, color: AppTheme.gray400);
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _PlayStyle {
  final IconData icon;
  final Color color;
  
  _PlayStyle({required this.icon, required this.color});
}

/// Live Play Ticker - Horizontal scrolling latest plays
class LivePlayTicker extends StatelessWidget {
  final List<Map<String, dynamic>> plays;
  final int maxPlays;
  
  const LivePlayTicker({
    super.key,
    required this.plays,
    this.maxPlays = 5,
  });

  @override
  Widget build(BuildContext context) {
    final recentPlays = plays.take(maxPlays).toList();
    
    if (recentPlays.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentPlays.length,
        itemBuilder: (context, index) {
          final play = recentPlays[index];
          final isLatest = index == 0;
          
          return _TickerItem(
            play: play,
            isLatest: isLatest,
          );
        },
      ),
    );
  }
}

class _TickerItem extends StatelessWidget {
  final Map<String, dynamic> play;
  final bool isLatest;
  
  const _TickerItem({
    required this.play,
    required this.isLatest,
  });

  @override
  Widget build(BuildContext context) {
    final type = play['type'] as String? ?? 'Unknown';
    final player = play['player'] as String? ?? '';
    
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isLatest 
            ? AppTheme.primaryGreen.withValues(alpha:0.2)
            : AppTheme.gray700.withValues(alpha:0.5),
        borderRadius: BorderRadius.circular(20),
        border: isLatest 
            ? Border.all(color: AppTheme.primaryGreen.withValues(alpha:0.5))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLatest) ...[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppTheme.primaryGreen,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            player.isNotEmpty ? '$player · $type' : type,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isLatest ? AppTheme.primaryGreen : AppTheme.gray300,
              fontWeight: isLatest ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Point Summary Card - Shows summary of a completed point
class PointSummaryCard extends StatelessWidget {
  final int pointNumber;
  final String scoringTeam;
  final String scoringTeamName;
  final int homeScoredAtPoint;
  final int awayScoredAtPoint;
  final int turnovers;
  final Duration? duration;
  final bool wasBreak;
  
  const PointSummaryCard({
    super.key,
    required this.pointNumber,
    required this.scoringTeam,
    required this.scoringTeamName,
    required this.homeScoredAtPoint,
    required this.awayScoredAtPoint,
    required this.turnovers,
    this.duration,
    required this.wasBreak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: wasBreak 
              ? AppTheme.accentOrange.withValues(alpha:0.3)
              : AppTheme.primaryGreen.withValues(alpha:0.3),
        ),
      ),
      child: Row(
        children: [
          // Point number
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: wasBreak 
                  ? AppTheme.accentOrange.withValues(alpha:0.2)
                  : AppTheme.primaryGreen.withValues(alpha:0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$pointNumber',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: wasBreak ? AppTheme.accentOrange : AppTheme.primaryGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Point info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      scoringTeamName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (wasBreak)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accentOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'BREAK',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$homeScoredAtPoint - $awayScoredAtPoint · $turnovers turns${duration != null ? ' · ${_formatDuration(duration!)}' : ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.gray400,
                  ),
                ),
              ],
            ),
          ),
          
          // Score indicator
          Icon(
            Icons.emoji_events,
            color: wasBreak ? AppTheme.accentOrange : AppTheme.primaryGreen,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

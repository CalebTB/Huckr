import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/enums/play_type.dart';

/// Action Buttons Widget - Quick action buttons for tracking plays
class ActionButtons extends StatelessWidget {
  final Function(PlayType) onAction;
  final String possession;
  final bool hasDiscPosition;
  final bool vertical;
  
  const ActionButtons({
    super.key,
    required this.onAction,
    required this.possession,
    required this.hasDiscPosition,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return _buildVerticalLayout(context);
    }
    return _buildHorizontalLayout(context);
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Primary actions row (most common)
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Catch',
                  icon: Icons.sports_handball,
                  color: AppTheme.primaryGreen,
                  onPressed: () => _handleAction(context, PlayType.catch_),
                  enabled: hasDiscPosition,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'Goal',
                  icon: Icons.emoji_events,
                  color: AppTheme.accentOrange,
                  onPressed: () => _handleAction(context, PlayType.goal),
                  enabled: hasDiscPosition,
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'D / Block',
                  icon: Icons.block,
                  color: AppTheme.accentBlue,
                  onPressed: () => _handleAction(context, PlayType.block),
                  enabled: hasDiscPosition,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Secondary actions row (turnovers)
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Drop',
                  icon: Icons.arrow_downward,
                  color: AppTheme.error,
                  onPressed: () => _handleAction(context, PlayType.drop),
                  enabled: hasDiscPosition,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'Throwaway',
                  icon: Icons.close,
                  color: AppTheme.error,
                  onPressed: () => _handleAction(context, PlayType.throwaway),
                  enabled: hasDiscPosition,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'Stall',
                  icon: Icons.timer_off,
                  color: AppTheme.error,
                  onPressed: () => _handleAction(context, PlayType.stall),
                  enabled: hasDiscPosition,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'OB',
                  icon: Icons.highlight_off,
                  color: AppTheme.error,
                  onPressed: () => _handleAction(context, PlayType.outOfBounds),
                  enabled: hasDiscPosition,
                  isSecondary: true,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Tertiary actions row (special plays)
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Pull',
                  icon: Icons.sports_volleyball,
                  color: AppTheme.gray400,
                  onPressed: () => _handleAction(context, PlayType.pull),
                  enabled: true,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'Callahan',
                  icon: Icons.star,
                  color: AppTheme.accentPurple,
                  onPressed: () => _handleAction(context, PlayType.callahan),
                  enabled: hasDiscPosition,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _MoreActionsButton(
                  onAction: onAction,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Goal button (most important)
          SizedBox(
            width: double.infinity,
            child: _ActionButton(
              label: 'GOAL',
              icon: Icons.emoji_events,
              color: AppTheme.accentOrange,
              onPressed: () => _handleAction(context, PlayType.goal),
              enabled: hasDiscPosition,
              isPrimary: true,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Catch and D
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Catch',
                  icon: Icons.sports_handball,
                  color: AppTheme.primaryGreen,
                  onPressed: () => _handleAction(context, PlayType.catch_),
                  enabled: hasDiscPosition,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'D / Block',
                  icon: Icons.block,
                  color: AppTheme.accentBlue,
                  onPressed: () => _handleAction(context, PlayType.block),
                  enabled: hasDiscPosition,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          
          // Turnovers section header
          Text(
            'TURNOVERS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.gray500,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          
          // Turnover buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CompactActionButton(
                label: 'Drop',
                color: AppTheme.error,
                onPressed: () => _handleAction(context, PlayType.drop),
                enabled: hasDiscPosition,
              ),
              _CompactActionButton(
                label: 'Throw',
                color: AppTheme.error,
                onPressed: () => _handleAction(context, PlayType.throwaway),
                enabled: hasDiscPosition,
              ),
              _CompactActionButton(
                label: 'Stall',
                color: AppTheme.error,
                onPressed: () => _handleAction(context, PlayType.stall),
                enabled: hasDiscPosition,
              ),
              _CompactActionButton(
                label: 'OB',
                color: AppTheme.error,
                onPressed: () => _handleAction(context, PlayType.outOfBounds),
                enabled: hasDiscPosition,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          
          // Other actions
          Text(
            'OTHER',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.gray500,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CompactActionButton(
                label: 'Pull',
                color: AppTheme.gray400,
                onPressed: () => _handleAction(context, PlayType.pull),
                enabled: true,
              ),
              _CompactActionButton(
                label: 'Callahan',
                color: AppTheme.accentPurple,
                onPressed: () => _handleAction(context, PlayType.callahan),
                enabled: hasDiscPosition,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, PlayType type) {
    // Haptic feedback
    HapticFeedback.mediumImpact();
    onAction(type);
  }
}

/// Individual Action Button
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool enabled;
  final bool isPrimary;
  final bool isSecondary;
  
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.enabled = true,
    this.isPrimary = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = isPrimary ? 64.0 : (isSecondary ? 48.0 : 56.0);
    final iconSize = isPrimary ? 28.0 : (isSecondary ? 18.0 : 22.0);
    final fontSize = isPrimary ? 14.0 : (isSecondary ? 11.0 : 12.0);
    
    return SizedBox(
      height: height,
      child: Material(
        color: enabled 
            ? (isPrimary ? color : color.withValues(alpha:0.15))
            : AppTheme.gray800,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: enabled 
                      ? (isPrimary ? Colors.white : color)
                      : AppTheme.gray600,
                  size: iconSize,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    color: enabled 
                        ? (isPrimary ? Colors.white : color)
                        : AppTheme.gray600,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact Action Button for vertical layout
class _CompactActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final bool enabled;
  
  const _CompactActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? color.withValues(alpha:0.15) : AppTheme.gray800,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: enabled ? color : AppTheme.gray600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// More Actions Button - Shows additional actions in a bottom sheet
class _MoreActionsButton extends StatelessWidget {
  final Function(PlayType) onAction;
  
  const _MoreActionsButton({required this.onAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Material(
        color: AppTheme.gray700.withValues(alpha:0.5),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => _showMoreActions(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.more_horiz,
                  color: AppTheme.gray400,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  'More',
                  style: TextStyle(
                    color: AppTheme.gray400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'More Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Defensive plays
            Text(
              'Defensive Plays',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MoreActionChip(
                  label: 'Interception',
                  color: AppTheme.accentBlue,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.interception);
                  },
                ),
                _MoreActionChip(
                  label: 'Callahan',
                  color: AppTheme.accentPurple,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.callahan);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Game stoppages
            Text(
              'Game Stoppages',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MoreActionChip(
                  label: 'Timeout',
                  color: AppTheme.gray400,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.timeout);
                  },
                ),
                _MoreActionChip(
                  label: 'Injury',
                  color: AppTheme.warning,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.injury);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Other
            Text(
              'Other',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MoreActionChip(
                  label: 'Pull',
                  color: AppTheme.gray400,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.pull);
                  },
                ),
                _MoreActionChip(
                  label: 'Substitution',
                  color: AppTheme.gray400,
                  onTap: () {
                    Navigator.pop(context);
                    onAction(PlayType.substitution);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _MoreActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _MoreActionChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      labelStyle: TextStyle(color: color),
      backgroundColor: color.withValues(alpha:0.15),
      side: BorderSide.none,
      onPressed: onTap,
    );
  }
}

/// Quick Score Buttons - For simple score tracking without full play-by-play
class QuickScoreButtons extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final Function(String team) onScore;
  
  const QuickScoreButtons({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.onScore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickScoreButton(
            teamName: homeTeamName,
            onPressed: () => onScore('home'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _QuickScoreButton(
            teamName: awayTeamName,
            onPressed: () => onScore('away'),
          ),
        ),
      ],
    );
  }
}

class _QuickScoreButton extends StatelessWidget {
  final String teamName;
  final VoidCallback onPressed;
  
  const _QuickScoreButton({
    required this.teamName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.heavyImpact();
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 28),
            const SizedBox(height: 4),
            Text(
              teamName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

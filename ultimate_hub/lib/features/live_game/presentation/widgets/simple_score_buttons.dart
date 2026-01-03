import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';

/// Simple score tracking buttons
///
/// For simple mode - just score buttons for each team
/// - Home Team Score button
/// - Away Team Score button
/// - Timeout button
/// - Undo button
class SimpleScoreButtons extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final VoidCallback onHomeScore;
  final VoidCallback onAwayScore;
  final VoidCallback onTimeout;
  final VoidCallback? onUndo; // Nullable - disabled if no actions to undo

  const SimpleScoreButtons({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.onHomeScore,
    required this.onAwayScore,
    required this.onTimeout,
    this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Instructions
          Text(
            'Tap team name to score',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 24),

          // Team Score Buttons
          Row(
            children: [
              // Home Team Button
              Expanded(
                child: _TeamScoreButton(
                  teamName: homeTeamName,
                  color: AppTheme.success,
                  onTap: onHomeScore,
                ),
              ),
              const SizedBox(width: 16),

              // Away Team Button
              Expanded(
                child: _TeamScoreButton(
                  teamName: awayTeamName,
                  color: AppTheme.info,
                  onTap: onAwayScore,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Action Buttons Row
          Row(
            children: [
              // Undo Button
              Expanded(
                child: _ActionButton(
                  label: 'Undo',
                  icon: Icons.undo,
                  color: AppTheme.textSecondary,
                  onTap: onUndo,
                ),
              ),
              const SizedBox(width: 12),

              // Timeout Button
              Expanded(
                child: _ActionButton(
                  label: 'Timeout',
                  icon: Icons.timer_outlined,
                  color: AppTheme.accent,
                  onTap: onTimeout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Large team score button
class _TeamScoreButton extends StatelessWidget {
  final String teamName;
  final Color color;
  final VoidCallback onTap;

  const _TeamScoreButton({
    required this.teamName,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              teamName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Score',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Action button (Timeout, Undo)
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              HapticFeedback.lightImpact();
              onTap!();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: isEnabled
              ? color.withValues(alpha: 0.1)
              : AppTheme.cardBorder.withValues(alpha: 0.2),
          border: Border.all(
            color: isEnabled
                ? color.withValues(alpha: 0.3)
                : AppTheme.cardBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isEnabled ? color : AppTheme.textTertiary,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isEnabled ? color : AppTheme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

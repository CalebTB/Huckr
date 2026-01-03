import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';

/// Goal zone picker widget
///
/// Optional categorical zone picker shown after goal
/// "Where was this goal scored?"
/// 3 buttons: [Own End Zone] [Midfield] [Scoring End Zone] [Skip]
/// Returns zone string or null if skipped
class GoalZonePicker extends StatelessWidget {
  const GoalZonePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.cardBorder,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  color: AppTheme.success,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Where was this goal scored?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Zone buttons
            _ZoneButton(
              label: 'Own End Zone',
              description: 'Deep in our end',
              icon: Icons.home,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('own_end');
              },
            ),
            const SizedBox(height: 12),
            _ZoneButton(
              label: 'Midfield',
              description: 'Middle third',
              icon: Icons.circle_outlined,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('midfield');
              },
            ),
            const SizedBox(height: 12),
            _ZoneButton(
              label: 'Scoring End Zone',
              description: 'In the end zone',
              icon: Icons.sports_score,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('scoring_end');
              },
            ),
            const SizedBox(height: 20),

            // Skip button
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual zone button
class _ZoneButton extends StatelessWidget {
  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ZoneButton({
    required this.label,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border.all(
            color: AppTheme.cardBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppTheme.accent,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

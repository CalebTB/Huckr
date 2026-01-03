import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';

/// Pull zone picker widget
///
/// Optional categorical zone picker shown after pull
/// "Where did the pull land?"
/// 4 buttons: [Short] [Medium] [Deep] [Out of Bounds] [Skip]
/// Returns zone string or null if skipped
class PullZonePicker extends StatelessWidget {
  const PullZonePicker({super.key});

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
                  Icons.sports,
                  color: AppTheme.accent,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Where did the pull land?',
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
              label: 'Short',
              description: '0-20m from goal line',
              icon: Icons.arrow_downward,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('short_pull');
              },
            ),
            const SizedBox(height: 12),
            _ZoneButton(
              label: 'Medium',
              description: '20-60m from goal line',
              icon: Icons.circle_outlined,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('medium_pull');
              },
            ),
            const SizedBox(height: 12),
            _ZoneButton(
              label: 'Deep',
              description: '60-80m+ from goal line',
              icon: Icons.arrow_upward,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('deep_pull');
              },
            ),
            const SizedBox(height: 12),
            _ZoneButton(
              label: 'Out of Bounds',
              description: 'OB',
              icon: Icons.exit_to_app,
              color: AppTheme.error,
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop('pull_ob');
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
  final Color? color;
  final VoidCallback onTap;

  const _ZoneButton({
    required this.label,
    required this.description,
    required this.icon,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppTheme.accent;

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
                color: buttonColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: buttonColor,
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

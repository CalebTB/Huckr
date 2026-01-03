import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';

/// Terminal outcome buttons widget
///
/// Horizontal row of outcome buttons at bottom of screen
/// Always visible buttons:
/// - Positive: Goal (green), Timeout (amber)
/// - Turnovers: Drop (red), Throwaway (red), Stall (red), OB (red)
/// - Defense: Block (blue) - switches to defense roster
///
/// Disabled if possession chain is empty (except Block and Timeout)
class TerminalOutcomeButtons extends StatelessWidget {
  final bool chainIsEmpty;
  final VoidCallback onGoal;
  final VoidCallback onDrop;
  final VoidCallback onThrowaway;
  final VoidCallback onStall;
  final VoidCallback onOutOfBounds;
  final VoidCallback onBlock;
  final VoidCallback onTimeout;

  const TerminalOutcomeButtons({
    super.key,
    required this.chainIsEmpty,
    required this.onGoal,
    required this.onDrop,
    required this.onThrowaway,
    required this.onStall,
    required this.onOutOfBounds,
    required this.onBlock,
    required this.onTimeout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(
            color: AppTheme.cardBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1: Positive outcomes
            Row(
              children: [
                Expanded(
                  child: _OutcomeButton(
                    label: 'Goal',
                    icon: Icons.sports_score,
                    color: AppTheme.success,
                    onTap: chainIsEmpty ? null : onGoal,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _OutcomeButton(
                    label: 'Timeout',
                    icon: Icons.timer_outlined,
                    color: AppTheme.accent,
                    onTap: onTimeout, // Always enabled
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Row 2: Turnovers
            Row(
              children: [
                Expanded(
                  child: _OutcomeButton(
                    label: 'Drop',
                    icon: Icons.arrow_downward,
                    color: AppTheme.error,
                    onTap: chainIsEmpty ? null : onDrop,
                    compact: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _OutcomeButton(
                    label: 'Throwaway',
                    icon: Icons.close,
                    color: AppTheme.error,
                    onTap: chainIsEmpty ? null : onThrowaway,
                    compact: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _OutcomeButton(
                    label: 'Stall',
                    icon: Icons.hourglass_empty,
                    color: AppTheme.error,
                    onTap: chainIsEmpty ? null : onStall,
                    compact: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _OutcomeButton(
                    label: 'OB',
                    icon: Icons.exit_to_app,
                    color: AppTheme.error,
                    onTap: chainIsEmpty ? null : onOutOfBounds,
                    compact: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Row 3: Defense
            Row(
              children: [
                Expanded(
                  child: _OutcomeButton(
                    label: 'Block',
                    icon: Icons.block,
                    color: AppTheme.info,
                    onTap: onBlock, // Always enabled
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual outcome button
class _OutcomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool compact;

  const _OutcomeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              HapticFeedback.mediumImpact();
              onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: compact ? 10 : 14,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: isEnabled
              ? color.withValues(alpha: 0.15)
              : AppTheme.cardBorder.withValues(alpha: 0.3),
          border: Border.all(
            color: isEnabled
                ? color.withValues(alpha: 0.5)
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
              size: compact ? 20 : 24,
              color: isEnabled ? color : AppTheme.textTertiary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: compact ? 11 : 13,
                fontWeight: FontWeight.w600,
                color: isEnabled ? color : AppTheme.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

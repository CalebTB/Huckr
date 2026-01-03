import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';
import 'package:ultimate_hub/features/live_game/presentation/providers/play_log_provider.dart';

/// Visual possession chain widget
///
/// Shows sequence of player touches: [PULL] → Sarah #7 → Mike #23 → Jordan #5 →
/// Last player highlighted with green glow
/// Tap any player to remove them + all after (undo within point)
class PossessionChain extends ConsumerWidget {
  final String gameId;
  final bool showPullIndicator;

  const PossessionChain({
    super.key,
    required this.gameId,
    this.showPullIndicator = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final playLogState = ref.watch(playLogProvider(gameId));
    final chain = playLogState.possessionChain;

    if (chain.isEmpty && !showPullIndicator) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // Auto-scroll to latest player
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Pull indicator (if applicable)
                  if (showPullIndicator)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '[PULL]',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.background,
                        ),
                      ),
                    ),

                  // Arrow after pull indicator
                  if (showPullIndicator && chain.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      ),
                    ),

                  // Player chips
                  for (int i = 0; i < chain.length; i++) ...[
                    _PlayerChip(
                      player: chain[i],
                      isLast: i == chain.length - 1,
                      onTap: () {
                        ref
                            .read(playLogProvider(gameId).notifier)
                            .removePlayerFromChain(chain[i]);
                      },
                    ),
                    if (i < chain.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: theme.textTheme.bodyMedium?.color
                              ?.withValues(alpha: 0.6),
                        ),
                      ),
                  ],

                  // Continuation arrow (shows there will be more)
                  if (chain.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppTheme.success.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Clear button
          if (chain.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                ref.read(playLogProvider(gameId).notifier).clearChain();
              },
              tooltip: 'Clear chain',
              iconSize: 20,
            ),
        ],
      ),
    );
  }
}

/// Individual player chip in the possession chain
class _PlayerChip extends StatelessWidget {
  final PlayerClick player;
  final bool isLast;
  final VoidCallback onTap;

  const _PlayerChip({
    required this.player,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isLast
              ? AppTheme.success.withValues(alpha: 0.2)
              : theme.cardColor,
          border: Border.all(
            color: isLast
                ? AppTheme.success
                : AppTheme.accent.withValues(alpha: 0.5),
            width: isLast ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isLast
              ? [
                  BoxShadow(
                    color: AppTheme.success.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              player.playerName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                color: isLast ? AppTheme.success : null,
              ),
            ),
            if (player.jerseyNumber != null) ...[
              const SizedBox(width: 4),
              Text(
                '#${player.jerseyNumber}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isLast ? AppTheme.success : AppTheme.accent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

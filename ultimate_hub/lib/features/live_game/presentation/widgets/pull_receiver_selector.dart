import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';
import 'package:ultimate_hub/features/live_game/presentation/providers/player_roster_provider.dart';
import 'package:ultimate_hub/features/live_game/presentation/providers/play_log_provider.dart';

/// Pull receiver selector widget
///
/// Special UI shown after pull is recorded
/// Large heading: "Who caught the pull?"
/// Grid of offense roster buttons
/// Skip button (if pull went OB)
/// Dismisses after selection, adds player to chain
class PullReceiverSelector extends ConsumerWidget {
  final String gameId;
  final String teamId;
  final VoidCallback onSkip;

  const PullReceiverSelector({
    super.key,
    required this.gameId,
    required this.teamId,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterState = ref.watch(playerRosterProvider);
    final roster = rosterState.offenseRoster[teamId] ?? [];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        border: Border.all(
          color: AppTheme.accent.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading with amber glow
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.accent.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sports,
                    size: 32,
                    color: AppTheme.accent,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Who caught the pull?',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Player grid
            if (roster.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 48,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No players in roster',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Skip or add a player first',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                    ),
                  ],
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: roster.length,
                  itemBuilder: (context, index) {
                    final player = roster[index];
                    return _PullReceiverButton(
                      player: player,
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        // Add to possession chain
                        ref.read(playLogProvider(gameId).notifier).addPlayerToChain(
                              PlayerClick(
                                playerId: player.id,
                                playerName: player.name,
                                jerseyNumber: player.jerseyNumber,
                                teamId: player.teamId,
                              ),
                            );

                        // Dismiss
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),

            // Skip button
            OutlinedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                onSkip();
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(
                  color: AppTheme.textSecondary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.skip_next,
                    size: 20,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Skip (Pull went OB)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual pull receiver button
class _PullReceiverButton extends StatelessWidget {
  final RosterPlayer player;
  final VoidCallback onTap;

  const _PullReceiverButton({
    required this.player,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.card,
          border: Border.all(
            color: AppTheme.accent.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                player.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (player.jerseyNumber != null)
              Text(
                '#${player.jerseyNumber}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

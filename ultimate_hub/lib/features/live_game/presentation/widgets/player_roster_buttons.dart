import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';
import 'package:ultimate_hub/features/live_game/presentation/providers/player_roster_provider.dart';
import 'package:ultimate_hub/features/live_game/presentation/providers/play_log_provider.dart';
import 'package:ultimate_hub/features/live_game/presentation/widgets/quick_add_player_dialog.dart';

/// Player roster buttons widget
///
/// Grid of player buttons (2-3 columns, scrollable)
/// Each button shows: Name + Jersey Number
/// Visual states: Default, Just clicked (green glow), In current chain (amber border)
class PlayerRosterButtons extends ConsumerStatefulWidget {
  final String gameId;
  final String teamId;
  final bool isDefense;
  final Function(PlayerClick player) onPlayerTap;

  const PlayerRosterButtons({
    super.key,
    required this.gameId,
    required this.teamId,
    required this.isDefense,
    required this.onPlayerTap,
  });

  @override
  ConsumerState<PlayerRosterButtons> createState() =>
      _PlayerRosterButtonsState();
}

class _PlayerRosterButtonsState extends ConsumerState<PlayerRosterButtons> {
  String? _lastClickedPlayerId;

  @override
  Widget build(BuildContext context) {
    final rosterState = ref.watch(playerRosterProvider);
    final playLogState = ref.watch(playLogProvider(widget.gameId));

    final roster = widget.isDefense
        ? rosterState.defenseRoster[widget.teamId] ?? []
        : rosterState.offenseRoster[widget.teamId] ?? [];

    final chainPlayerIds =
        playLogState.possessionChain.map((p) => p.playerId).toSet();

    return Column(
      children: [
        // Add New Player button
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _AddPlayerButton(
            teamId: widget.teamId,
            isDefense: widget.isDefense,
            onPlayerAdded: (player) {
              // Immediately use the newly added player
              widget.onPlayerTap(player);
            },
          ),
        ),

        // Toggle between Offense/Defense (optional - could be in parent widget)
        if (!widget.isDefense && rosterState.defenseRoster.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'OFFENSE',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ),

        // Player grid
        Expanded(
          child: roster.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 48,
                        color: AppTheme.textTertiary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No players yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add players as you score',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: roster.length,
              itemBuilder: (context, index) {
                final player = roster[index];
                final isInChain = chainPlayerIds.contains(player.id);
                final isLastClicked = player.id == _lastClickedPlayerId;

                return _PlayerButton(
                  player: player,
                  isInChain: isInChain,
                  isLastClicked: isLastClicked,
                  onTap: () {
                    // Haptic feedback
                    HapticFeedback.mediumImpact();

                    // Update last clicked state
                    setState(() {
                      _lastClickedPlayerId = player.id;
                    });

                    // Clear the glow after 500ms
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted && _lastClickedPlayerId == player.id) {
                        setState(() {
                          _lastClickedPlayerId = null;
                        });
                      }
                    });

                    // Convert to PlayerClick and call callback
                    final playerClick = PlayerClick(
                      playerId: player.id,
                      playerName: player.name,
                      jerseyNumber: player.jerseyNumber,
                      teamId: player.teamId,
                    );
                    widget.onPlayerTap(playerClick);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Individual player button
class _PlayerButton extends StatelessWidget {
  final RosterPlayer player;
  final bool isInChain;
  final bool isLastClicked;
  final VoidCallback onTap;

  const _PlayerButton({
    required this.player,
    required this.isInChain,
    required this.isLastClicked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isLastClicked
              ? AppTheme.success.withValues(alpha: 0.2)
              : AppTheme.card,
          border: Border.all(
            color: isInChain
                ? AppTheme.accent
                : isLastClicked
                    ? AppTheme.success
                    : AppTheme.cardBorder,
            width: isInChain || isLastClicked ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isLastClicked
              ? [
                  BoxShadow(
                    color: AppTheme.success.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                player.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isLastClicked ? AppTheme.success : AppTheme.textPrimary,
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
                  color: isInChain
                      ? AppTheme.accent
                      : isLastClicked
                          ? AppTheme.success
                          : AppTheme.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Add player button
class _AddPlayerButton extends ConsumerWidget {
  final String teamId;
  final bool isDefense;
  final Function(PlayerClick player)? onPlayerAdded;

  const _AddPlayerButton({
    required this.teamId,
    required this.isDefense,
    this.onPlayerAdded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();

        final result = await showDialog<Map<String, String>>(
          context: context,
          builder: (context) => const QuickAddPlayerDialog(),
        );

        if (result != null) {
          final name = result['name']!;
          final number = result['number'];

          // Add to roster
          ref.read(playerRosterProvider.notifier).addPlayer(
                teamId: teamId,
                name: name,
                jerseyNumber: number,
                isDefense: isDefense,
              );

          // Get the newly added player
          final rosterState = ref.read(playerRosterProvider);
          final roster = isDefense
              ? rosterState.defenseRoster[teamId] ?? []
              : rosterState.offenseRoster[teamId] ?? [];

          final newPlayer = roster.firstWhere(
            (p) => p.name == name && p.jerseyNumber == number,
          );

          // Call callback if provided
          if (onPlayerAdded != null) {
            onPlayerAdded!(PlayerClick(
              playerId: newPlayer.id,
              playerName: newPlayer.name,
              jerseyNumber: newPlayer.jerseyNumber,
              teamId: newPlayer.teamId,
            ));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.accent.withValues(alpha: 0.15),
          border: Border.all(
            color: AppTheme.accent.withValues(alpha: 0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 20,
              color: AppTheme.accent,
            ),
            const SizedBox(width: 8),
            Text(
              'Add Player',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

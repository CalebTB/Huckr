import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

/// Home Screen - Main entry point of the app
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and Title
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.sports_volleyball,
                            color: AppTheme.primaryDark,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ultimate Hub',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Track. Compete. Win.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.gray400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // Quick Actions
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.gray400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Start New Game Button
                    _QuickActionCard(
                      icon: Icons.play_circle_fill,
                      iconColor: AppTheme.primaryGreen,
                      title: 'Start New Game',
                      subtitle: 'Track a game with live stats',
                      onTap: () => context.go('/game/setup'),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // View Stats (Coming Soon)
                    _QuickActionCard(
                      icon: Icons.analytics,
                      iconColor: AppTheme.accentPurple,
                      title: 'View Stats',
                      subtitle: 'Coming in Phase 2',
                      onTap: () => _showComingSoon(context, 'Stats Dashboard'),
                      isDisabled: true,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Tournaments (Coming Soon)
                    _QuickActionCard(
                      icon: Icons.emoji_events,
                      iconColor: AppTheme.accentOrange,
                      title: 'Tournaments',
                      subtitle: 'Coming in Phase 3',
                      onTap: () => _showComingSoon(context, 'Tournament Management'),
                      isDisabled: true,
                    ),
                  ],
                ),
              ),
            ),
            
            // Recent Games Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Games',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.gray400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: View all games
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
            ),
            
            // Recent Games List (placeholder)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _EmptyGamesCard(),
              ),
            ),
            
            // Spacer at bottom
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation (Preview)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: AppTheme.gray800.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home,
                  label: 'Home',
                  isSelected: true,
                  onTap: () {},
                ),
                _NavItem(
                  icon: Icons.sports_volleyball,
                  label: 'Games',
                  isSelected: false,
                  onTap: () => context.go('/game/setup'),
                ),
                _NavItem(
                  icon: Icons.groups,
                  label: 'Teams',
                  isSelected: false,
                  onTap: () => _showComingSoon(context, 'Teams'),
                ),
                _NavItem(
                  icon: Icons.emoji_events,
                  label: 'Tourneys',
                  isSelected: false,
                  onTap: () => _showComingSoon(context, 'Tournaments'),
                ),
                _NavItem(
                  icon: Icons.person,
                  label: 'Profile',
                  isSelected: false,
                  onTap: () => _showComingSoon(context, 'Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}

/// Quick Action Card Widget
class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDisabled;

  const _QuickActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: isDisabled ? 0.5 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.gray500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Empty Games Card
class _EmptyGamesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.gray700.withValues(alpha: 0.3),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.sports_volleyball_outlined,
            size: 48,
            color: AppTheme.gray500,
          ),
          const SizedBox(height: 16),
          Text(
            'No games yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.gray400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start tracking your first game!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.gray500,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => context.go('/game/setup'),
            icon: const Icon(Icons.add),
            label: const Text('New Game'),
          ),
        ],
      ),
    );
  }
}

/// Bottom Navigation Item
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryGreen : AppTheme.gray500,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? AppTheme.primaryGreen : AppTheme.gray500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

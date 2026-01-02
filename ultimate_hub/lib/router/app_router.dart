import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../features/live_game/presentation/screens/game_setup_screen.dart';
import '../features/live_game/presentation/screens/live_tracking_screen.dart';
import '../features/live_game/presentation/screens/game_summary_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

/// App Router Configuration
final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,

  routes: [
    // Home
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Game Routes
    GoRoute(
      path: '/game/setup',
      name: 'gameSetup',
      builder: (context, state) => const GameSetupScreen(),
    ),
    GoRoute(
      path: '/game/track/:gameId',
      name: 'liveTracking',
      builder: (context, state) {
        final gameId = state.pathParameters['gameId']!;
        return LiveTrackingScreen(gameId: gameId);
      },
    ),
    GoRoute(
      path: '/game/summary/:gameId',
      name: 'gameSummary',
      builder: (context, state) {
        final gameId = state.pathParameters['gameId']!;
        return GameSummaryScreen(gameId: gameId);
      },
    ),

    // Team Routes (Phase 2)
    // GoRoute(
    //   path: '/teams',
    //   name: 'teams',
    //   builder: (context, state) => const TeamsScreen(),
    // ),
    // GoRoute(
    //   path: '/team/:teamId',
    //   name: 'teamDetail',
    //   builder: (context, state) {
    //     final teamId = state.pathParameters['teamId']!;
    //     return TeamDetailScreen(teamId: teamId);
    //   },
    // ),

    // Stats Routes (Phase 2)
    // GoRoute(
    //   path: '/stats',
    //   name: 'stats',
    //   builder: (context, state) => const StatsScreen(),
    // ),

    // Tournament Routes (Phase 3)
    // GoRoute(
    //   path: '/tournaments',
    //   name: 'tournaments',
    //   builder: (context, state) => const TournamentsScreen(),
    // ),
    // GoRoute(
    //   path: '/tournament/:tournamentId',
    //   name: 'tournamentDetail',
    //   builder: (context, state) {
    //     final tournamentId = state.pathParameters['tournamentId']!;
    //     return TournamentDetailScreen(tournamentId: tournamentId);
    //   },
    // ),
  ],

  // Error handling
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppTheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            state.uri.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.gray500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);

/// Navigation helper extensions
extension NavigationExtensions on BuildContext {
  void goToGameSetup() => go('/game/setup');
  void goToLiveTracking(String gameId) => go('/game/track/$gameId');
  void goToGameSummary(String gameId) => go('/game/summary/$gameId');
  void goToHome() => go('/');
}

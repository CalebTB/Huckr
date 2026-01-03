import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Score Board Widget - Displays current game score with timer and timeouts
class ScoreBoard extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final int homeScore;
  final int awayScore;
  final String possession; // 'home' or 'away'
  final int currentPoint;
  final int homeTimeouts;
  final int awayTimeouts;
  final String timeString;
  final String timeLabel;
  final Color timerColor;
  final String? capBadge; // 'SOFT CAP' or 'HARD CAP'
  final VoidCallback? onTimerTap;
  final int? halftimeHomeScore;
  final int? halftimeAwayScore;
  final bool isHalftime; // Currently at halftime

  const ScoreBoard({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeScore,
    required this.awayScore,
    required this.possession,
    required this.currentPoint,
    required this.homeTimeouts,
    required this.awayTimeouts,
    required this.timeString,
    required this.timeLabel,
    required this.timerColor,
    this.capBadge,
    this.onTimerTap,
    this.halftimeHomeScore,
    this.halftimeAwayScore,
    this.isHalftime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.gray700.withValues(alpha:0.3),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Timer section
          InkWell(
            onTap: onTimerTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  // Time label
                  Text(
                    timeLabel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: timerColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Countdown time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeString,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: timerColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'JetBrainsMono',
                        ),
                      ),
                      if (capBadge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: timerColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            capBadge!,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: timerColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1),

          const SizedBox(height: 8),

          // Scores row
          Row(
            children: [
              // Home Team
              Expanded(
                child: _TeamScore(
                  teamName: homeTeamName,
                  score: homeScore,
                  timeouts: homeTimeouts,
                  hasPossession: possession == 'home',
                  isHome: true,
                ),
              ),

              // Center divider
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '-',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppTheme.gray500,
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                  ),
                ),
              ),

              // Away Team
              Expanded(
                child: _TeamScore(
                  teamName: awayTeamName,
                  score: awayScore,
                  timeouts: awayTimeouts,
                  hasPossession: possession == 'away',
                  isHome: false,
                ),
              ),
            ],
          ),

          // Halftime status badge
          if (isHalftime || (halftimeHomeScore != null && halftimeAwayScore != null)) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isHalftime ? Icons.pause_circle : Icons.check_circle,
                    size: 14,
                    color: AppTheme.accent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isHalftime ? 'HALFTIME' : 'Halftime: $halftimeHomeScore-$halftimeAwayScore',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.accent,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TeamScore extends StatelessWidget {
  final String teamName;
  final int score;
  final int timeouts;
  final bool hasPossession;
  final bool isHome;

  const _TeamScore({
    required this.teamName,
    required this.score,
    required this.timeouts,
    required this.hasPossession,
    required this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isHome ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        // Team name with possession indicator
        Row(
          mainAxisAlignment: isHome ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (hasPossession && isHome)
              _PossessionIndicator(),
            if (hasPossession && isHome)
              const SizedBox(width: 8),

            Flexible(
              child: Text(
                teamName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: hasPossession ? Colors.white : AppTheme.gray400,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (hasPossession && !isHome)
              const SizedBox(width: 8),
            if (hasPossession && !isHome)
              _PossessionIndicator(),
          ],
        ),

        const SizedBox(height: 4),

        // Timeout indicators
        Row(
          mainAxisAlignment: isHome ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: isHome ? 4 : 0,
                left: !isHome ? 4 : 0,
              ),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: index < timeouts ? AppTheme.accent : AppTheme.gray700,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Score
        Text(
          '$score',
          style: AppStyles.scoreStyle(context).copyWith(
            fontSize: 56,
            color: hasPossession ? AppTheme.primaryGreen : Colors.white,
          ),
        ),
      ],
    );
  }
}

class _PossessionIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withValues(alpha:0.5),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

/// Compact Score Board for landscape mode
class CompactScoreBoard extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final int homeScore;
  final int awayScore;
  final String possession;
  
  const CompactScoreBoard({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeScore,
    required this.awayScore,
    required this.possession,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CompactTeamScore(
            name: homeTeamName,
            score: homeScore,
            hasPossession: possession == 'home',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '-',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
          ),
          _CompactTeamScore(
            name: awayTeamName,
            score: awayScore,
            hasPossession: possession == 'away',
          ),
        ],
      ),
    );
  }
}

class _CompactTeamScore extends StatelessWidget {
  final String name;
  final int score;
  final bool hasPossession;
  
  const _CompactTeamScore({
    required this.name,
    required this.score,
    required this.hasPossession,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: hasPossession ? AppTheme.primaryGreen : AppTheme.gray400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: hasPossession ? AppTheme.primaryGreen : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (hasPossession)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

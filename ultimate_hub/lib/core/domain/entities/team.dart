import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultimate_hub/core/enums/division.dart';
import 'package:ultimate_hub/core/enums/team_type.dart';
import 'package:ultimate_hub/core/domain/entities/player.dart';

part 'team.freezed.dart';
part 'team.g.dart';

/// Represents an ultimate frisbee team
@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    String? abbreviation, // e.g., "RIN" for Ring of Fire
    String? logoUrl,

    // Team info
    required Division division,
    TeamType? type,
    String? city,
    String? state,
    String? region,

    // Colors (for UI)
    String? primaryColor, // Hex color
    String? secondaryColor,

    // Leadership
    String? captainUserId,
    @Default([]) List<String> managerUserIds,

    // Roster
    @Default([]) List<TeamMember> roster,

    // Season stats
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int ties,
    @Default(0) int pointsScored,
    @Default(0) int pointsAllowed,

    // Settings
    @Default(false) bool isPublic, // Can be found in search
    String? inviteCode, // For private teams

    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

/// Extension methods for Team
extension TeamExtensions on Team {
  /// Total games played
  int get totalGames => wins + losses + ties;

  /// Win percentage
  double get winPercentage {
    if (totalGames == 0) return 0;
    return (wins / totalGames) * 100;
  }

  /// Point differential
  int get pointDifferential => pointsScored - pointsAllowed;

  /// Average points scored per game
  double get avgPointsScored {
    if (totalGames == 0) return 0;
    return pointsScored / totalGames;
  }

  /// Average points allowed per game
  double get avgPointsAllowed {
    if (totalGames == 0) return 0;
    return pointsAllowed / totalGames;
  }

  /// Active roster count
  int get activeRosterCount => roster.where((m) => m.isActive).length;

  /// Get display name with abbreviation
  String get displayName => abbreviation != null ? '$name ($abbreviation)' : name;

  /// Get record string (e.g., "5-2")
  String get recordString => '$wins-$losses${ties > 0 ? '-$ties' : ''}';
}

/// Represents team stats for a specific game
@freezed
class TeamGameStats with _$TeamGameStats {
  const factory TeamGameStats({
    required String gameId,
    required String teamId,

    // Score
    @Default(0) int score,

    // Point stats
    @Default(0) int oPointsPlayed,
    @Default(0) int oPointsScored,
    @Default(0) int dPointsPlayed,
    @Default(0) int dPointsScored, // Breaks

    // Clean points (scored without turning over)
    @Default(0) int cleanHolds,

    // Turnover stats
    @Default(0) int turnovers,
    @Default(0) int turnoversForced, // Blocks/Ds

    // Efficiency metrics
    @Default(0) int totalPossessions,
    @Default(0) int scoringPossessions,
  }) = _TeamGameStats;

  factory TeamGameStats.fromJson(Map<String, dynamic> json) =>
      _$TeamGameStatsFromJson(json);
}

/// Extension methods for TeamGameStats
extension TeamGameStatsExtensions on TeamGameStats {
  /// O-Line conversion rate (% of O points scored)
  double get oLineConversionRate {
    if (oPointsPlayed == 0) return 0;
    return (oPointsScored / oPointsPlayed) * 100;
  }

  /// D-Line conversion rate (% of D points where we scored - breaks)
  double get dLineConversionRate {
    if (dPointsPlayed == 0) return 0;
    return (dPointsScored / dPointsPlayed) * 100;
  }

  /// Break rate (same as D-line conversion)
  double get breakRate => dLineConversionRate;

  /// Hold rate (same as O-line conversion)
  double get holdRate => oLineConversionRate;

  /// Perfect conversion rate (clean holds / O points)
  double get perfectConversionRate {
    if (oPointsPlayed == 0) return 0;
    return (cleanHolds / oPointsPlayed) * 100;
  }

  /// Scoring efficiency (% of possessions that score)
  double get scoringEfficiency {
    if (totalPossessions == 0) return 0;
    return (scoringPossessions / totalPossessions) * 100;
  }

  /// Turnovers per point
  double get turnoversPerPoint {
    final pointsPlayed = oPointsPlayed + dPointsPlayed;
    if (pointsPlayed == 0) return 0;
    return turnovers / pointsPlayed;
  }
}

/// Simplified team for in-game tracking
@freezed
class GameTeam with _$GameTeam {
  const factory GameTeam({
    required String id,
    required String name,
    String? abbreviation,
    String? logoUrl,
    String? primaryColor,
    @Default([]) List<GamePlayer> players,
  }) = _GameTeam;

  factory GameTeam.fromJson(Map<String, dynamic> json) =>
      _$GameTeamFromJson(json);
}

/// Extension for GameTeam
extension GameTeamExtensions on GameTeam {
  /// Get players currently on field
  List<GamePlayer> get playersOnField =>
      players.where((p) => p.isOnField).toList();

  /// Get players on bench
  List<GamePlayer> get playersOnBench =>
      players.where((p) => !p.isOnField).toList();
}

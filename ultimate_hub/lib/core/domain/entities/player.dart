import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultimate_hub/core/enums/player_role.dart';
import 'package:ultimate_hub/core/enums/team_member_role.dart';

part 'player.freezed.dart';
part 'player.g.dart';

/// Represents a player account/profile
@freezed
class Player with _$Player {
  const factory Player({
    required String id,
    required String userId, // Auth user ID
    required String displayName,
    String? email,
    String? avatarUrl,

    // Profile info
    int? jerseyNumber,
    PlayerRole? primaryRole,
    @Default([]) List<String> teamIds, // Teams they belong to

    // Career stats (aggregated)
    @Default(0) int totalGamesPlayed,
    @Default(0) int totalGoals,
    @Default(0) int totalAssists,
    @Default(0) int totalBlocks,
    @Default(0) int totalTurnovers,
    @Default(0) int totalDrops,
    @Default(0) int totalPointsPlayed,

    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

/// Extension methods for Player
extension PlayerExtensions on Player {
  /// Calculate plus/minus ratio
  double get plusMinusRatio {
    final positive = totalGoals + totalAssists + totalBlocks;
    final negative = totalTurnovers + totalDrops;
    if (negative == 0) return positive.toDouble();
    return positive / negative;
  }

  /// Goals per game average
  double get goalsPerGame {
    if (totalGamesPlayed == 0) return 0;
    return totalGoals / totalGamesPlayed;
  }

  /// Assists per game average
  double get assistsPerGame {
    if (totalGamesPlayed == 0) return 0;
    return totalAssists / totalGamesPlayed;
  }

  /// Blocks per game average
  double get blocksPerGame {
    if (totalGamesPlayed == 0) return 0;
    return totalBlocks / totalGamesPlayed;
  }

  /// Turnovers per game average
  double get turnoversPerGame {
    if (totalGamesPlayed == 0) return 0;
    return totalTurnovers / totalGamesPlayed;
  }
}

/// Represents a player's stats for a single game
@freezed
class PlayerGameStats with _$PlayerGameStats {
  const factory PlayerGameStats({
    required String id,
    required String gameId,
    required String playerId,
    required String teamId,
    String? playerName,
    int? jerseyNumber,

    // Core stats
    @Default(0) int goals,
    @Default(0) int assists,
    @Default(0) int hockeyAssists, // Pass before the assist
    @Default(0) int blocks,
    @Default(0) int turnovers,
    @Default(0) int drops,
    @Default(0) int throwaways,
    @Default(0) int stalls,

    // Touch stats
    @Default(0) int catches,
    @Default(0) int completedThrows,
    @Default(0) int incompleteThrows,

    // Playing time
    @Default(0) int pointsPlayed,
    @Default(0) int oPointsPlayed,
    @Default(0) int dPointsPlayed,

    // Point outcomes when on field
    @Default(0) int pointsWon,
    @Default(0) int pointsLost,

    // Pulls (for D-line)
    @Default(0) int pulls,

    // Sync
    @Default(false) bool isSynced,
  }) = _PlayerGameStats;

  factory PlayerGameStats.fromJson(Map<String, dynamic> json) =>
      _$PlayerGameStatsFromJson(json);
}

/// Extension methods for PlayerGameStats
extension PlayerGameStatsExtensions on PlayerGameStats {
  /// Plus/minus for this game
  int get plusMinus => pointsWon - pointsLost;

  /// Completion percentage
  double get completionPercentage {
    final totalThrows = completedThrows + incompleteThrows;
    if (totalThrows == 0) return 0;
    return (completedThrows / totalThrows) * 100;
  }

  /// Catch percentage
  double get catchPercentage {
    final totalTargeted = catches + drops;
    if (totalTargeted == 0) return 0;
    return (catches / totalTargeted) * 100;
  }

  /// Total touches (catches)
  int get totalTouches => catches;

  /// Net stats (simple impact metric)
  int get netStats => goals + assists + hockeyAssists + blocks - turnovers;

  /// Offensive efficiency
  double get offensiveEfficiency {
    if (oPointsPlayed == 0) return 0;
    // Points won on O-line / points played on O-line
    // This is a simplification - would need more tracking for accuracy
    return 0; // TODO: Calculate from point-level data
  }
}

/// Represents a team roster member (player on a specific team)
@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String playerId,
    required String teamId,
    required String displayName,
    String? avatarUrl,

    // Team-specific info
    int? jerseyNumber,
    @Default(TeamMemberRole.player) TeamMemberRole role,
    PlayerRole? position,

    // Status
    @Default(true) bool isActive,
    @Default(false) bool isCaptain,

    // Timestamps
    required DateTime joinedAt,
    DateTime? leftAt,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

/// Simplified player for in-game tracking (minimal data)
@freezed
class GamePlayer with _$GamePlayer {
  const factory GamePlayer({
    required String id,
    required String name,
    int? jerseyNumber,
    @Default(false) bool isOnField,
    PlayerRole? position,
  }) = _GamePlayer;

  factory GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerFromJson(json);
}

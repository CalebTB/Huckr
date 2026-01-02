import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultimate_hub/core/enums/play_type.dart';
import 'package:ultimate_hub/core/enums/line_type.dart';

part 'play.freezed.dart';
part 'play.g.dart';

/// Represents a single play/action in a game
/// This is the core unit of tracking for live games
@freezed
class Play with _$Play {
  const factory Play({
    required String id,
    required String gameId,
    required String pointId,
    required int playNumber, // Sequential within the point

    // Player info
    String? playerId,
    String? playerName,
    int? playerJerseyNumber,
    required String teamId,

    // Action details
    required PlayType type,
    String? notes,

    // Field position (normalized 0-1 coordinates)
    // 0,0 is home team's defended end zone corner
    // 1,1 is away team's defended end zone corner
    double? fieldX,
    double? fieldY,

    // For throws: who received (if completed)
    String? targetPlayerId,
    String? targetPlayerName,

    // For turnovers: additional context
    String? turnoverType, // 'throwaway', 'drop', 'stall', 'OB'

    // Timing
    required DateTime timestamp,
    int? stallCount, // 0-10, at time of action

    // Sync status
    @Default(false) bool isSynced,
    DateTime? syncedAt,
  }) = _Play;

  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);
}

/// Extension methods for Play
extension PlayExtensions on Play {
  /// Check if this play resulted in a turnover
  bool get isTurnover => type.isTurnover;

  /// Check if this play was a defensive action
  bool get isDefensivePlay => type.isDefensivePlay;

  /// Check if this play was a score
  bool get isScore => type.isScore;

  /// Get display string for the play
  String get displayString {
    final playerStr = playerName ?? 'Unknown';

    switch (type) {
      case PlayType.pull:
        return '$playerStr pulls';
      case PlayType.catch_:
        return '$playerStr catches';
      case PlayType.throwDisc:
        final targetStr = targetPlayerName ?? 'teammate';
        return '$playerStr throws to $targetStr';
      case PlayType.drop:
        return '$playerStr drops';
      case PlayType.throwaway:
        return '$playerStr throwaway';
      case PlayType.stall:
        return '$playerStr stalled out';
      case PlayType.outOfBounds:
        return 'Disc out of bounds';
      case PlayType.block:
        return '$playerStr gets a block!';
      case PlayType.interception:
        return '$playerStr interception!';
      case PlayType.goal:
        return '$playerStr scores!';
      case PlayType.callahan:
        return '$playerStr CALLAHAN!';
      case PlayType.timeout:
        return 'Timeout called';
      case PlayType.injury:
        return 'Injury stoppage';
      case PlayType.substitution:
        return 'Substitution';
    }
  }

  /// Get field zone description
  String get fieldZone {
    if (fieldY == null) return 'Unknown';

    if (fieldY! < 0.18) return 'Home End Zone';
    if (fieldY! < 0.36) return 'Home Red Zone';
    if (fieldY! < 0.64) return 'Midfield';
    if (fieldY! < 0.82) return 'Away Red Zone';
    return 'Away End Zone';
  }
}

/// Represents a point (sequence of plays ending in a score)
@freezed
class GamePoint with _$GamePoint {
  const factory GamePoint({
    required String id,
    required String gameId,
    required int pointNumber,

    // Teams
    required String startingTeamId, // Team that pulled (on D)
    required String receivingTeamId, // Team that received (on O)
    String? scoringTeamId, // null until point ends

    // Line info
    required LineType homeLineType, // O or D for home team
    required LineType awayLineType, // O or D for away team

    // Players on field at start
    @Default([]) List<String> homePlayersOnField,
    @Default([]) List<String> awayPlayersOnField,

    // Stats for this point
    @Default(0) int totalTurnovers,
    @Default(0) int homeTurnovers,
    @Default(0) int awayTurnovers,

    // Timing
    required DateTime startTime,
    DateTime? endTime,

    // Score at start of point
    required int homeScoreAtStart,
    required int awayScoreAtStart,

    // Sync
    @Default(false) bool isSynced,
  }) = _GamePoint;

  factory GamePoint.fromJson(Map<String, dynamic> json) =>
      _$GamePointFromJson(json);
}

/// Extension methods for GamePoint
extension GamePointExtensions on GamePoint {
  /// Duration of the point
  Duration? get duration {
    if (endTime == null) return null;
    return endTime!.difference(startTime);
  }

  /// Check if point was a break (D-line scored)
  bool get isBreak {
    if (scoringTeamId == null) return false;
    return scoringTeamId == startingTeamId; // Pulling team scored
  }

  /// Check if point was a hold (O-line scored)
  bool get isHold {
    if (scoringTeamId == null) return false;
    return scoringTeamId == receivingTeamId; // Receiving team scored
  }

  /// Check if this was a "clean" hold (no turnovers)
  bool get isCleanHold => isHold && totalTurnovers == 0;
}

/// Represents a position on the field
@freezed
class FieldPosition with _$FieldPosition {
  const factory FieldPosition({
    required double x, // 0-1, left to right
    required double y, // 0-1, home end zone to away end zone
  }) = _FieldPosition;

  factory FieldPosition.fromJson(Map<String, dynamic> json) =>
      _$FieldPositionFromJson(json);

  /// Create from pixel coordinates on a canvas
  factory FieldPosition.fromCanvas({
    required double pixelX,
    required double pixelY,
    required double canvasWidth,
    required double canvasHeight,
  }) {
    return FieldPosition(
      x: (pixelX / canvasWidth).clamp(0.0, 1.0),
      y: (pixelY / canvasHeight).clamp(0.0, 1.0),
    );
  }
}

/// Extension methods for FieldPosition
extension FieldPositionExtensions on FieldPosition {
  /// Check if position is in an end zone
  bool get isInEndZone => y < 0.18 || y > 0.82;

  /// Check if position is in home end zone
  bool get isInHomeEndZone => y < 0.18;

  /// Check if position is in away end zone
  bool get isInAwayEndZone => y > 0.82;

  /// Get the zone name
  String get zoneName {
    if (y < 0.18) return 'Home End Zone';
    if (y < 0.36) return 'Home Third';
    if (y < 0.64) return 'Midfield';
    if (y < 0.82) return 'Away Third';
    return 'Away End Zone';
  }

  /// Convert to canvas coordinates
  Offset toCanvas({
    required double canvasWidth,
    required double canvasHeight,
  }) {
    return Offset(x * canvasWidth, y * canvasHeight);
  }

  /// Distance from another position (normalized)
  double distanceTo(FieldPosition other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy).sqrt();
  }
}

// Helper class for Offset since freezed doesn't include dart:ui
class Offset {
  final double dx;
  final double dy;
  const Offset(this.dx, this.dy);
}

extension DoubleExtension on double {
  double sqrt() => this >= 0 ? this * 0.5 + 0.5 : 0; // Simplified sqrt approximation
}

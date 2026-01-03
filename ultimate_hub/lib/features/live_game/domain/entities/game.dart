import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultimate_hub/core/enums/game_status.dart';
import 'package:ultimate_hub/core/enums/delay_reason.dart';

part 'game.freezed.dart';
part 'game.g.dart';

/// Represents a single game between two teams
@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    String? tournamentId,
    String? poolId,
    String? bracketPosition,

    // Teams
    required String homeTeamId,
    required String awayTeamId,
    required String homeTeamName,
    required String awayTeamName,
    String? homeTeamLogo,
    String? awayTeamLogo,

    // Score
    @Default(0) int homeScore,
    @Default(0) int awayScore,
    int? halftimeHomeScore,
    int? halftimeAwayScore,

    // Game settings
    @Default(15) int gameToPoints, // Current target (changes when caps hit)
    int? originalGameToPoints, // Original target (for halftime calculation), null = same as gameToPoints
    @Default(17) int hardCapPoints,
    int? halftimeAtOverride, // Optional override, null = use formula: (gameToPoints / 2).ceil()
    @Default(75) int softCapMinutes,
    @Default(90) int hardCapMinutes,

    // Status
    @Default(GameStatus.scheduled) GameStatus status,
    @Default(1) int currentPoint,
    String? currentPossession, // teamId

    // Timing
    DateTime? scheduledAt,
    DateTime? startedAt,
    DateTime? halftimeStartedAt,
    DateTime? softCapStartedAt,
    DateTime? hardCapStartedAt,
    DateTime? endedAt,

    // Delays
    @Default(false) bool isDelayed,
    DelayReason? delayReason,
    String? delayNotes,
    DateTime? delayStartedAt,

    // Conditions
    String? windSpeed,
    String? windDirection,
    String? weatherNotes,
    String? gameNotes, // Post-game notes (injuries, notable plays, comments)

    // Tracking
    @Default(false) bool isBeingTracked,
    String? trackedByUserId,
    String? trackedByUserName,
    @Default(true) bool isSimpleTracking, // Simple mode = faster entry, Advanced = full stats

    // Sync
    @Default(false) bool isSynced,
    DateTime? lastSyncedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

/// Extension methods for Game
extension GameExtensions on Game {
  /// Calculate halftime point dynamically based on ORIGINAL game format
  /// Formula: (originalGameToPoints / 2) rounded up
  /// Examples: Game to 15 → 8, Game to 13 → 7, Game to 11 → 6
  /// Note: Halftime is based on original format, not adjusted for caps
  int get halftimeAt {
    if (halftimeAtOverride != null) return halftimeAtOverride!;
    final original = originalGameToPoints ?? gameToPoints;
    return (original / 2).ceil();
  }

  /// Check if game is currently active (being played)
  bool get isActive => status == GameStatus.inProgress ||
                       status == GameStatus.halftime ||
                       status == GameStatus.softCap ||
                       status == GameStatus.hardCap;

  /// Get the winning team ID (null if tied or not finished)
  String? get winningTeamId {
    if (status != GameStatus.completed) return null;
    if (homeScore > awayScore) return homeTeamId;
    if (awayScore > homeScore) return awayTeamId;
    return null; // Tie (rare in ultimate)
  }

  /// Get score string (e.g., "7-5")
  String get scoreString => '$homeScore-$awayScore';

  /// Total points played
  int get totalPointsPlayed => homeScore + awayScore;

  /// Check if soft cap should be activated
  bool shouldActivateSoftCap(Duration elapsed) {
    return status == GameStatus.inProgress &&
           elapsed.inMinutes >= softCapMinutes;
  }

  /// Check if hard cap should be activated
  bool shouldActivateHardCap(Duration elapsed) {
    return (status == GameStatus.inProgress || status == GameStatus.softCap) &&
           elapsed.inMinutes >= hardCapMinutes;
  }

  /// Check if game should end due to caps
  bool shouldEndGame() {
    // Normal game end
    if (homeScore >= gameToPoints || awayScore >= gameToPoints) return true;

    // Hard cap reached
    if (status == GameStatus.hardCap) {
      if (homeScore >= hardCapPoints || awayScore >= hardCapPoints) return true;
      // Also end if one team is ahead by at least 1 after hard cap
      if (homeScore != awayScore && totalPointsPlayed >= (hardCapPoints - 1) * 2) {
        return true;
      }
    }

    return false;
  }

  /// Get game duration
  Duration? get duration {
    if (startedAt == null) return null;
    final endTime = endedAt ?? DateTime.now();
    return endTime.difference(startedAt!);
  }
}

/// Represents a quick game setup without full team data
@freezed
class QuickGameSetup with _$QuickGameSetup {
  const factory QuickGameSetup({
    required String homeTeamName,
    required String awayTeamName,
    @Default(15) int gameToPoints,
    @Default(17) int hardCapPoints,
    @Default(75) int softCapMinutes,
    @Default(90) int hardCapMinutes,
    String? windSpeed,
    String? windDirection,
  }) = _QuickGameSetup;

  factory QuickGameSetup.fromJson(Map<String, dynamic> json) =>
      _$QuickGameSetupFromJson(json);
}

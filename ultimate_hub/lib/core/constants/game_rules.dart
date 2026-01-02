/// Game rules and timing constants for ultimate frisbee
/// Based on USA Ultimate and WFDF rules
class GameRules {
  // Standard game settings
  static const int defaultGameLength = 15; // Points to win
  static const int defaultHardCap = 17;    // Maximum points
  static const int defaultHalftimeAt = 8;  // First to 8
  static const int defaultTimeoutsPerHalf = 2;
  static const int defaultFloaterTimeouts = 1;

  // Time limits (in minutes)
  static const int defaultSoftCapMinutes = 75;
  static const int defaultHardCapMinutes = 90;
  static const int defaultPointCapMinutes = 100;

  // Stall count
  static const int stallCountSeconds = 10;

  // Between point time
  static const int betweenPointSeconds = 75;
  static const int afterHalftimeSeconds = 300; // 5 minutes

  // Pull clock
  static const int pullClockSeconds = 20;
}

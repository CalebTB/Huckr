/// Field dimensions for ultimate frisbee
/// Based on USA Ultimate and WFDF specifications
class FieldDimensions {
  // Standard field dimensions in meters
  static const double fieldLengthMeters = 100.0;
  static const double fieldWidthMeters = 37.0;
  static const double endZoneDepthMeters = 18.0;
  static const double playingFieldLengthMeters = 64.0; // Between end zones

  // Brick marks
  static const double brickDistanceMeters = 18.0; // From goal line

  // For field canvas (normalized 0-1 coordinates)
  static const double endZoneRatio = 0.18; // 18/100

  // Aspect ratio for field visualization
  static double get aspectRatio => fieldWidthMeters / fieldLengthMeters;
}

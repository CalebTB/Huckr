import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/field_dimensions.dart';

/// Field Canvas Widget - Interactive ultimate frisbee field visualization
/// Allows tapping to mark disc position, shows end zones, yard lines, etc.
class FieldCanvas extends StatelessWidget {
  final double? discX;
  final double? discY;
  final String possession;
  final String homeTeamName;
  final String awayTeamName;
  final Function(double x, double y) onFieldTap;
  final bool landscape;
  
  const FieldCanvas({
    super.key,
    this.discX,
    this.discY,
    required this.possession,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.onFieldTap,
    this.landscape = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate field dimensions maintaining aspect ratio
        final fieldAspectRatio = landscape 
            ? FieldDimensions.fieldLengthMeters / FieldDimensions.fieldWidthMeters
            : FieldDimensions.fieldWidthMeters / FieldDimensions.fieldLengthMeters;
        
        double fieldWidth, fieldHeight;
        
        if (landscape) {
          // Landscape: field is horizontal
          fieldHeight = constraints.maxHeight;
          fieldWidth = fieldHeight * fieldAspectRatio;
          if (fieldWidth > constraints.maxWidth) {
            fieldWidth = constraints.maxWidth;
            fieldHeight = fieldWidth / fieldAspectRatio;
          }
        } else {
          // Portrait: field is vertical
          fieldWidth = constraints.maxWidth;
          fieldHeight = fieldWidth / fieldAspectRatio;
          if (fieldHeight > constraints.maxHeight) {
            fieldHeight = constraints.maxHeight;
            fieldWidth = fieldHeight * fieldAspectRatio;
          }
        }
        
        return Center(
          child: GestureDetector(
            onTapDown: (details) {
              final localX = details.localPosition.dx / fieldWidth;
              final localY = details.localPosition.dy / fieldHeight;
              onFieldTap(localX, localY);
            },
            child: Container(
              width: fieldWidth,
              height: fieldHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomPaint(
                  painter: FieldPainter(
                    discX: discX,
                    discY: discY,
                    possession: possession,
                    homeTeamName: homeTeamName,
                    awayTeamName: awayTeamName,
                    landscape: landscape,
                  ),
                  size: Size(fieldWidth, fieldHeight),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for the ultimate frisbee field
class FieldPainter extends CustomPainter {
  final double? discX;
  final double? discY;
  final String possession;
  final String homeTeamName;
  final String awayTeamName;
  final bool landscape;
  
  FieldPainter({
    this.discX,
    this.discY,
    required this.possession,
    required this.homeTeamName,
    required this.awayTeamName,
    this.landscape = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Field dimensions ratios
    const endZoneRatio = 0.18; // 18m out of 100m
    const brickRatio = 0.18; // Brick mark at 18m from goal line
    
    // Colors
    const fieldGreen = AppTheme.fieldGreen;
    const fieldGreenLight = AppTheme.fieldGreenLight;
    const endZoneColor = AppTheme.endZoneColor;
    final lineColor = AppTheme.lineWhite.withValues(alpha:0.9);
    
    // Paints
    final fieldPaint = Paint()..color = fieldGreen;
    final fieldPaintLight = Paint()..color = fieldGreenLight;
    final endZonePaint = Paint()..color = endZoneColor;
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final thickLinePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    // Draw field background with stripes
    _drawFieldStripes(canvas, size, fieldPaint, fieldPaintLight, endZoneRatio);
    
    // Draw end zones
    _drawEndZones(canvas, size, endZonePaint, endZoneRatio);
    
    // Draw field lines
    _drawFieldLines(canvas, size, linePaint, thickLinePaint, endZoneRatio, brickRatio);
    
    // Draw end zone labels
    _drawEndZoneLabels(canvas, size, endZoneRatio);
    
    // Draw disc marker if position is set
    if (discX != null && discY != null) {
      _drawDiscMarker(canvas, size, discX!, discY!);
    }
    
    // Draw tap hint if no disc position
    if (discX == null || discY == null) {
      _drawTapHint(canvas, size);
    }
  }

  void _drawFieldStripes(Canvas canvas, Size size, Paint dark, Paint light, double endZoneRatio) {
    // Alternate stripes for grass effect
    const stripeCount = 8;
    final playingFieldStart = size.height * endZoneRatio;
    final playingFieldEnd = size.height * (1 - endZoneRatio);
    final playingFieldHeight = playingFieldEnd - playingFieldStart;
    final stripeHeight = playingFieldHeight / stripeCount;
    
    for (int i = 0; i < stripeCount; i++) {
      final paint = i % 2 == 0 ? dark : light;
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          playingFieldStart + (i * stripeHeight),
          size.width,
          stripeHeight,
        ),
        paint,
      );
    }
  }

  void _drawEndZones(Canvas canvas, Size size, Paint paint, double endZoneRatio) {
    // Home end zone (top in portrait)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * endZoneRatio),
      paint,
    );
    
    // Away end zone (bottom in portrait)
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * (1 - endZoneRatio),
        size.width,
        size.height * endZoneRatio,
      ),
      paint,
    );
  }

  void _drawFieldLines(Canvas canvas, Size size, Paint linePaint, Paint thickLinePaint, 
                       double endZoneRatio, double brickRatio) {
    // Field outline
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      thickLinePaint,
    );
    
    // Goal lines (end zone boundaries)
    // Home goal line
    canvas.drawLine(
      Offset(0, size.height * endZoneRatio),
      Offset(size.width, size.height * endZoneRatio),
      thickLinePaint,
    );
    
    // Away goal line
    canvas.drawLine(
      Offset(0, size.height * (1 - endZoneRatio)),
      Offset(size.width, size.height * (1 - endZoneRatio)),
      thickLinePaint,
    );
    
    // Brick marks (small marks on sidelines at 18m from goal line)
    final homeBackBrickY = size.height * endZoneRatio + size.height * brickRatio;
    final awayBackBrickY = size.height * (1 - endZoneRatio) - size.height * brickRatio;
    
    // Home brick marks
    _drawBrickMark(canvas, 0, homeBackBrickY, size.width * 0.05, linePaint);
    _drawBrickMark(canvas, size.width, homeBackBrickY, -size.width * 0.05, linePaint);
    
    // Away brick marks
    _drawBrickMark(canvas, 0, awayBackBrickY, size.width * 0.05, linePaint);
    _drawBrickMark(canvas, size.width, awayBackBrickY, -size.width * 0.05, linePaint);
    
    // Center line (optional, not official but helpful)
    final centerY = size.height / 2;
    final dashPaint = Paint()
      ..color = AppTheme.lineWhite.withValues(alpha:0.3)
      ..strokeWidth = 1;
    
    // Dashed center line
    const dashWidth = 10.0;
    const dashSpace = 10.0;
    var startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, centerY),
        Offset(math.min(startX + dashWidth, size.width), centerY),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  void _drawBrickMark(Canvas canvas, double x, double y, double length, Paint paint) {
    canvas.drawLine(
      Offset(x, y),
      Offset(x + length, y),
      paint,
    );
  }

  void _drawEndZoneLabels(Canvas canvas, Size size, double endZoneRatio) {
    final textStyle = TextStyle(
      color: AppTheme.lineWhite.withValues(alpha:0.6),
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
    );
    
    // Home end zone label
    final homeSpan = TextSpan(text: homeTeamName.toUpperCase(), style: textStyle);
    final homePainter = TextPainter(
      text: homeSpan,
      textDirection: TextDirection.ltr,
    );
    homePainter.layout();
    
    final homeEndZoneCenter = size.height * endZoneRatio / 2;
    homePainter.paint(
      canvas,
      Offset(
        (size.width - homePainter.width) / 2,
        homeEndZoneCenter - homePainter.height / 2,
      ),
    );
    
    // Away end zone label
    final awaySpan = TextSpan(text: awayTeamName.toUpperCase(), style: textStyle);
    final awayPainter = TextPainter(
      text: awaySpan,
      textDirection: TextDirection.ltr,
    );
    awayPainter.layout();
    
    final awayEndZoneCenter = size.height - (size.height * endZoneRatio / 2);
    awayPainter.paint(
      canvas,
      Offset(
        (size.width - awayPainter.width) / 2,
        awayEndZoneCenter - awayPainter.height / 2,
      ),
    );
  }

  void _drawDiscMarker(Canvas canvas, Size size, double x, double y) {
    final discX = x * size.width;
    final discY = y * size.height;
    
    // Disc glow
    final glowPaint = Paint()
      ..color = AppTheme.primaryGreen.withValues(alpha:0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawCircle(Offset(discX, discY), 25, glowPaint);
    
    // Disc outer ring
    final ringPaint = Paint()
      ..color = AppTheme.primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(discX, discY), 15, ringPaint);
    
    // Disc center
    final discPaint = Paint()..color = AppTheme.primaryGreen;
    canvas.drawCircle(Offset(discX, discY), 8, discPaint);
    
    // Pulse animation ring (static for now)
    final pulsePaint = Paint()
      ..color = AppTheme.primaryGreen.withValues(alpha:0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(discX, discY), 25, pulsePaint);
  }

  void _drawTapHint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: AppTheme.lineWhite.withValues(alpha:0.4),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    
    final span = TextSpan(text: 'Tap to mark disc position', style: textStyle);
    final painter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    
    painter.paint(
      canvas,
      Offset(
        (size.width - painter.width) / 2,
        (size.height - painter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant FieldPainter oldDelegate) {
    return discX != oldDelegate.discX ||
           discY != oldDelegate.discY ||
           possession != oldDelegate.possession ||
           homeTeamName != oldDelegate.homeTeamName ||
           awayTeamName != oldDelegate.awayTeamName;
  }
}

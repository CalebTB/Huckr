import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Golden Hour Theme
/// Design: Warm sunset & amber glow - A rich, luxurious theme inspired by golden hour photography
class AppTheme {
  // Private constructor
  AppTheme._();

  // ============================================
  // GOLDEN HOUR COLORS
  // ============================================

  // Dark Mode Colors
  static const Color background = Color(0xFF0C0A05);
  static const Color surface = Color(0xFF141008);
  static const Color card = Color(0xFF1E1810);
  static const Color cardBorder = Color(0xFF382C1A);

  // Text Colors (Dark Mode)
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFC4A878);
  static const Color textTertiary = Color(0xFF8A7550);

  // Accent Colors
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);
  static const Color accentMuted = Color(0x26F59E0B); // 15% opacity

  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Light Mode Colors
  static const Color backgroundLight = Color(0xFFFFFDF5);
  static const Color surfaceLight = Color(0xFFFFF9E8);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardBorderLight = Color(0xFFFFE8B8);
  static const Color textPrimaryLight = Color(0xFF1E1810);
  static const Color textSecondaryLight = Color(0xFF8A7550);
  static const Color textTertiaryLight = Color(0xFFC4A878);

  // Field Colors (for ultimate frisbee field visualization)
  static const Color fieldGreen = Color(0xFF2D5016);
  static const Color fieldGreenLight = Color(0xFF3D6B1E);
  static const Color endZoneColor = Color(0xFF1E3A0F);
  static const Color lineWhite = Color(0xFFFFFFFF);

  // ============================================
  // LEGACY COLOR ALIASES
  // These map old color names to Golden Hour equivalents
  // ============================================

  // Primary colors (mapped to accent)
  static const Color primaryGreen = accent;  // Primary action color
  static const Color primaryDark = background;  // Dark background

  // Gray scale
  static const Color gray200 = Color(0xFFE5E5E5);  // Lightest gray
  static const Color gray300 = Color(0xFFD4D4D4);
  static const Color gray400 = textSecondary;  // Secondary text
  static const Color gray500 = textTertiary;  // Tertiary text
  static const Color gray600 = Color(0xFF525252);
  static const Color gray700 = cardBorder;  // Borders
  static const Color gray800 = surface;  // Dark surface

  // Accent colors for different actions
  static const Color accentBlue = info;  // Defensive plays (blocks)
  static const Color accentPurple = Color(0xFF8B5CF6);  // Special plays (Callahan)
  static const Color accentOrange = warning;  // Goals, trophies

  // ============================================
  // TYPOGRAPHY
  // ============================================

  static TextTheme get _textTheme {
    return TextTheme(
      // Display - for big scores and hero text
      displayLarge: GoogleFonts.inter(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
        height: 1.0,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        height: 1.1,
      ),

      // Headlines - section headers
      headlineLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.25,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),

      // Titles - card headers, list items
      titleLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.4,
      ),

      // Body - main content
      bodyLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
      ),

      // Labels - buttons, chips, small UI
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5, // For uppercase section headers
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.4,
      ),
    );
  }

  // Mono font for stats and numbers
  static TextStyle get monoStyle => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // ============================================
  // DARK THEME (Primary - Golden Hour)
  // ============================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Colors
      colorScheme: const ColorScheme.dark(
        primary: accent,
        onPrimary: Color(0xFF000000),
        secondary: accentLight,
        onSecondary: Color(0xFF000000),
        tertiary: textSecondary,
        surface: surface,
        onSurface: textPrimary,
        surfaceContainerHighest: card,
        error: error,
        onError: Colors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: background,

      // Typography
      textTheme: _textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: cardBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      ),

      // Buttons - Primary (Gradient style simulated with solid)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ).copyWith(
          shadowColor: WidgetStatePropertyAll(accent.withValues(alpha: 0.4)),
        ),
      ),

      // Secondary/Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          backgroundColor: accentMuted,
          side: BorderSide(color: accent.withValues(alpha: 0.3), width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Ghost/Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: textSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: background,
        selectedItemColor: accent,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: cardBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: cardBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: GoogleFonts.inter(
          color: textTertiary,
          fontSize: 15,
        ),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: card,
        selectedColor: accentMuted,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: cardBorder),
        ),
        side: const BorderSide(color: cardBorder),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: cardBorder,
        thickness: 1,
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: card,
        contentTextStyle: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: cardBorder,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        shape: const Border(bottom: BorderSide(color: cardBorder)),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        subtitleTextStyle: GoogleFonts.inter(
          fontSize: 13,
          color: textSecondary,
        ),
      ),

      // Tab Bar
      tabBarTheme: TabBarThemeData(
        labelColor: accent,
        unselectedLabelColor: textTertiary,
        indicatorColor: accent,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ============================================
  // LIGHT THEME
  // ============================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: accentDark,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.black,
        tertiary: textSecondaryLight,
        surface: cardLight,
        onSurface: textPrimaryLight,
        surfaceContainerHighest: surfaceLight,
        error: error,
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: backgroundLight,

      textTheme: _textTheme.apply(
        bodyColor: textPrimaryLight,
        displayColor: textPrimaryLight,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        foregroundColor: textPrimaryLight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.5,
        ),
      ),

      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: cardBorderLight, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentDark,
          side: BorderSide(color: accentDark.withValues(alpha: 0.3), width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: cardBorderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: cardBorderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: accentDark, width: 2),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundLight,
        selectedItemColor: accentDark,
        unselectedItemColor: textTertiaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      dividerTheme: const DividerThemeData(
        color: cardBorderLight,
        thickness: 1,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceLight,
        selectedColor: const Color(0x1AD97706), // 10% accentDark
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: cardBorderLight),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accentDark,
        linearTrackColor: cardBorderLight,
      ),
    );
  }
}

// ============================================
// CUSTOM EXTENSIONS
// ============================================

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Quick access to Golden Hour colors
  Color get primaryColor => AppTheme.accent;
  Color get backgroundColor => theme.scaffoldBackgroundColor;
  Color get surfaceColor => theme.colorScheme.surface;
  Color get cardColor => AppTheme.card;
  Color get borderColor => AppTheme.cardBorder;

  // Text colors
  Color get textColor => AppTheme.textPrimary;
  Color get secondaryTextColor => AppTheme.textSecondary;
  Color get tertiaryTextColor => AppTheme.textTertiary;

  // Semantic colors
  Color get errorColor => AppTheme.error;
  Color get successColor => AppTheme.success;
  Color get accentColor => AppTheme.accent;

  // Is dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;
}

// ============================================
// GOLDEN HOUR SPECIFIC STYLES
// ============================================

class GoldenHourStyles {
  GoldenHourStyles._();

  // Section header style (uppercase, tracked)
  static TextStyle sectionHeader(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppTheme.textSecondary,
      letterSpacing: 1.5,
    );
  }

  // Score display style
  static TextStyle scoreStyle({Color? color, bool isWinning = false}) {
    return GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: color ?? (isWinning ? AppTheme.accent : AppTheme.textSecondary),
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  // Large score (for game view)
  static TextStyle largeScoreStyle({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 72,
      fontWeight: FontWeight.w700,
      color: color ?? AppTheme.textPrimary,
      height: 1.0,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  // Stat value style
  static TextStyle statValueStyle({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: color ?? AppTheme.accent,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  // Stat label style
  static TextStyle statLabelStyle() {
    return GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppTheme.textSecondary,
    );
  }

  // Badge styles
  static BoxDecoration winBadge() {
    return BoxDecoration(
      color: AppTheme.success.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
    );
  }

  static BoxDecoration lossBadge() {
    return BoxDecoration(
      color: AppTheme.error.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    );
  }

  static BoxDecoration accentBadge() {
    return BoxDecoration(
      color: AppTheme.accentMuted,
      borderRadius: BorderRadius.circular(5),
    );
  }

  // Card decoration with optional glow
  static BoxDecoration cardDecoration({bool featured = false, Color? glowColor}) {
    return BoxDecoration(
      color: AppTheme.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: featured ? AppTheme.accent.withValues(alpha: 0.3) : AppTheme.cardBorder,
        width: 1,
      ),
      boxShadow: featured
          ? [
              BoxShadow(
                color: (glowColor ?? AppTheme.accent).withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ]
          : null,
    );
  }

  // Gradient button decoration
  static BoxDecoration gradientButtonDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppTheme.accentLight, AppTheme.accent],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppTheme.accent.withValues(alpha: 0.4),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Icon container with muted background
  static BoxDecoration iconContainerDecoration() {
    return BoxDecoration(
      color: AppTheme.accentMuted,
      borderRadius: BorderRadius.circular(12),
    );
  }

  // Progress bar track
  static BoxDecoration progressTrack() {
    return BoxDecoration(
      color: AppTheme.cardBorder,
      borderRadius: BorderRadius.circular(3),
    );
  }

  // Progress bar fill gradient
  static BoxDecoration progressFill() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppTheme.accent, AppTheme.accentLight],
      ),
      borderRadius: BorderRadius.circular(3),
    );
  }
}

// ============================================
// LIVE INDICATOR WIDGET HELPER
// ============================================

class LiveIndicator extends StatelessWidget {
  const LiveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppTheme.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'LIVE',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.error,
          ),
        ),
      ],
    );
  }
}

// ============================================
// APP STYLES
// Common text styles used across the app
// ============================================

class AppStyles {
  AppStyles._();

  /// Score display style - large numbers for game scores
  static TextStyle scoreStyle(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 56,
      fontWeight: FontWeight.w700,
      color: AppTheme.textPrimary,
      height: 1.0,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  /// Clock display style - monospace for time display
  static TextStyle clockStyle(BuildContext context) {
    return GoogleFonts.jetBrainsMono(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppTheme.textPrimary,
      height: 1.0,
    );
  }
}

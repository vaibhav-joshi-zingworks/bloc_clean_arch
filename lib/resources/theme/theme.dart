import '../../core.dart';

/// Centralized theme configuration for the application.
/// 
/// Provides both [light] and [dark] theme definitions following Material 3 guidelines.
class AppTheme {
  /// Default font family used throughout the app.
  static const String _font = FontFamily.flink;

  // Standard corner radii for UI components
  static const double _radiusSmall = 6;
  static const double _radiusMedium = 12;
  static const double _radiusLarge = 16;

  /// Returns the Light Theme configuration.
  static ThemeData get light => _buildTheme(Brightness.light);

  /// Returns the Dark Theme configuration.
  static ThemeData get dark => _buildTheme(Brightness.dark);

  /// Internal builder to generate [ThemeData] based on [Brightness].
  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    /// Base Color Theme generated from the primary brand color.
    final baseScheme = ColorScheme.fromSeed(seedColor: AppColorPalette.primary, brightness: brightness);

    /// Customizes the color scheme for branding and specific UI states.
    final colorScheme = baseScheme.copyWith(
      primary: AppColorPalette.primary,
      onPrimary: AppColorPalette.white,
      secondary: AppColorPalette.orangeAccent,
      onSecondary: AppColorPalette.white,
      tertiary: AppColorPalette.green,
      onTertiary: AppColorPalette.white,
      error: AppColorPalette.red,
      onError: AppColorPalette.white,
      surface: isLight ? AppColorPalette.lightSurface : AppColorPalette.darkSurface,
      onSurface: isLight ? AppColorPalette.black : AppColorPalette.white,
      onSurfaceVariant: isLight ? AppColorPalette.grey : AppColorPalette.lightGrey,
    );

    /// Generates the typography theme.
    final textTheme = _createTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: _font,
      colorScheme: colorScheme,
      textTheme: textTheme,

      /// Scaffold background
      scaffoldBackgroundColor: colorScheme.surface,

      /// AppBar Configuration
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isLight ? AppColorPalette.white : AppColorPalette.black,
          systemNavigationBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        ),
      ),

      /// Card Appearance
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
      ),

      /// Dialog Appearance
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusMedium)),
      ),

      /// SnackBar Appearance
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
      ),

      /// Divider Appearance
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, thickness: 1),

      /// Button Styles
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusLarge)),
        ),
      ),

      /// Input Field (TextField) Appearance
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? AppColorPalette.white : const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide(color: AppColorPalette.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide(color: AppColorPalette.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
      ),

      /// Checkbox Appearance
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),

      /// Switch Appearance
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(colorScheme.primary),
        trackColor: WidgetStateProperty.all(colorScheme.primary.withValues(alpha: 0.4)),
      ),

      /// Radio Button Appearance
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(colorScheme.primary)),

      /// ListTile Appearance
      listTileTheme: ListTileThemeData(iconColor: colorScheme.onSurface, textColor: colorScheme.onSurface),

      /// Bottom Navigation Bar Appearance
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
      ),

      /// Progress Indicator Appearance
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),

      /// Text Selection Colors
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withValues(alpha: 0.3),
        selectionHandleColor: colorScheme.primary,
      ),
    );
  }

  /// Creates a [TextTheme] that adapts to the [ColorScheme].
  static TextTheme _createTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: _baseStyle(32, colorScheme.onSurface),
      displayMedium: _baseStyle(28, colorScheme.onSurface),
      displaySmall: _baseStyle(24, colorScheme.onSurface),

      headlineLarge: _baseStyle(24, colorScheme.onSurface, FontWeight.w700),
      headlineMedium: _baseStyle(22, colorScheme.onSurface, FontWeight.w600),
      headlineSmall: _baseStyle(20, colorScheme.onSurface, FontWeight.w500),

      titleLarge: _baseStyle(18, colorScheme.onSurface, FontWeight.w700),
      titleMedium: _baseStyle(16, colorScheme.onSurface, FontWeight.w600),
      titleSmall: _baseStyle(14, colorScheme.onSurface, FontWeight.w500),

      bodyLarge: _baseStyle(16, colorScheme.onSurface, FontWeight.w500),
      bodyMedium: _baseStyle(14, colorScheme.onSurface, FontWeight.w400),
      bodySmall: _baseStyle(12, colorScheme.onSurfaceVariant, FontWeight.w400),

      labelLarge: _baseStyle(14, colorScheme.onSurface, FontWeight.w500),
      labelMedium: _baseStyle(12, colorScheme.onSurfaceVariant, FontWeight.w500),
      labelSmall: _baseStyle(11, colorScheme.onSurfaceVariant, FontWeight.w400),
    );
  }

  /// Utility to create a [TextStyle] with consistent font and weight.
  static TextStyle _baseStyle(double size, Color color, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: color);
  }
}

import 'package:flutter/material.dart';
import 'google_fonts_typography.dart';

class AppTheme {
  
  // Color constants
  static const Color primaryGold = Color(0xffF84889);
  static const Color secondaryGold = Color(0xFFBFA054);
  static const Color darkPrimary = Color(0xFFFFECF3); // Main background (light pink)
  static const Color darkSecondary =
      Color(0xFFE8E8E8); // Secondary background (light gray)
  static const Color darkTertiary =
      Color(0xFFDDDDDD); // Tertiary background (lighter gray)
  static const Color lightText = Color(0xFF1A1A1A); // Primary text (dark)
  static const Color appBarColor = Color(0xFF1A1A1A); // App bars (black)
  static const Color buttonColor = Color(0xFFD6A499); // Buttons (black)

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD6A499),
      Color(0xFFD6A499),
      Color(0xFFD6A499),
    ],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0x99FFFFFF),
      Color(0xFFF5F5F5),
    ],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter', // Default font
      colorScheme: ColorScheme.light(
        primary: primaryGold,
        secondary: secondaryGold,
        surface: darkSecondary,
        onPrimary: Colors.white,
        onSecondary: lightText,
        onSurface: lightText,
      ),
      scaffoldBackgroundColor: darkPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: AppTypography.withColor(AppTypography.heading2, Colors.white),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: appBarColor,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appBarColor,
        selectedItemColor: primaryGold,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // As per design spec
          ),
          textStyle: AppTypography.buttonText,
          minimumSize: const Size(double.infinity, 60), // As per design spec
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: buttonColor,
          textStyle: AppTypography.buttonText,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: buttonColor,
        foregroundColor: primaryGold,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),
        labelStyle: AppTypography.withColor(AppTypography.labelMedium, lightText.withOpacity(0.7)),
        hintStyle: AppTypography.withColor(AppTypography.bodyMedium, lightText.withOpacity(0.5)),
      ),
      textTheme: AppTypography.createTextTheme().apply(
        bodyColor: lightText,
        displayColor: lightText,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconTheme: IconThemeData(
        color: lightText.withOpacity(0.8),
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: lightText.withOpacity(0.1),
        thickness: 1,
        space: 24,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkSecondary,
        selectedColor: primaryGold,
        labelStyle: AppTypography.withColor(AppTypography.labelSmall, lightText),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppTheme.primaryGold,
        ),
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme;
}

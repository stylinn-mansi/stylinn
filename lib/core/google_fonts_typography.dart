import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// # Typography Design System
/// 
/// A comprehensive typography system for the Stylinn app that provides consistent
/// text styling throughout the application. This system uses Google Fonts for
/// Playfair Display and Inter font families.
/// 
/// ## Font Families:
/// - **Playfair Display**: Used for headings and display text
/// - **Inter**: Used for body text and UI elements
/// 
/// ## Usage:
/// ```dart
/// Text('Heading', style: AppTypography.heading1);
/// Text('Body text', style: AppTypography.bodyLarge);
/// ```
class AppTypography {
  AppTypography._(); // Private constructor to prevent instantiation

  /// Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  /// Line heights
  static const double _tightLineHeight = 1.2;
  static const double _normalLineHeight = 1.33;
  static const double _relaxedLineHeight = 1.5;

  /// Letter spacing
  static const double _tightLetterSpacing = 0;
  static const double _normalLetterSpacing = -1.0;
  static const double _wideLetterSpacing = 0.0;

  // ======== DISPLAY TEXT STYLES ========
  // Used for large, prominent text elements like page titles and hero sections

  /// Display 1 - Largest display text (36px)
  /// 
  /// Used for hero sections and main landing pages
  static TextStyle get display1 => GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: bold,
    letterSpacing: _tightLetterSpacing,
    height: _tightLineHeight,
  );

  /// Display 2 - Secondary display text (32px)
  /// 
  /// Used for major section headers
  static TextStyle get display2 => GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: bold,
    letterSpacing: _tightLetterSpacing,
    height: _tightLineHeight,
  );

  // ======== HEADING TEXT STYLES ========
  // Used for section headers and content organization

  /// Heading 1 - Primary heading (28px, Bold)
  /// 
  /// Used for main page headings and important sections
  static TextStyle get heading1 => GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: bold,
    letterSpacing: _normalLetterSpacing,
    height: _tightLineHeight,
  );

  /// Heading 2 - Secondary heading (27px, SemiBold)
  /// 
  /// Used for section headings and card titles
  static TextStyle get heading2 => GoogleFonts.playfairDisplay(
    fontSize: 27,
    fontWeight: semiBold,
    letterSpacing: _tightLetterSpacing,
    height: _normalLineHeight,
  );

  /// Heading 3 - Tertiary heading (24px, SemiBold)
  /// 
  /// Used for subsection headings
  static TextStyle get heading3 => GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: semiBold,
    letterSpacing: _normalLetterSpacing,
    height: _normalLineHeight,
  );

  /// Heading 4 - Quaternary heading (20px, SemiBold)
  /// 
  /// Used for minor section headings and emphasized content
  static TextStyle get heading4 => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: semiBold,
    letterSpacing: _normalLetterSpacing,
    height: _normalLineHeight,
  );

  // ======== BODY TEXT STYLES ========
  // Used for main content text

  /// Body Large - Primary body text (18px, Regular)
  /// 
  /// Used for primary content and important information
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: regular,
    letterSpacing: _wideLetterSpacing,
    height: _normalLineHeight,
  );

  /// Body Medium - Standard body text (16px, Regular)
  /// 
  /// Used for most body content throughout the app
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: regular,
    letterSpacing: _wideLetterSpacing,
    height: _normalLineHeight,
  );

  /// Body Small - Smaller body text (14px, Regular)
  /// 
  /// Used for secondary information and supporting text
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: regular,
    letterSpacing: _wideLetterSpacing,
    height: _normalLineHeight,
  );

  // ======== LABEL TEXT STYLES ========
  // Used for UI elements, buttons, and form fields

  /// Label Large - Large label text (18px, SemiBold)
  /// 
  /// Used for primary buttons and important UI elements
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: semiBold,
    letterSpacing: _wideLetterSpacing,
    height: _tightLineHeight,
  );

  /// Label Medium - Medium label text (16px, SemiBold)
  /// 
  /// Used for secondary buttons and form labels
  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: semiBold,
    letterSpacing: _wideLetterSpacing,
    height: _tightLineHeight,
  );

  /// Label Small - Small label text (14px, Medium)
  /// 
  /// Used for smaller UI elements and supporting labels
  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: _wideLetterSpacing,
    height: _tightLineHeight,
  );

  // ======== CAPTION TEXT STYLES ========
  // Used for supplementary information

  /// Caption - Small supporting text (12px, Regular)
  /// 
  /// Used for timestamps, metadata, and footnotes
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: _wideLetterSpacing,
    height: _normalLineHeight,
  );

  /// Caption Bold - Emphasized small text (12px, Medium)
  /// 
  /// Used for emphasized captions and small but important information
  static TextStyle get captionBold => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: _wideLetterSpacing,
    height: _normalLineHeight,
  );

  // ======== UTILITY STYLES ========
  // Special purpose text styles

  /// Button Text - Text style for buttons (16px, SemiBold)
  /// 
  /// Consistent text style for all buttons
  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: semiBold,
    letterSpacing: _wideLetterSpacing,
    height: _tightLineHeight,
  );

  /// Link Text - Text style for links (inherit size, Medium)
  /// 
  /// Used for text links and interactive text elements
  static TextStyle get linkText => GoogleFonts.inter(
    fontWeight: medium,
    decoration: TextDecoration.underline,
  );

  /// Overline - All caps small text (10px, Medium, uppercase)
  /// 
  /// Used for labels, categories, and section markers
  static TextStyle get overline => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: medium,
    letterSpacing: 1.5,
    height: _normalLineHeight,
    textBaseline: TextBaseline.alphabetic,
  );

  // ======== HELPER METHODS ========
  // Utility methods for text style modifications

  /// Creates a Flutter TextTheme using this typography system
  /// 
  /// This method can be used when setting up the app theme
  static TextTheme createTextTheme() {
    return TextTheme(
      displayLarge: display1,
      displayMedium: display2,
      displaySmall: heading1,
      
      headlineLarge: heading1,
      headlineMedium: heading2,
      headlineSmall: heading3,
      
      titleLarge: heading3,
      titleMedium: heading4,
      titleSmall: labelLarge,
      
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  /// Applies a color to any text style
  /// 
  /// ```dart
  /// Text('Colored text', style: AppTypography.withColor(AppTypography.bodyLarge, Colors.blue));
  /// ```
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Creates a style with custom letter spacing
  /// 
  /// ```dart
  /// Text('Spaced text', style: AppTypography.withLetterSpacing(AppTypography.heading1, 1.5));
  /// ```
  static TextStyle withLetterSpacing(TextStyle style, double letterSpacing) {
    return style.copyWith(letterSpacing: letterSpacing);
  }

  /// Creates a style with custom line height
  /// 
  /// ```dart
  /// Text('Text with custom line height', style: AppTypography.withLineHeight(AppTypography.bodyLarge, 1.8));
  /// ```
  static TextStyle withLineHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Creates a style with custom font weight
  /// 
  /// ```dart
  /// Text('Bold text', style: AppTypography.withWeight(AppTypography.bodyMedium, FontWeight.bold));
  /// ```
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
} 
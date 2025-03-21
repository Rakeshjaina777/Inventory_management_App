import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // **Light Theme Colors & Constants**
  static const Color primaryColor = Color(0xFF008181);
  static const Color onprimaryColor = Colors.white;


  static const Color backgroundColor = Colors.white;
  static const Color onbackgroundColor = Color(0xFF4B5162);
  // static const Color surfaceColor = Color(0xFFF5F5F5);

  static const Color secondaryColor = Color(0xFF66B2B2);
  static const Color onsecondaryColor = Color(0xFFB2DFDB);


  static const Color  tertiary=Color(0xFFD9D9D9);
  static const Color  ontertiary=Color(0xFF1E1E1E);




  static const Color primaryVariant = Color(0xFF00A89D);

  // static const Color  tertiary=Color(0xFFB2DFDB);

  static const Color errorColor = Color(0xFFB2DFDB);
  static const Color onErrorColor = Colors.white;

  static const Color shadowColor = Color(0xFF8D8D8D); // Even softer shade

  static const Color scrimColor = Colors.black45;


  // static const Color textColor = Color(0xFF004D40);
  // static const Color hintTextColor = Color(0xFFB2DFDB);
  // static const Color noticeColor = Color(0xFF121212);
  //
  static const Color surface = Color(0xFF66B2B2);
  static const Color onsurface = Color(0xFF00A89D);

  static const Color outlineColor = Color(0xFF00796B);
  static const Color outlineVariant =  Color(0xFFB2DFDB);

  // static const Color surface = Color(0xFF00A89D);


  // **Dark Theme Colors & Constants**
  static const Color darkPrimaryColor = Color(0xFF00B7A5);  // Vibrant Teal
  static const Color darkOnPrimaryColor = Colors.black;

  static const Color darkBackgroundColor = Color(0xFF212529); // Deep Black
  static const Color darkOnBackgroundColor = Colors.white;

  static const Color darkSecondaryColor = Color(0xFF4E9C9C);  // Muted Teal
  static const Color darkOnSecondaryColor = Color(0xFFB2DFDB);

  static const Color darkTertiary = Color(0xFF9E9E9E);  // Light Gray
  static const Color darkOnTertiary = Color(0xFFE0E0E0);  // Off White

  static const Color darkPrimaryVariant = Color(0xFF008C83);  // Darker Teal

  static const Color darkErrorColor = Color(0xFFFF5252);  // Bright Red for errors
  static const Color darkOnErrorColor = Colors.black;

  static const Color darkShadowColor = Colors.black87;
  static const Color darkScrimColor = Colors.black54;

  static const Color darkSurface = Color(0xFF1E1E1E);  // Dark Gray Surface
  static const Color darkOnSurface = Color(0xFF00B7A5);

  static const Color darkOutlineColor = Color(0xFF4E9C9C);
  static const Color darkOutlineVariant = Color(0xFF80CBC4);


  /// **Light Theme**
  static ThemeData lightTheme(double scale) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,

      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.light(


        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiary,
        surface:  surface,
        background: backgroundColor,
        onBackground: onbackgroundColor,

        error: errorColor,
        onPrimary: onprimaryColor,
        onTertiary: ontertiary,
        onSecondary: onsecondaryColor,
        onSurface: surface,
        onError: onsurface,
        outline: outlineColor,
        outlineVariant: outlineVariant,
        // Additional properties can be added here if needed.
        scrim: scrimColor,
        shadow: shadowColor,

      ),
      textTheme: _lightTextTheme(scale),
      inputDecorationTheme: _inputThemeLight(scale),
      elevatedButtonTheme: _elevatedButtonThemeLight(scale),
    );
  }

  /// **Dark Theme**
  static ThemeData darkTheme(double scale) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        tertiary: darkTertiary,
        background: darkBackgroundColor,
        surface: darkSurface,
        error: darkErrorColor,
        onPrimary: darkOnPrimaryColor,
        onSecondary: darkOnSecondaryColor,
        onTertiary: darkOnTertiary,
        onSurface: darkOnSurface,
        onBackground: darkOnBackgroundColor,
        onError: darkOnErrorColor,
        outline: darkOutlineColor,
        scrim: darkScrimColor,


      ),
      textTheme: _darkTextTheme(scale),
      inputDecorationTheme: _inputThemeDark(scale),
      elevatedButtonTheme: _elevatedButtonThemeDark(scale),

    );
  }

  /// **Light Text Theme**
  static TextTheme _lightTextTheme(double scale) => TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32 * scale,
      fontWeight: FontWeight.bold,
      color: onbackgroundColor,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28 * scale,
      fontWeight: FontWeight.bold,
      color: onbackgroundColor,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24 * scale,
      fontWeight: FontWeight.bold,
      color: onbackgroundColor,
    ),



    headlineLarge: GoogleFonts.poppins(
      fontSize: 24 * scale,
      color: onbackgroundColor,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 22 * scale,
      color: onbackgroundColor,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 20 * scale,
      color: onbackgroundColor,
    ),


    bodyLarge: GoogleFonts.poppins(
      fontSize: 16 * scale,
      color: onbackgroundColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14 * scale,
      color: onbackgroundColor,
    ),

    labelMedium: GoogleFonts.poppins(
      fontSize: 14 * scale,
      color: onbackgroundColor,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12 * scale,
      color: onbackgroundColor,
    ),

  );

  /// **Dark Text Theme**
  static TextTheme _darkTextTheme(double scale) => TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32 * scale,
      fontWeight: FontWeight.bold,
      color: darkOnBackgroundColor,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28 * scale,
      fontWeight: FontWeight.bold,
      color: darkOnBackgroundColor,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24 * scale,
      fontWeight: FontWeight.bold,
      color: darkOnBackgroundColor,
    ),

    headlineLarge: GoogleFonts.poppins(
      fontSize: 24 * scale,
      color: darkOnBackgroundColor,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 22 * scale,
      color: darkOnBackgroundColor,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 20 * scale,
      color: darkOnBackgroundColor,
    ),

    bodyLarge: GoogleFonts.poppins(
      fontSize: 16 * scale,
      color: darkOnBackgroundColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14 * scale,
      color: darkOnBackgroundColor,
    ),

    labelMedium: GoogleFonts.poppins(
      fontSize: 14 * scale,
      color: darkOnBackgroundColor,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12 * scale,
      color: darkOnBackgroundColor,
    ),
  );

  /// **Light Input Decoration Theme**
  static InputDecorationTheme _inputThemeLight(double scale) =>
      InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16 * scale, vertical: 14 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: BorderSide(color: primaryVariant),
        ),
      );

  /// **Dark Input Decoration Theme**
  static InputDecorationTheme _inputThemeDark(double scale) =>
      InputDecorationTheme(
        filled: true,
        fillColor: darkBackgroundColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16 * scale, vertical: 14 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: BorderSide(color: darkOutlineColor),
        ),
      );

  /// **Light Elevated Button Theme**
  static ElevatedButtonThemeData _elevatedButtonThemeLight(double scale) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onprimaryColor,
          padding: EdgeInsets.symmetric(
              vertical: 14 * scale, horizontal: 20 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12 * scale),
          ),
        ),
      );

  /// **Dark Elevated Button Theme**
  static ElevatedButtonThemeData _elevatedButtonThemeDark(double scale) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: onprimaryColor,
          padding: EdgeInsets.symmetric(
              vertical: 14 * scale, horizontal: 20 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12 * scale),
          ),
        ),
      );




}


//
// Final Summary of Usage
// 1. Display Text Styles (Used for large titles, hero sections, or banners)
// Display Large (32px): Used for main page headings (e.g., "Welcome to Our App").
// Display Medium (28px): Used for section titles (e.g., "Our Features").
// Display Small (24px): Used for subtitles or smaller headings (e.g., "Why Choose Us?").



// 2. Headline Text Styles (Used for section headings and content highlights)
// Headline Large (24px): Used for major section headings (e.g., "Latest News").
// Headline Medium (22px): Used for subsection headings (e.g., "Upcoming Events").
// Headline Small (20px): Used for card titles or small sections (e.g., "Our Partners").


// 3. Body Text Styles (Used for paragraphs and descriptions)
// Body Large (16px): Used for primary text content (e.g., article text, descriptions).
// Body Medium (14px): Used for smaller text content (e.g., additional details, captions).


// 4. Label Text Styles (Used for buttons, tags, and small text elements)
// Label Medium (14px): Used for buttons, tags, and interactive elements.
// Label Small (12px): Used for footnotes, hints, or extra small text.
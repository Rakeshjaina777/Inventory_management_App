import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ✅ Light Theme Configuration
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.green,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(color: Colors.black87),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    dataTableTheme: const DataTableThemeData(
      headingRowColor: MaterialStatePropertyAll(Colors.grey),
      dataRowColor: MaterialStatePropertyAll(Colors.white),
    ),
  );

  // ✅ Dark Theme Configuration
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.green,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(color: Colors.white70),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    dataTableTheme: const DataTableThemeData(
      headingRowColor: MaterialStatePropertyAll(Colors.grey),
      dataRowColor: MaterialStatePropertyAll(Colors.black87),
    ),
  );
}

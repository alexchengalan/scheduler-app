import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Mode Colors
  static const _lightBackground = Color(0xFFFFFFFF);
  static const _lightCard = Color(0xFFFFFFFF);
  static const _lightTitleText = Color(0xFF1D2D44);
  static const _lightDescriptionText = Color(0xFF545454);
  static const _lightButtonBackground = Color(0xFF023047);
  static const _lightButtonText = Colors.white;
  static const _bottomAppBarBackground = Color(0xFF1D2D44);
  static const _accentColor = Colors.amber;

  // Dark Mode Colors
  static const _darkBackground = Color(0xFF0F1117);
  static const _darkCard = Color(0xFF1C1F26);
  static const _darkTitleText = Color(0xFFFFFFFF);
  static const _darkDescriptionText = Color(0xFFB0B3B8);
  static const _darkButtonBackground = Color(0xFFF1F1F1);
  static const _darkButtonText = Colors.black;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: _accentColor,
    scaffoldBackgroundColor: _lightBackground,
    cardColor: _lightCard,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineMedium: GoogleFonts.cabin(
        color: _lightTitleText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.cabin(
        color: _lightTitleText,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.poppins(color: _lightDescriptionText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightButtonBackground,
        foregroundColor: _lightButtonText,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        iconColor: _lightButtonText
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.poppins(
        color: _lightTitleText,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.poppins(
        color: _lightDescriptionText,
        fontWeight: FontWeight.w400,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.poppins(
        color: _lightTitleText,
        fontWeight: FontWeight.w500,
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: GoogleFonts.cabin(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: _lightTitleText,
      ),
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: _lightDescriptionText,
      ),
    ),
    iconTheme: IconThemeData(color: _lightTitleText),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightBackground,
      selectedItemColor: _lightTitleText,
      unselectedItemColor: _lightDescriptionText,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: _bottomAppBarBackground,
      elevation: 2,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _accentColor,
      foregroundColor: _lightButtonText,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: _lightCard,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: _accentColor,
    scaffoldBackgroundColor: _darkBackground,
    cardColor: _darkCard,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineMedium: GoogleFonts.cabin(
        color: _darkTitleText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.cabin(
        color: _darkTitleText,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.poppins(color: _darkTitleText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkButtonBackground,
        foregroundColor: _darkButtonText,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        iconColor: _darkButtonText
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.poppins(
        color: _darkTitleText,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.poppins(
        color: _darkDescriptionText,
        fontWeight: FontWeight.w400,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(fillColor: _lightCard),
      textStyle: GoogleFonts.poppins(
        color: _darkTitleText,
        backgroundColor: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: GoogleFonts.cabin(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: _darkTitleText,
      ),
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: _darkDescriptionText,
      ),
    ),
    iconTheme: IconThemeData(color: _darkTitleText),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkBackground,
      selectedItemColor: _darkTitleText,
      unselectedItemColor: _darkDescriptionText,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: _darkCard, elevation: 2),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _accentColor,
      foregroundColor: _darkButtonText,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      tileColor: _darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}

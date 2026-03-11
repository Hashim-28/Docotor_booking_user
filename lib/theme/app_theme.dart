import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Teal palette
  static const Color primary = Color(0xFF00BFA5);
  static const Color primaryDark = Color(0xFF008C7A);
  static const Color primaryLight = Color(0xFFB2DFDB);
  static const Color accent = Color(0xFF00E5CC);
  static const Color background = Color(0xFFEEF2F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFF0F4F8);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textMedium = Color(0xFF718096);
  static const Color textLight = Color(0xFFA0AEC0);
  static const Color error = Color(0xFFE53E3E);
  static const Color success = Color(0xFF38A169);
  static const Color warning = Color(0xFFDD6B20);
  static const Color star = Color(0xFFF6C90E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: surface,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w700, fontSize: 28),
        displayMedium: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w700, fontSize: 24),
        displaySmall: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w600, fontSize: 20),
        headlineMedium: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w600, fontSize: 18),
        headlineSmall: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: GoogleFonts.poppins(color: textDark, fontSize: 15),
        bodyMedium: GoogleFonts.poppins(color: textMedium, fontSize: 13),
        bodySmall: GoogleFonts.poppins(color: textLight, fontSize: 12),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
            color: textDark, fontWeight: FontWeight.w600, fontSize: 18),
        iconTheme: const IconThemeData(color: textDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1.5),
        ),
        hintStyle: GoogleFonts.poppins(color: textLight, fontSize: 14),
        labelStyle: GoogleFonts.poppins(color: textMedium, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }

  // Soft-UI shadow (neumorphic outward)
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.white.withOpacity(0.9),
      offset: const Offset(-4, -4),
      blurRadius: 10,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: const Color(0xFFB8C4CE).withOpacity(0.5),
      offset: const Offset(4, 4),
      blurRadius: 10,
      spreadRadius: 1,
    ),
  ];

  // Soft-UI shadow (inward/pressed)
  static List<BoxShadow> softShadowPressed = [
    BoxShadow(
      color: const Color(0xFFB8C4CE).withOpacity(0.4),
      offset: const Offset(4, 4),
      blurRadius: 10,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.9),
      offset: const Offset(-4, -4),
      blurRadius: 10,
      spreadRadius: 1,
    ),
  ];

  // Card shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.07),
      offset: const Offset(0, 4),
      blurRadius: 15,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.8),
      offset: const Offset(0, -2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
}

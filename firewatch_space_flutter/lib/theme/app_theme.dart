import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF08080F);
  static const card = Color(0xFF0D0D1A);
  static const primary = Color(0xFFFF4500);
  static const secondary = Color(0xFFFF8C00);
  static const accent = Color(0xFF00FF88);
  static const destructive = Color(0xFFFF2040);
  static const muted = Color(0xFF16162A);
  static const mutedForeground = Color(0xFF7A7A9A);
  static const border = Color(0xFF1E1E35);
  static const text = Color(0xFFFFFFFF);
  static const riskHigh = Color(0xFFFF2040);
  static const riskMedium = Color(0xFFFF8C00);
  static const riskLow = Color(0xFF00FF88);
  static const neonBlue = Color(0xFF00BFFF);
  static const amber = Color(0xFFFFB300);
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.card,
        background: AppColors.background,
        error: AppColors.destructive,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.text,
        onBackground: AppColors.text,
        outline: AppColors.border,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.card,
        indicatorColor: AppColors.primary.withOpacity(0.2),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: 22);
          }
          return const IconThemeData(color: AppColors.mutedForeground, size: 22);
        }),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          final base = GoogleFonts.inter(fontSize: 11);
          if (states.contains(MaterialState.selected)) {
            return base.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600);
          }
          return base.copyWith(color: AppColors.mutedForeground);
        }),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 64,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
      ),
    );
  }
}

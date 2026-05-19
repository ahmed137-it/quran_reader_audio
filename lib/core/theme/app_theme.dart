


// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // ── Primary
  static const Color green900  = Color(0xFF0D2B1F);
  static const Color green800  = Color(0xFF1B4332);
  static const Color green600  = Color(0xFF2D6A4F);
  static const Color green400  = Color(0xFF40916C);
  static const Color gold      = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF0D875);
  static const Color goldDark  = Color(0xFFB8860B);

  // ── Light surfaces
  static const Color bgLight      = Color(0xFFF9F5EC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight    = Color(0xFFFDF8EE);
  static const Color dividerL     = Color(0xFFE5DCC8);
  static const Color txtPL        = Color(0xFF1A1A1A);
  static const Color txtSL        = Color(0xFF5A6474);
  static const Color arabicL      = Color(0xFF0D1B0D);

  // ── Dark surfaces
  static const Color bgDark      = Color(0xFF0D1512);
  static const Color surfaceDark = Color(0xFF162118);
  static const Color cardDark    = Color(0xFF1E2E22);
  static const Color dividerD    = Color(0xFF2A3D2E);
  static const Color txtPD       = Color(0xFFE8E0D0);
  static const Color txtSD       = Color(0xFF9CA8A0);
  static const Color arabicD     = Color(0xFFF0E8D8);

  // ── Semantic
  static const Color makki   = Color(0xFF8B4513);
  static const Color madani  = Color(0xFF1B4332);
  static const Color error   = Color(0xFFCF6679);
}

class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    primary: AppColors.green800,
    secondary: AppColors.gold,
    bg: AppColors.bgLight,
    surface: AppColors.surfaceLight,
    card: AppColors.cardLight,
    divider: AppColors.dividerL,
    txtP: AppColors.txtPL,
    txtS: AppColors.txtSL,
    onPrimary: Colors.white,
    barBg: AppColors.green800,
    barFg: Colors.white,
    navSelected: AppColors.green800,
    navUnselected: AppColors.txtSL,
    statusBrightness: Brightness.light,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    primary: AppColors.green400,
    secondary: AppColors.gold,
    bg: AppColors.bgDark,
    surface: AppColors.surfaceDark,
    card: AppColors.cardDark,
    divider: AppColors.dividerD,
    txtP: AppColors.txtPD,
    txtS: AppColors.txtSD,
    onPrimary: Colors.white,
    barBg: AppColors.surfaceDark,
    barFg: AppColors.txtPD,
    navSelected: AppColors.gold,
    navUnselected: AppColors.txtSD,
    statusBrightness: Brightness.light,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color bg,
    required Color surface,
    required Color card,
    required Color divider,
    required Color txtP,
    required Color txtS,
    required Color onPrimary,
    required Color barBg,
    required Color barFg,
    required Color navSelected,
    required Color navUnselected,
    required Brightness statusBrightness,
  }) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: isDark ? Colors.black : Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        background: bg,
        onBackground: txtP,
        surface: surface,
        onSurface: txtP,
      ),
      scaffoldBackgroundColor: bg,
      cardColor: card,
      dividerColor: divider,
      fontFamily: 'Amiri',
      appBarTheme: AppBarTheme(
        backgroundColor: barBg,
        foregroundColor: barFg,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusBrightness,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: barFg,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: navSelected,
        unselectedItemColor: navUnselected,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontFamily: 'Amiri', fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Amiri', fontSize: 11),
      ),
      textTheme: TextTheme(
        headlineLarge:  TextStyle(fontFamily:'Amiri', fontSize:28, fontWeight:FontWeight.bold, color:txtP),
        headlineMedium: TextStyle(fontFamily:'Amiri', fontSize:22, fontWeight:FontWeight.bold, color:txtP),
        titleLarge:     TextStyle(fontFamily:'Amiri', fontSize:18, fontWeight:FontWeight.bold, color:txtP),
        titleMedium:    TextStyle(fontFamily:'Amiri', fontSize:16, fontWeight:FontWeight.w600, color:txtP),
        bodyLarge:      TextStyle(fontFamily:'Amiri', fontSize:16, color:txtP),
        bodyMedium:     TextStyle(fontFamily:'Amiri', fontSize:14, color:txtS),
        bodySmall:      TextStyle(fontFamily:'Amiri', fontSize:12, color:txtS),
        labelLarge:     TextStyle(fontFamily:'Amiri', fontSize:14, fontWeight:FontWeight.bold, color:txtP),
      ),
    );
  }
}
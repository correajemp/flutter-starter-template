import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Color Palette
  static const Color classicOcean = Color(0XFF005493);
  static const Color oceanBlue = Color(0XFF009DC4);
  static const Color seaBlue = Color(0XFF006994);
  static const Color deepOcean = Color(0XFF003366);
  static const Color lightAquaWave = Color(0XFF63B9DB);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: classicOcean,
    onPrimary: Color(0XFFFFFFFF),
    primaryContainer: seaBlue,
    onPrimaryContainer: Color(0XFFFFFFFF),
    secondary: oceanBlue,
    onSecondary: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFFD2F3FC),
    onSecondaryContainer: Color(0XFF003644),
    tertiary: lightAquaWave,
    onTertiary: Color(0XFF003548),
    tertiaryContainer: Color(0XFFBBE5F6),
    onTertiaryContainer: Color(0XFF001E2C),
    error: Color(0XFFBA1A1A),
    onError: Color(0XFFFFFFFF),
    errorContainer: Color(0XFFFFDAD6),
    onErrorContainer: Color(0XFF410002),
    surface: Color(0XFFF8F9FC),
    onSurface: Color(0XFF191C1E),
    surfaceDim: Color(0XFFD8DAE0),
    surfaceBright: Color(0XFFF8F9FC),
    surfaceContainerLowest: Color(0XFFFFFFFF),
    surfaceContainerLow: Color(0XFFF1F4F9),
    surfaceContainer: Color(0XFFECF0F6),
    surfaceContainerHigh: Color(0XFFE6EAEF),
    surfaceContainerHighest: Color(0XFFE0E4E9),
    onSurfaceVariant: Color(0XFF43474E),
    outline: Color(0XFF73777F),
    outlineVariant: Color(0XFFC3C7CF),
    shadow: Color(0XFF000000),
    scrim: Color(0XFF000000),
    inverseSurface: Color(0XFF2E3033),
    onInverseSurface: Color(0XFFF0F0F3),
    inversePrimary: Color(0XFF8BCAFF),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: lightAquaWave,
    onPrimary: Color(0XFF00344A),
    primaryContainer: classicOcean,
    onPrimaryContainer: Color(0XFFD1E5FF),
    secondary: oceanBlue,
    onSecondary: Color(0XFF003544),
    secondaryContainer: Color(0XFF004D61),
    onSecondaryContainer: Color(0XFFBCE9FF),
    tertiary: seaBlue,
    onTertiary: Color(0XFFFFFFFF),
    tertiaryContainer: Color(0XFF004D6E),
    onTertiaryContainer: Color(0XFFCDE7FF),
    error: Color(0XFFFFB4AB),
    onError: Color(0XFF690005),
    errorContainer: Color(0XFF93000A),
    onErrorContainer: Color(0XFFFFDAD6),
    surface: Color(0XFF002244),
    onSurface: Color(0XFFE2E2E6),
    surfaceDim: Color(0XFF001A35),
    surfaceBright: deepOcean,
    surfaceContainerLowest: Color(0XFF001124),
    surfaceContainerLow: Color(0XFF001D3A),
    surfaceContainer: Color(0XFF002951),
    surfaceContainerHigh: Color(0XFF003160),
    surfaceContainerHighest: Color(0XFF003A70),
    onSurfaceVariant: Color(0XFFC3C7CF),
    outline: Color(0XFF8D9199),
    outlineVariant: Color(0XFF43474E),
    shadow: Color(0XFF000000),
    scrim: Color(0XFF000000),
    inverseSurface: Color(0XFFE2E2E6),
    onInverseSurface: Color(0XFF2F3033),
    inversePrimary: classicOcean,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/theme/app_colors.dart';

TextStyle _style(double size, FontWeight weight, double height, {String? fontFamily}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: 0,
    fontFamily: fontFamily,
  );
}

class AppTypography extends ThemeExtension<AppTypography> {
  // Define our custom primary/secondary font families.
  // Change these strings to match the 'family' name declared in your pubspec.yaml.
  static const String primaryFont = 'Inter';
  static const String secondaryFont = 'Poppins';

  final TextStyle thin;
  final TextStyle light;
  final TextStyle regular;
  final TextStyle medium;
  final TextStyle semiBold;
  final TextStyle bold;
  final TextStyle extraBold;
  final TextStyle black;

  const AppTypography({
    required this.thin,
    required this.light,
    required this.regular,
    required this.medium,
    required this.semiBold,
    required this.bold,
    required this.extraBold,
    required this.black,
  });

  factory AppTypography.fromColorScheme(ColorScheme scheme) {
    final Color onSurface = scheme.onSurface;

    TextStyle tint(TextStyle base, Color color) => base.copyWith(color: color);

    return AppTypography(
      thin: tint(_style(14, FontWeight.w100, 1.4, fontFamily: primaryFont), onSurface),
      light: tint(_style(14, FontWeight.w300, 1.4, fontFamily: primaryFont), onSurface),
      regular: tint(_style(14, FontWeight.w400, 1.43, fontFamily: primaryFont), onSurface),
      medium: tint(_style(14, FontWeight.w500, 1.43, fontFamily: primaryFont), onSurface),
      semiBold: tint(_style(16, FontWeight.w600, 1.35, fontFamily: secondaryFont), onSurface),
      bold: tint(_style(18, FontWeight.w700, 1.3, fontFamily: secondaryFont), onSurface),
      extraBold: tint(_style(20, FontWeight.w800, 1.25, fontFamily: secondaryFont), onSurface),
      black: tint(_style(22, FontWeight.w900, 1.2, fontFamily: secondaryFont), onSurface),
    );
  }

  static final AppTypography lightTypography = AppTypography.fromColorScheme(
    AppColors.lightColorScheme,
  );
  static final AppTypography darkTypography = AppTypography.fromColorScheme(
    AppColors.darkColorScheme,
  );

  // Backward compatibility getter to keep standard Material widgets styled correctly.
  TextTheme get textTheme => TextTheme(
    displayLarge: black.copyWith(fontSize: 57, height: 1.12),
    displayMedium: extraBold.copyWith(fontSize: 45, height: 1.16),
    displaySmall: bold.copyWith(fontSize: 36, height: 1.22),
    headlineLarge: bold.copyWith(fontSize: 32, height: 1.25),
    headlineMedium: semiBold.copyWith(fontSize: 28, height: 1.29),
    headlineSmall: semiBold.copyWith(fontSize: 24, height: 1.33),
    titleLarge: medium.copyWith(fontSize: 22, height: 1.27),
    titleMedium: medium.copyWith(fontSize: 16, height: 1.5),
    titleSmall: medium.copyWith(
      fontSize: 14,
      height: 1.57,
      color: AppColors.lightColorScheme.onSurfaceVariant,
    ),
    bodyLarge: regular.copyWith(fontSize: 16, height: 1.5),
    bodyMedium: regular.copyWith(fontSize: 14, height: 1.43),
    bodySmall: regular.copyWith(
      fontSize: 12,
      height: 1.33,
      color: AppColors.lightColorScheme.onSurfaceVariant,
    ),
    labelLarge: medium.copyWith(fontSize: 14, height: 1.43),
    labelMedium: medium.copyWith(
      fontSize: 12,
      height: 1.33,
      color: AppColors.lightColorScheme.onSurfaceVariant,
    ),
    labelSmall: medium.copyWith(
      fontSize: 11,
      height: 1.45,
      color: AppColors.lightColorScheme.onError,
    ),
  );

  @override
  AppTypography copyWith({
    TextStyle? thin,
    TextStyle? light,
    TextStyle? regular,
    TextStyle? medium,
    TextStyle? semiBold,
    TextStyle? bold,
    TextStyle? extraBold,
    TextStyle? black,
  }) {
    return AppTypography(
      thin: thin ?? this.thin,
      light: light ?? this.light,
      regular: regular ?? this.regular,
      medium: medium ?? this.medium,
      semiBold: semiBold ?? this.semiBold,
      bold: bold ?? this.bold,
      extraBold: extraBold ?? this.extraBold,
      black: black ?? this.black,
    );
  }

  @override
  AppTypography lerp(AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      thin: TextStyle.lerp(thin, other.thin, t)!,
      light: TextStyle.lerp(light, other.light, t)!,
      regular: TextStyle.lerp(regular, other.regular, t)!,
      medium: TextStyle.lerp(medium, other.medium, t)!,
      semiBold: TextStyle.lerp(semiBold, other.semiBold, t)!,
      bold: TextStyle.lerp(bold, other.bold, t)!,
      extraBold: TextStyle.lerp(extraBold, other.extraBold, t)!,
      black: TextStyle.lerp(black, other.black, t)!,
    );
  }
}

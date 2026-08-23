import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_template/core/theme/app_colors.dart';
import 'package:flutter_starter_template/core/theme/app_elevation.dart';
import 'package:flutter_starter_template/core/theme/app_radius.dart';
import 'package:flutter_starter_template/core/theme/app_spacing.dart';
import 'package:flutter_starter_template/core/theme/app_typography.dart';

extension AppThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppTypography get typography => Theme.of(this).extension<AppTypography>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppRadius get radius => Theme.of(this).extension<AppRadius>()!;
  AppElevation get elevation => Theme.of(this).extension<AppElevation>()!;
}

extension AppColorsX on ColorScheme {
  bool get isLight => brightness == Brightness.light;

  // Brand Color Palette
  Color get classicOcean => AppColors.classicOcean;
  Color get oceanBlue => AppColors.oceanBlue;
  Color get seaBlue => AppColors.seaBlue;
  Color get deepOcean => AppColors.deepOcean;
  Color get lightAquaWave => AppColors.lightAquaWave;

  // Standard ColorScheme Aliases
  Color get primaryColor => primary;
  Color get onPrimaryColor => onPrimary;
  Color get primaryContainerColor => primaryContainer;
  Color get onPrimaryContainerColor => onPrimaryContainer;
  Color get secondaryColor => secondary;
  Color get onSecondaryColor => onSecondary;
  Color get secondaryContainerColor => secondaryContainer;
  Color get onSecondaryContainerColor => onSecondaryContainer;
  Color get tertiaryColor => tertiary;
  Color get onTertiaryColor => onTertiary;
  Color get tertiaryContainerColor => tertiaryContainer;
  Color get onTertiaryContainerColor => onTertiaryContainer;
  Color get surfaceColor => surface;
  Color get onSurfaceColor => onSurface;
  Color get surfaceDimColor => surfaceDim;
  Color get surfaceBrightColor => surfaceBright;
  Color get backgroundColor => surface;
  Color get onBackgroundColor => onSurface;
  Color get errorColor => error;
  Color get onErrorColor => onError;
  Color get outlineColor => outline;
  Color get outlineVariantColor => outlineVariant;

  // Custom Color Aliases
  Color get success => isLight ? const Color(0XFF2E7D32) : const Color(0XFF66BB6A);
  Color get warning => isLight ? const Color(0XFFED6C02) : const Color(0XFFFFB74D);
  Color get info => isLight ? const Color(0XFF0288D1) : const Color(0XFF4FC3F7);
  Color get error => isLight ? const Color(0XFFD32F2F) : const Color(0XFFE57373);
}

extension SystemUiOverlayStyleX on BuildContext {
  SystemUiOverlayStyle get systemUiOverlayStyle {
    final isDark = Theme.of(this).brightness == Brightness.dark;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,

      systemNavigationBarColor: Theme.of(this).colorScheme.surface,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  }
}

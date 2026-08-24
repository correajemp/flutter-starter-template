import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_elevation.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = AppColors.lightColorScheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: AppTypography.lightTypography.textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorSurface(colorScheme),
        elevation: AppElevation.standard.none,
        scrolledUnderElevation: AppElevation.standard.low,
      ),
      cardTheme: CardThemeData(
        elevation: AppElevation.standard.low,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.standard.mdRadius),
      ),
      extensions: [
        AppTypography.lightTypography,
        AppSpacing.standard,
        AppRadius.standard,
        AppElevation.standard,
      ],
    );
  }

  static ThemeData get dark {
    const colorScheme = AppColors.darkColorScheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.darkTypography.textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorSurface(colorScheme),
        elevation: AppElevation.standard.none,
        scrolledUnderElevation: AppElevation.standard.low,
      ),
      cardTheme: CardThemeData(
        elevation: AppElevation.standard.low,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.standard.mdRadius),
      ),
      extensions: [
        AppTypography.darkTypography,
        AppSpacing.standard,
        AppRadius.standard,
        AppElevation.standard,
      ],
    );
  }
}

Color colorSurface(ColorScheme scheme) => scheme.onSurface;

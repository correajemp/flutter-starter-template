import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/storage/app_settings_storage.dart';
import 'package:flutter_starter_template/core/storage/storage_providers.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._appSettingsStorage) : super(ThemeMode.light) {
    _loadThemeMode();
  }

  final AppSettingsStorage _appSettingsStorage;

  void _loadThemeMode() {
    final savedThemeMode = _appSettingsStorage.getThemeMode();
    if (savedThemeMode != null) {
      state = _parseThemeMode(savedThemeMode);
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _appSettingsStorage.setThemeMode(themeMode.name);
    state = themeMode;
  }

  static ThemeMode _parseThemeMode(String value) {
    return ThemeMode.values.firstWhereOrNull((mode) => mode.name == value) ?? ThemeMode.light;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final appSettingsStorage = ref.watch(appSettingsStorageProvider);
  return ThemeModeNotifier(appSettingsStorage);
});

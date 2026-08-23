import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/storage/app_settings_storage.dart';
import 'package:flutter_starter_template/core/storage/storage_providers.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._appSettingsStorage) : super(const Locale('en')) {
    _loadLocale();
  }

  final AppSettingsStorage _appSettingsStorage;

  void _loadLocale() {
    final savedLocale = _appSettingsStorage.getLocale();
    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    await _appSettingsStorage.setLocale(locale.languageCode);
    state = locale;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final appSettingsStorage = ref.watch(appSettingsStorageProvider);
  return LocaleNotifier(appSettingsStorage);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/storage/app_settings_storage.dart';
import 'package:flutter_starter_template/core/storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnsupportedError(
    'sharedPreferencesProvider must be overridden with SharedPreferences.getInstance()',
  );
});

final appSettingsStorageProvider = Provider<AppSettingsStorage>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return AppSettingsStorage(sharedPreferences: sharedPreferences);
});

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env();

  Future<void> init() async {
    dotenv.clean();
    const env = String.fromEnvironment('ENV', defaultValue: 'stg');
    const fileName = '.env.$env';
    try {
      await dotenv.load(fileName: fileName);
    } catch (_) {
      await dotenv.load();
    }
  }

  String getString(String key, {String defaultValue = ''}) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.trim().isEmpty) {
      return defaultValue;
    }
    return value;
  }

  int getInt(String key, {int defaultValue = 0}) {
    final value = dotenv.maybeGet(key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    final value = dotenv.maybeGet(key);
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    final value = dotenv.maybeGet(key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }
}

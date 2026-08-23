import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/storage/secure_storage.dart';
import 'package:flutter_starter_template/core/storage/storage_providers.dart';

class CacheService {
  final SecureStorage _storage;

  CacheService(this._storage);

  Future<void> save<T>(String key, T value) async {
    try {
      String jsonString;
      if (value is String) {
        jsonString = value;
      } else if (value is List) {
        jsonString = jsonEncode(value.map(_serializeItem).toList());
      } else {
        jsonString = jsonEncode(_serializeItem(value));
      }
      await _storage.write(key, jsonString);
    } catch (_) {}
  }

  Future<T?> get<T>(String key, T Function(dynamic) fromJson) async {
    try {
      final jsonString = await _storage.read(key);
      if (jsonString == null) return null;
      if (T == String) {
        return jsonString as T;
      } else if (T == List<String>) {
        final decodedList = jsonDecode(jsonString) as List<String>;
        return decodedList.cast<String>() as T;
      } else if (T == List) {
        final decodedList = jsonDecode(jsonString) as List<dynamic>;
        return decodedList.map((item) => fromJson(item)).toList() as T;
      } else {
        return fromJson(jsonDecode(jsonString));
      }
    } catch (_) {
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key);
    } catch (_) {}
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (_) {}
  }

  dynamic _serializeItem(dynamic item) {
    if (item is Map<String, dynamic>) {
      return item;
    } else if (item is String || item is num || item is bool) {
      return item;
    } else if (item != null && item.toJson != null) {
      return item.toJson();
    } else {
      throw ArgumentError('Object does not have a toJson() method or is not a map');
    }
  }
}

final cacheServiceProvider = Provider<CacheService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return CacheService(secureStorage);
});

import 'package:core/storage/secure_storage.dart';

abstract class TokenStorage {
  Future<void> saveTokens({required String accessToken, required String refreshToken});

  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage({SecureStorage? secureStorage}) : _storage = secureStorage ?? SecureStorage();

  final SecureStorage _storage;

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.writeAccessToken(accessToken);
    await _storage.writeRefreshToken(refreshToken);
  }

  @override
  Future<String?> readAccessToken() => _storage.readAccessToken();

  @override
  Future<String?> readRefreshToken() => _storage.readRefreshToken();

  @override
  Future<void> clear() => _storage.deleteTokens();
}

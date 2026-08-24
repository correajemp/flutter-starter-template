import 'package:core/api/token/token_storage.dart';
import 'package:dio/dio.dart';

abstract class TokenManager {
  Future<String?> get accessToken;

  Future<String?> get refreshToken;

  Future<void> save({required String accessToken, required String refreshToken});

  Future<String?> refresh();

  Future<void> clear();
}

class TokenManagerImpl implements TokenManager {
  TokenManagerImpl({
    required this._storage,
    required this._refreshDio,
    required this._refreshPath,
    this._accessTokenField = 'access_token',
    this._refreshTokenField = 'refresh_token',
  });

  final TokenStorage _storage;
  final Dio _refreshDio;
  final String _refreshPath;
  final String _accessTokenField;
  final String _refreshTokenField;

  Future<String?>? _refreshFuture;

  @override
  Future<String?> get accessToken => _storage.readAccessToken();

  @override
  Future<String?> get refreshToken => _storage.readRefreshToken();

  @override
  Future<void> save({required String accessToken, required String refreshToken}) =>
      _storage.saveTokens(accessToken: accessToken, refreshToken: refreshToken);

  @override
  Future<String?> refresh() {
    return _refreshFuture ??= _doRefresh().whenComplete(() {
      _refreshFuture = null;
    });
  }

  Future<String?> _doRefresh() async {
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final response = await _refreshDio.post<Response<dynamic>>(
        _refreshPath,
        data: {_refreshTokenField: refreshToken},
      );

      if (response.statusCode != 200 || response.data is! Map<String, dynamic>) {
        return null;
      }

      final data = response.data as Map<String, dynamic>;
      final newAccessToken = data[_accessTokenField] as String?;
      final newRefreshToken = data[_refreshTokenField] as String?;

      if (newAccessToken == null || newAccessToken.isEmpty) return null;

      await _storage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken ?? refreshToken,
      );
      return newAccessToken;
    } on DioException {
      return null;
    }
  }

  @override
  Future<void> clear() => _storage.clear();
}

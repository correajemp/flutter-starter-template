import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_starter_template/core/api/token/token_manager.dart';
import 'package:logger/logger.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  RefreshTokenInterceptor({required this.tokenManager, required this.refreshDio, this.logger});

  final TokenManager tokenManager;
  final Dio refreshDio;
  final Logger? logger;

  static const String _refreshedKey = 'x_token_refreshed';

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final statusCode = err.response?.statusCode;
    final alreadyRefreshed = options.extra[_refreshedKey] == true;

    if (statusCode != 401 || alreadyRefreshed) {
      return handler.next(err);
    }

    try {
      final newToken = await tokenManager.refresh();

      if (newToken == null || newToken.isEmpty) {
        await tokenManager.clear();
        logger?.w('Token refresh failed — clearing session');
        return handler.next(err);
      }

      options.extra[_refreshedKey] = true;
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $newToken';

      final response = await refreshDio.fetch<Response<dynamic>>(options);
      return handler.resolve(response);
    } catch (e) {
      await tokenManager.clear();
      logger?.e('Token refresh error — clearing session', error: e);
      return handler.next(err);
    }
  }
}

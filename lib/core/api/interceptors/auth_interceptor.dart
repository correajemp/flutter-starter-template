import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_starter_template/core/api/token/token_manager.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenManager});

  final TokenManager tokenManager;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers[HttpHeaders.authorizationHeader] == null) {
      final token = await tokenManager.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
    }
    handler.next(options);
  }
}

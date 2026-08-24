import 'package:core/api/interceptors/auth_interceptor.dart';
import 'package:core/api/interceptors/logger_interceptor.dart';
import 'package:core/api/interceptors/refresh_token_interceptor.dart';
import 'package:core/api/interceptors/retry_interceptor.dart';
import 'package:core/api/token/token_manager.dart';
import 'package:core/api/token/token_storage.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/storage/storage_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

const String refreshTokenPath = '/auth/refresh';

final networkLoggerProvider = Provider<Logger>((ref) {
  final printer = PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 80);
  const level = kReleaseMode ? Level.warning : Level.trace;
  return Logger(printer: printer, level: level);
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return SecureTokenStorage(secureStorage: secureStorage);
});

final refreshDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.apiUrls.base,
      connectTimeout: Duration(milliseconds: AppConstants.timeouts.connect),
      receiveTimeout: Duration(milliseconds: AppConstants.timeouts.receive),
      sendTimeout: Duration(milliseconds: AppConstants.timeouts.send),
      headers: {'Accept': 'application/json'},
    ),
  );
});

final tokenManagerProvider = Provider<TokenManager>((ref) {
  final storage = ref.watch(tokenStorageProvider);
  final refreshDio = ref.watch(refreshDioProvider);
  return TokenManagerImpl(storage: storage, refreshDio: refreshDio, refreshPath: refreshTokenPath);
});

final dioProvider = Provider<Dio>((ref) {
  final logger = ref.watch(networkLoggerProvider);
  final tokenManager = ref.watch(tokenManagerProvider);
  final refreshDio = ref.watch(refreshDioProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiUrls.base,
      connectTimeout: Duration(milliseconds: AppConstants.timeouts.connect),
      receiveTimeout: Duration(milliseconds: AppConstants.timeouts.receive),
      sendTimeout: Duration(milliseconds: AppConstants.timeouts.send),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.addAll(<Interceptor>[
    AuthInterceptor(tokenManager: tokenManager),
    LoggerInterceptor(logger),
    RetryInterceptor(dio: dio, logger: logger),
    RefreshTokenInterceptor(tokenManager: tokenManager, refreshDio: refreshDio, logger: logger),
  ]);

  return dio;
});

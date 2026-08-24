import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor(this.logger);

  final Logger logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = options.headers['Authorization'];
    final redacted = auth != null ? 'Authorization: Bearer ••••••' : null;
    logger.d(
      'REQUEST → ${options.method} ${options.uri}\n'
      '${redacted ?? ''}'
      '${options.queryParameters.isNotEmpty ? '\nQuery: ${options.queryParameters}' : ''}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.i('RESPONSE ← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'ERROR ✕ ${err.requestOptions.uri}'
      '${err.response != null ? ' (${err.response!.statusCode})' : ''}',
      error: err.error,
    );
    handler.next(err);
  }
}

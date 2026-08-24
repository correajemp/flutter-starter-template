import 'package:dio/dio.dart';

sealed class ApiFailure implements Exception {
  const ApiFailure(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => 'ApiFailure($message)';
}

class NetworkFailure extends ApiFailure {
  const NetworkFailure(super.message, [super.cause]);
}

class TimeoutFailure extends ApiFailure {
  const TimeoutFailure(super.message, [super.cause]);
}

class UnauthorizedFailure extends ApiFailure {
  const UnauthorizedFailure(super.message, [super.cause]);
}

class ClientFailure extends ApiFailure {
  const ClientFailure(super.message, [super.cause]);

  factory ClientFailure.fromResponse(int statusCode, [String? message]) =>
      ClientFailure(message ?? 'Client error ($statusCode)');
}

class ServerFailure extends ApiFailure {
  const ServerFailure(super.message, [super.cause]);

  factory ServerFailure.fromResponse(int statusCode, [String? message]) =>
      ServerFailure(message ?? 'Server error ($statusCode)');
}

class UnknownFailure extends ApiFailure {
  const UnknownFailure(super.message, [super.cause]);
}

ApiFailure mapDioException(DioException error) {
  final response = error.response;
  final statusCode = response?.statusCode;

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutFailure(_getMessage(error), error);

    case DioExceptionType.connectionError:
      return NetworkFailure('No internet connection. Please check your network.', error);

    case DioExceptionType.badResponse:
      if (statusCode == null) {
        return UnknownFailure(_getMessage(error), error);
      }
      if (statusCode == 401 || statusCode == 403) {
        return UnauthorizedFailure(
          _extractMessage(response) ?? 'Session expired. Please sign in again.',
          error,
        );
      }
      if (statusCode >= 400 && statusCode < 500) {
        return ClientFailure.fromResponse(statusCode, _extractMessage(response));
      }
      if (statusCode >= 500) {
        return ServerFailure.fromResponse(statusCode, _extractMessage(response));
      }
      return UnknownFailure(_getMessage(error), error);

    case DioExceptionType.cancel:
      return UnknownFailure('Request was cancelled.', error);

    case DioExceptionType.badCertificate:
      return UnknownFailure('Invalid SSL certificate.', error);

    case DioExceptionType.unknown:
    default:
      return UnknownFailure(_getMessage(error), error);
  }
}

String _getMessage(DioException error) {
  return error.message ?? error.error?.toString() ?? 'Unexpected network error.';
}

String? _extractMessage(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map<String, dynamic>) {
    final candidate = data['message'] ?? data['error'] ?? data['detail'];
    if (candidate is String) return candidate;
  }
  return null;
}

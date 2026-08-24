import 'package:core/api/api_client.dart';
import 'package:core/api/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) =>
      _run(() => _dio.get<T>(path, queryParameters: queryParameters, options: options));

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _run(
    () => _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options),
  );

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _run(() => _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options));

  Future<T> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _run(
    () => _dio.patch<T>(path, data: data, queryParameters: queryParameters, options: options),
  );

  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _run(
    () => _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options),
  );

  Future<T> _run<T>(Future<Response<T>> Function() call) async {
    try {
      final response = await call();
      return response.data as T;
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

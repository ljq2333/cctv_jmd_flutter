import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:cctv_jmd_flutter/core/constants/api_constants.dart';

class DioClient {
  static const String baseUrl = ApiConstants.baseUrl;
  static const int connectTimeout = ApiConstants.connectTimeout;
  static const int receiveTimeout = ApiConstants.receiveTimeout;

  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: {
          'Accept': '*/*',
          'Accept-Language': 'zh-CN,zh;q=0.9',
        },
      ),
    );

    _dio.interceptors.addAll([
      _createRetryInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint('[DioClient] $obj'),
      ),
    ]);
  }

  Interceptor _createRetryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          try {
            final response = await _retry(error.requestOptions);
            handler.resolve(response);
          } catch (e) {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    );
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      retryCount++;
      final delay = Duration(seconds: retryCount * 2);
      await Future.delayed(delay);

      try {
        final response = await _dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
        );
        return response;
      } catch (e) {
        if (retryCount >= maxRetries) rethrow;
      }
    }

    throw DioException(
      requestOptions: requestOptions,
      message: 'Max retries exceeded',
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  void dispose() {
    _dio.close();
  }
}

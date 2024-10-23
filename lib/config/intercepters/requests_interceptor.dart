import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../app/service_locator.dart';
import '../../core/utils/app_enums.dart';
import '../database/cache/cache_consumer.dart';
import '../database/api/end_points.dart';

class RequestsIntercepter extends Interceptor {
  final Dio client;
  bool _isRefreshing = false;
  final List<RequestOptions> _retryQueue = [];

  RequestsIntercepter({required this.client});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers[HttpHeaders.acceptLanguageHeader] =
        await sl<CacheConsumer>().getData(key: MySharedKeys.language.name) ??
            'en';

    final token =
        await sl<CacheConsumer>().getData(key: MySharedKeys.apiToken.name);
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          '${EndPoints.prefixToken} $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final newAccessToken = await _refreshToken();
        if (newAccessToken != null) {
          // Save new tokens in the cache
          await sl<CacheConsumer>().saveData(
              key: MySharedKeys.apiToken.name, value: newAccessToken['token']);
          await sl<CacheConsumer>().saveData(
              key: MySharedKeys.refreshToken.name,
              value: newAccessToken['refreshToken']);

          // Retry all requests in the queue with the new token
          for (var request in _retryQueue) {
            request.headers[HttpHeaders.authorizationHeader] =
                '${EndPoints.prefixToken} ${newAccessToken['token']}';
            try {
              final response = await client.request(
                request.path,
                options: Options(
                  method: request.method,
                  headers: request.headers,
                ),
                data: request.data,
                queryParameters: request.queryParameters,
              );
              handler.resolve(response);
            } catch (e) {
              handler.reject(DioException(requestOptions: request, error: e));
            }
          }
          _retryQueue.clear();
        }
      } finally {
        _isRefreshing = false;
      }
    } else if (err.response?.statusCode == 401 && _isRefreshing) {
      // Add this request to the queue to be retried later
      _retryQueue.add(err.requestOptions);
    } else {
      super.onError(err, handler);
    }
  }

  Future<Map<String, dynamic>?> _refreshToken() async {
    try {
      final refreshToken = await sl<CacheConsumer>()
          .getData(key: MySharedKeys.refreshToken.name);

      if (refreshToken != null) {
        final response = await client.post(
          EndPoints.refreshToken,
          data: {
            'refreshToken': refreshToken,
          },
        );

        final data = jsonDecode(response.data);
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

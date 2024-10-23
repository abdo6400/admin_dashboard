import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/service_locator.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/commons.dart';
import '../error/exceptions.dart';
import '../network/netwok_info.dart';
import 'api_consumer.dart';
import '../../intercepters/requests_interceptor.dart';
import 'end_points.dart';
import 'status_code.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;
  final NetworkInfo networkInfo;
  DioConsumer({required this.client, required this.networkInfo}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false;
    client.interceptors.add(sl<LogInterceptor>());
    client.httpClientAdapter = Http2Adapter(
      ConnectionManager(idleTimeout: const Duration(seconds: 10)),
    );
    client.interceptors.add(sl<RequestsIntercepter>());
    client.interceptors.add(DioCacheInterceptor(
        options: CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: true,
    )));
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.get(
          path,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    List<XFile>? files,
    Map<String, String>? headers,
    String? name,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        FormData? fromData;
        if (body != null) {
          fromData = FormData.fromMap(body);
          if (files != null) {
            for (var element in files) {
              fromData.files.add(MapEntry(name ?? element.name,
                  await multipartConvertImage(image: element)));
            }
          }
        }

        final response = await client.post(
          path,
          data: formDataIsEnabled ? fromData : body,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters,
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic decodeResponse(Response response) {
    return jsonDecode(response.data.toString());
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.delete(path,
            data: body,
            options: Options(
              headers: headers,
            ),
            queryParameters: queryParameters);
        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool responseIsParsing = true,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        FormData? fromData;
        if (body != null) {
          fromData = FormData.fromMap(body);
          /* if (files != null) {
            for (var element in files) {
              fromData.files.add(MapEntry(name ?? element.name,
                  await multipartConvertImage(image: element)));
            }
          }*/
        }

        final response = await client.patch(
          path,
          data: fromData,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.put(
          path,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> download(
    String path,
    String savePath, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.download(
          path,
          savePath,
          data: body,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw FetchDataException(
            error.response?.data ?? AppStrings.someThingWentWrong);
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.parameterError:
            throw ParamterErrorException([error.error]);
          case StatusCode.notFound:
            throw NotFoundException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          case StatusCode.conflict:
            throw ConflictException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          case StatusCode.internalServerError:
            throw InternalServerErrorException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          case StatusCode.gatewayServerError:
            throw InternalServerErrorException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          case StatusCode.requestEntityTooLarge:
            throw InternalServerErrorException(
                error.response?.data ?? AppStrings.someThingWentWrong);
          default:
            throw ServerException(
                error.response?.data ?? AppStrings.someThingWentWrong);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException(
            AppStrings.noInternetConnection);
    }
  }
}

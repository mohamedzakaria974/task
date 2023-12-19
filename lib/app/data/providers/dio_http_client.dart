import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:get/get.dart' show Trans;
import 'package:logging/logging.dart';
import 'package:task/app/core/values/api_endpoint.dart';

import '../../core/values/localization/locale_keys.dart';
import '../exceptions/app_exception.dart';

abstract class DioHttpClient {
  final logger = Logger('HttpClient');
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.kBaseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    ),
  );

  //NOTE ..interceptors.add(InterceptorLogger())
  DioHttpClient() {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
    ));
  }

  Future<Response<dynamic>> getWithPathVariables(
      String path, Map<String, dynamic> variables) async {
    return await dio.get('$path/${variables.values.join('/')}');
  }

  //NOTE: just call this in provider constructor
  // this will add authentication header and refresh token if expired while calling
  void addAuthInterceptor() {
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          //TODO: get OR refresh user token if expired
          // String token = 'TOKEN'
          // options.headers
          //     .addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
          //         return handler.next(options);
        },
        onError: (DioException e, handler) async {
          logger.shout('AuthInterceptor Error ${e.message}', e, e.stackTrace);
          if (e.response != null) {
            if (e.response!.statusCode == 401) {
              //catch the 401 here
              //TODO: handel user unauthenticated
            } else {
              handler.next(e);
            }
          }
        },
      ),
    );
  }

  Future<T> handleGetRequest<T>({
    required String methodUrl,
    required Function parserFunction,
    required String providerName,
    required String methodDescription,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio
          .get(
        methodUrl,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      )
          .then((value) {
        return parserFunction(value);
      });
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        logger.shout(
            '$providerName: error $methodDescription: Connection Timeout Exception',
            ex,
            ex.stackTrace);
        throw AppException(
            errorCode: ex.response?.statusCode,
            msg: LocaleKeys.kNoConnectionMessage.tr);
      }
      dynamic errorJSON;
      if (ex.response?.data.runtimeType == String) {
        errorJSON = jsonDecode(ex.response?.data);
      } else {
        errorJSON = json.decode(ex.response?.toString() ?? '');
      }
      if (errorJSON.containsKey('detail')) {
        throw AppException(
          errorCode: ex.response?.statusCode,
          msg: errorJSON['detail'],
        );
      }
      throw AppException(
        errorCode: ex.response?.statusCode,
        msg: LocaleKeys.kSomethingWentWrong.tr,
      );
    } catch (e) {
      logger.shout('$providerName: error $methodDescription: $e', e);
      throw AppException(msg: LocaleKeys.kSomethingWentWrong.tr);
    }
  }

  Future<T> handlePostRequest<T>({
    required String methodUrl,
    required Function parserFunction,
    required String providerName,
    required String methodDescription,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio
          .post(
        methodUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      )
          .then((value) {
        return parserFunction(value);
      });
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        logger.shout(
            '$providerName: error $methodDescription: Connection Timeout Exception',
            ex,
            ex.stackTrace);
        throw AppException(
            errorCode: ex.response?.statusCode,
            msg: LocaleKeys.kNoConnectionMessage.tr);
      }
      dynamic errorJSON;
      if (ex.response?.data.runtimeType == String) {
        errorJSON = jsonDecode(ex.response?.data);
      } else {
        errorJSON = json.decode(ex.response?.toString() ?? '');
      }
      if (errorJSON.containsKey('detail')) {
        throw AppException(
          errorCode: ex.response?.statusCode,
          msg: errorJSON['detail'],
        );
      }
      throw AppException(
        errorCode: ex.response?.statusCode,
        msg: LocaleKeys.kSomethingWentWrong.tr,
      );
    } catch (e) {
      logger.shout('$providerName: error $methodDescription: $e', e);
      throw AppException(msg: LocaleKeys.kSomethingWentWrong.tr);
    }
  }

  Future<T> handlePutRequest<T>({
    required String methodUrl,
    required Function parserFunction,
    required String providerName,
    required String methodDescription,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio
          .put(
        methodUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      )
          .then((value) {
        return parserFunction(value);
      });
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        logger.shout(
            '$providerName: error $methodDescription: Connection Timeout Exception',
            ex,
            ex.stackTrace);
        throw AppException(
            errorCode: ex.response?.statusCode,
            msg: LocaleKeys.kNoConnectionMessage.tr);
      }

      dynamic errorJSON;
      if (ex.response?.data.runtimeType == String) {
        errorJSON = jsonDecode(ex.response?.data);
      } else {
        errorJSON = json.decode(ex.response?.toString() ?? '');
      }
      if (errorJSON.containsKey('detail')) {
        throw AppException(
          errorCode: ex.response?.statusCode,
          msg: errorJSON['detail'],
        );
      }
      throw AppException(
        errorCode: ex.response?.statusCode,
        msg: LocaleKeys.kSomethingWentWrong.tr,
      );
    } catch (e) {
      logger.shout('$providerName: error $methodDescription: $e', e);
      throw AppException(msg: LocaleKeys.kSomethingWentWrong.tr);
    }
  }

  Future<T> handleDeleteRequest<T>({
    required String methodUrl,
    required Function parserFunction,
    required String providerName,
    required String methodDescription,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio
          .delete(
        methodUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      )
          .then((value) {
        return parserFunction(value);
      });
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        logger.shout(
            '$providerName: error $methodDescription: Connection Timeout Exception',
            ex,
            ex.stackTrace);
        throw AppException(
            errorCode: ex.response?.statusCode,
            msg: LocaleKeys.kNoConnectionMessage.tr);
      }

      dynamic errorJSON;
      if (ex.response?.data.runtimeType == String) {
        errorJSON = jsonDecode(ex.response?.data);
      } else {
        errorJSON = json.decode(ex.response?.toString() ?? '');
      }

      if (errorJSON.containsKey('detail')) {
        throw AppException(
          errorCode: ex.response?.statusCode,
          msg: errorJSON['detail'],
        );
      }
      throw AppException(
        errorCode: ex.response?.statusCode,
        msg: LocaleKeys.kSomethingWentWrong.tr,
      );
    } catch (e) {
      logger.shout('$providerName: error $methodDescription: $e', e);
      throw AppException(msg: LocaleKeys.kSomethingWentWrong.tr);
    }
  }
}

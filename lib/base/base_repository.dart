// ignore_for_file: file_names, prefer_collection_literals

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:newsapp/base/base_response.dart';

import '../app/config/api_const.dart';

class BaseRepository {
  Dio? _dio;
  BaseRepository get instance => BaseRepository().instance;

  BaseRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: APICONST.BASE_URL,
      maxRedirects: 5,
      followRedirects: false,
      connectTimeout: const Duration(milliseconds: APICONST.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: APICONST.receiveTimeout),
      responseType: ResponseType.json,
      headers: {"Accept": "application/json"},
      contentType: "application/json",
    ));
    initInterceptor();
  }

  //Global header pass it in all API
  Future<Map<String, String>> getApiHeaders(bool authorizationRequired) async {
    Map<String, String> apiHeader = Map<String, String>();

    apiHeader.addAll({"Content-Type": "application/json"});
    apiHeader.addAll({"Accept": "application/json"});
    log(apiHeader.toString());
    return apiHeader;
  }

  // Get:-----------------------------------------------------------------------
  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response? response = await _dio?.get(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response?> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response? response = await _dio?.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response?> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response? response = await _dio?.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response? response = await _dio?.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Dio getDio() => _dio!;

  initInterceptor() {
    _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioException e, handler) async {
      try {
        return handler.next(e); //continue
      } catch (err) {
        return handler.next(e); //continue
      }
    }));

    _dio!.interceptors.add(LogInterceptor(request: true, requestHeader: true, requestBody: true, responseBody: true, error: true));
  }

  BaseResponse? returnApiResult<T>(final response, T recordList) {
    try {
      BaseResponse result;
      result = BaseResponse.fromJson(response, recordList);
      return result;
    } catch (e) {
      log("Exception - APIHelper.dart - returnApiResult()$e");
      return null;
    }
  }
}

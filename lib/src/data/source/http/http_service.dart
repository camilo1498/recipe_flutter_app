// ignore_for_file: deprecated_member_use

import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';

class HttpService {
  /// instances
  late Dio dio;
  final HiveService _hiveServices = HiveService();

  HttpService({String? contentType}) {
    /// http headers
    Map<String, String> headers = {
      'authorization': 'Bearer ${_hiveServices.token}',
      'Content-Type': contentType ?? 'application/json',
      'Accept': '*/*'
    };

    /// configure http
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://recipebackend-production.up.railway.app/',
          connectTimeout: 30 * 1000,
          receiveTimeout: 30 * 1000,
          headers: headers),
    );

    /// init dio interceptors
    _initInterceptors();
  }

  _initInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        /// show request in console
        developer.log(
            "${options.data.toString()} ${options.headers} = ${options.baseUrl}${options.path}",
            name: 'http_request');
        return handler.next(options);
      },

      /// show response in console
      onResponse: (response, handler) {
        // developer.log(
        //     "${response.data.toString()} = ${response.requestOptions.baseUrl}${response.requestOptions.path}",
        //     name: 'http_response');
        return handler.next(response);
      },

      /// show error in console
      onError: (DioError error, handler) async {
        if (error.response != null) {
          developer.log(
              "${error.type.toString()} = ${error.message} ${error.response!.data} = ${error.response!.requestOptions.baseUrl}${error.response!.requestOptions.path}",
              name: 'http_error');
        } else {
          developer.log(
              "${error.type.toString()} = ${error.message} = ${error.requestOptions.baseUrl}${error.requestOptions.path}",
              name: 'http_error');
        }

        /// show errors
        return handler.resolve(_responseGeneralError(
          error: error,
        ));
      },
    ));
  }

  ///The following return a general response error for the app
  Response _responseGeneralError({required DioError error}) {
    return Response(
      requestOptions: error.requestOptions,
      data: {
        "status": false,
        "message": error.response?.data['message'] ??
            "Tenemos algunos problemas, por favor intenta más tarde",
        'data': {}
      },
    );
  }
}

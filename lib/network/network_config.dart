import 'dart:io';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_constants.dart';
import 'package:indimobi/network/api_interceptors.dart';

class AppClient extends GetxService {
  Future<AppClient> init() async {
    initNetwork();
    return this;
  }

  BaseOptions baseOptions = BaseOptions(
    connectTimeout: 50000,
    receiveTimeout: 50000,
    baseUrl: AppConst.baseUrl,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  );

  late Dio dio;

  Future<void> initNetwork() async {
    dio = await Dio(baseOptions)
      ..interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: !kReleaseMode))
      ..interceptors.add(
        ApiInterceptors(),
      );
    (dio.httpClientAdapter as dynamic).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}

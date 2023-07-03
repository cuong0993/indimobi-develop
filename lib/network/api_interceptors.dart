import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/network/check_connect.dart';
import 'package:indimobi/services/api.dart';
import 'package:indimobi/utils/logger.dart';

class ApiInterceptors extends InterceptorsWrapper {
  List<String> pathFormData = [
    Apis.apiDeviceCreate,
    Apis.apiSetting,
  ];

  List<String> formData = [
    Apis.apiUploadFileS3,
  ];

  @override
  void onRequest(
      RequestOptions request, RequestInterceptorHandler handler) async {
    final method = request.method;
    final path = request.path;
    final data = request.data;
    final String? token = await Get.find<SharedPref>().getToken();
    if (token != null && token.isNotEmpty && !pathFormData.contains(path)) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${token}';
    }

    if (formData.contains(request.path)) {
      request.headers['Authorization'] = null;
      request.headers['Content-Type'] = 'multipart/form-data';
      logger.i('Is Api Form Data');
    }

    CheckConnect.checkConnect().then((value) {
      if (value) {
        super.onRequest(request, handler);
      } else {
        Get.find<AppCtrl>().showDialogE('Mất kết nối vui lòng kiểm tra lại!');
      }
    });

    if (method == 'GET') {
      logger.i(
        "✈️ REQUEST[$method] => PATH: $path \n Token: ${request.headers}",
      );
    } else {
      logger.i(
        "✈️ REQUEST[$method] => PATH: $path \n Token:   \n DATA: $data",
      );
    }
  }

  @override
  void onResponse(response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.i("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    final statusCode = error.response?.statusCode;
    final uri = error.requestOptions.path;
    var data = "";
    try {
      data = jsonEncode(error.response?.data);
      AppCtrl appCtrl = Get.find();
      switch (error.type) {
        case DioErrorType.connectTimeout:
          appCtrl.showDialogE('Connect time out!');
          break;
        case DioErrorType.sendTimeout:
          appCtrl.showDialogE('Connect time out!');
          break;
        case DioErrorType.receiveTimeout:
          appCtrl.showDialogE('Connect time out!');
          break;
        case DioErrorType.response:
          switch (error.response?.statusCode) {
            case 401:
              break;
            case 404:
              break;
            case 500:
              break;
            case 215:
              break;
            case 403:
              break;
            case 503:
              logger.e("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
              break;
            case 400:
              break;
          }
          break;
        default:
          logger.e("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
          break;
      }
    } catch (e) {
      logger.e(e);
    }
    super.onError(error, handler);
  }
}

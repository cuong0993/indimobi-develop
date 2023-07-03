import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:indimobi/models/body/confirm_otp_body.dart';
import 'package:indimobi/models/body/create_device_body.dart';
import 'package:indimobi/models/body/refresh_body.dart';
import 'package:indimobi/models/body/send_otp_body.dart';
import 'package:indimobi/models/body/username_body.dart';
import 'package:indimobi/models/response/access_res.dart';
import 'package:indimobi/models/response/device_create_res.dart';
import 'package:indimobi/models/response/device_detail_res.dart';
import 'package:indimobi/models/response/otp_res.dart';
import 'package:indimobi/models/response/token_res.dart';
import 'package:indimobi/network/network_config.dart';
import 'package:indimobi/services/api.dart';
import 'package:indimobi/utils/logger.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    return this;
  }

  Dio appClient = Get.find<AppClient>().dio;

  Future<TokenRes?> getToken({required UsernameBody body}) async {
    try {
      final res = await appClient.post(Apis.apiToken, data: body.toJson());
      TokenRes response = TokenRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<AccessRes?> refreshToken({required RefreshBody body}) async {
    try {
      final res =
          await appClient.post(Apis.apiRefreshToken, data: body.toJson());
      AccessRes response = AccessRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<AccessRes?> getRefreshToken({required RefreshBody body}) async {
    try {
      final res =
          await appClient.post(Apis.apiRefreshToken, data: body.toJson());
      AccessRes response = AccessRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<DeviceCreateRes?> createDevice(
      {required CreateDeviceBody body}) async {
    try {
      final res =
          await appClient.post(Apis.apiDeviceCreate, data: body.toJson());
      DeviceCreateRes response = DeviceCreateRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<DeviceDetailRes?> getDeviceDetail() async {
    try {
      final res = await appClient.get(Apis.apiDeviceDetail);
      DeviceDetailRes response = DeviceDetailRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<OtpRes?> sendOtp({required SendOtpBody body}) async {
    try {
      final res = await appClient.post(
        Apis.apiSendOtp,
        data: body.toJson(),
      );
      OtpRes response = OtpRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<OtpRes?> confirmOtp({required ConfirmOtpBody body}) async {
    try {
      final res = await appClient.post(
        Apis.apiValidateOtp,
        data: body.toJson(),
      );
      OtpRes response = OtpRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}

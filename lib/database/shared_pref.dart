import 'package:get/get.dart';
import 'package:indimobi/commons/app_constants.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends GetxService {
  Future<SharedPref> init() async {
    return this;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConst.keyToken, token);
  }

  Future<String?> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppConst.keyToken);
      return token;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConst.phone, phone);
  }

  Future<String?> getPhone() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phone = prefs.getString(AppConst.phone);
      return phone;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> setRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConst.keyRefreshToken, token);
  }

  Future<String?> getRefreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppConst.keyRefreshToken);
      return token;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> setDeviceId(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConst.keyDeviceId, token);
  }

  Future<String?> getDeviceId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppConst.keyDeviceId);
      return token;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> setFinishIntro(bool isFinish) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConst.keyIntro, isFinish);
  }

  Future<bool?> getFinishIntro() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isFinish = prefs.getBool(AppConst.keyIntro);
      return isFinish;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}

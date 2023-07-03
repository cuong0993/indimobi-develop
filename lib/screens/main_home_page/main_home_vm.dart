import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/models/body/create_device_body.dart';
import 'package:indimobi/models/body/username_body.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/device_create_res.dart';
import 'package:indimobi/models/response/token_res.dart';
import 'package:indimobi/services/auth_service.dart';
import 'package:indimobi/utils/logger.dart';

class MainHomeVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  AuthService authService = Get.find();
  SharedPref sharedPref = Get.find();
  HiveData hiveData = Get.find();
  String deviceId = '';
  String deviceName = '';
  String deviceType = '1';
  List<AlbumEntity> listProject = [];
  AlbumEntity currentAlbum = AlbumEntity();
  TokenRes? tokenRes;
  DeviceCreateRes? deviceRes;

  void initData() async {
    listProject = await hiveData.getProjects() ?? [];
    if (listProject.isNotEmpty) {
      currentAlbum = listProject.first;
    } else {
      currentAlbum = AlbumEntity();
    }
    update();
  }

  void login() async {
    try {
      await getDeviceId();
      await createDeviceUser();
      if (deviceRes != null) {
        getToken();
      }
      update();
    } catch (e) {
      logger.e(e);
    }
  }

  void getToken() async {
    try {
      final res = await authService.getToken(
        body: UsernameBody(
          username: deviceRes?.name,
          password: deviceRes?.id,
        ),
      );
      tokenRes = res;
      if (tokenRes != null) {
        await sharedPref.setToken(tokenRes?.access ?? '');
        await sharedPref.setRefreshToken(tokenRes?.refresh ?? '');
        sharedPref.setDeviceId(deviceId ?? '');
      }
    } catch (e) {
      logger.e(e);
      loadStatus = LoadStatus.failure;
      update();
    }
  }

  Future<void> createDeviceUser() async {
    try {
      CreateDeviceBody body = CreateDeviceBody(
        id: deviceId,
        name: deviceName,
        type: deviceType,
      );
      print(body.toJson());
      final rest = await authService.createDevice(body: body);
      deviceRes = rest;
    } catch (e) {
      logger.e(e);
      loadStatus = LoadStatus.failure;
      update();
    }
  }

  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceId = info.identifierForVendor ?? '';
      deviceName = info.name ?? '';
      await sharedPref.setDeviceId(deviceId);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      deviceId = info.id;
      deviceName = info.device;
      await sharedPref.setDeviceId(deviceId);
      deviceType = '1';
    }
    update();
  }
}

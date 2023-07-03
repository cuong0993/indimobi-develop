import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class FunctionUtil {
  /// Checks if string is email.
  static bool isEmail(String email) => GetUtils.isEmail(email);

  /// Checks if string is phone number.
  static bool isPhoneNumber(String email) => GetUtils.isPhoneNumber(email);

  /// Checks if string is URL.
  static bool isURL(String url) => GetUtils.isURL(url);

  static Future<List<XFile>> getMultiPhoto() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final List<XFile>? images;
      PermissionStatus status;
      if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var release = androidInfo.version.release;

        if (double.parse(release) < 13) {
          await Permission.storage.request();
          status = await Permission.storage.status;
        } else {
          await Permission.photos.request();
          status = await Permission.photos.status;
        }
      } else {
        await Permission.photos.request();
        status = await Permission.photos.status;
      }
      print(status);
      if (status.isGranted) {
        images = await imagePicker.pickMultiImage(imageQuality: 50);
        return images;
      } else {
        AppDialog.messages(
          message: 'Yêu cầu quyền truy cập ảnh!',
          onTapOk: () {
            Get.back();
            openAppSettings();
          },
        );
        return [];
      }
    } catch (e) {
      logger.e(e.toString());
      return [];
    }
  }

  static Future<XFile?> getPhoto() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? images;
      late PermissionStatus status;

      if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var release = androidInfo.version.release;

        if (double.parse(release) < 13) {
          await Permission.storage.request();
          status = await Permission.storage.status;
        } else {
          await Permission.photos.request();
          status = await Permission.photos.status;
        }
      } else {
        await Permission.photos.request();
        status = await Permission.photos.status;
      }
      print(status);
      if (status.isGranted) {
        images = await imagePicker.pickImage(
            imageQuality: 50, source: ImageSource.gallery);
        return images;
      } else {
        AppDialog.messages(
          message: 'Yêu cầu quyền truy cập ảnh!',
          onTapOk: () {
            Get.back();
            openAppSettings();
          },
        );
        return null;
      }
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  static Future<void> shareDefault(String text) async {
    logger.d("shareDefault  text:$text");
    if (text.isNotEmpty == true) {
      await Share.share(text);
    }
  }

  static TextAlign getTextAlign(String text) {
    if (text == 'TextAlign.center') {
      return TextAlign.center;
    } else if (text == 'TextAlign.right') {
      return TextAlign.right;
    } else {
      return TextAlign.left;
    }
  }
}

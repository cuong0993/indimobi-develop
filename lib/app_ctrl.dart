import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class AppCtrl extends GetxController {
  bool isShowDialogE = false;
  String phone = '';

  Future<void> showDialogE(String? errorMsg,
      {VoidCallback? onTap, String? path}) async {
    if (!isShowDialogE) {
      isShowDialogE = true;
      AppDialog.messages(
        message: errorMsg ?? 'System error!',
        onTapOk: () {
          onTap != null ? onTap() : Get.back();
          isShowDialogE = false;
        },
      );
    }
  }
}

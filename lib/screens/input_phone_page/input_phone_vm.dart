import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/models/body/send_otp_body.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/confirm_otp_page/confirm_otp_page.dart';
import 'package:indimobi/services/auth_service.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class InputPhoneVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  AuthService authService = Get.find();
  SharedPref sharedPref = Get.find();
  bool enableButton = false;

  void enableBtn(String text) {
    if (text.length > 9) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    update();
  }

  Future<void> sendOtp(BuildContext context, {required String phone}) async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      String device = await sharedPref.getDeviceId() ?? '';
      final rest = await authService.sendOtp(
        body: SendOtpBody(phone: phone, deviceId: device),
      );

      if (rest != null && rest.status == true) {
        sharedPref.setPhone(phone);
        loadStatus = LoadStatus.success;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmOtpPage(phone: phone),
          ),
        );
      } else {
        AppDialog.messages(message: rest?.detail);
        loadStatus = LoadStatus.failure;
      }
      update();
    } catch (e) {
      logger.e(e);
      loadStatus = LoadStatus.failure;
      update();
    }
  }
}

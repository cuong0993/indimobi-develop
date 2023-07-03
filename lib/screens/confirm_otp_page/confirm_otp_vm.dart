import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/models/body/confirm_otp_body.dart';
import 'package:indimobi/models/body/send_otp_body.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/delivery_address_page/delivery_address_page.dart';
import 'package:indimobi/screens/main_home_page/main_home_vm.dart';
import 'package:indimobi/services/auth_service.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class ConfirmOtpVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  LoadStatus loadReSend = LoadStatus.initial;
  AuthService authService = Get.find();
  MainHomeVm mainHomeVm = Get.find();
  bool enableButton = false;

  void enableBtn(String text) {
    if (text.length > 3) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    update();
  }

  Future<void> sendConfirmOtp(BuildContext context,
      {required String phone, required String otp}) async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      final rest = await authService.confirmOtp(
        body: ConfirmOtpBody(phone: phone, otp: otp),
      );
      if (rest != null && rest.status == true) {
        loadStatus = LoadStatus.success;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryAddressPage(),
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

  Future<void> sendOtp({required String phone}) async {
    try {
      loadReSend = LoadStatus.loading;
      update();
      final rest = await authService.sendOtp(
        body: SendOtpBody(phone: phone, deviceId: mainHomeVm.deviceId),
      );
      if (rest != null && rest.status == true) {
        loadReSend = LoadStatus.success;
      } else {
        AppDialog.messages(message: rest?.detail);
        loadReSend = LoadStatus.failure;
      }
      update();
    } catch (e) {
      logger.e(e);
      loadReSend = LoadStatus.failure;
      update();
    }
  }
}

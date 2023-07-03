import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';

class AppSnackBar {
  static showSnackBar({String? title, required String mess}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        '',
        '',
        titleText: Text(
          title ?? 'Thông báo',
          style: AppTextStyle.textSize_16.copyWith(
            color: AppColors.colorButtonGreen,
          ),
        ),
        messageText: Text(
          mess,
          style: AppTextStyle.textSize_14.copyWith(
            color: AppColors.mainTextColor,
          ),
        ),
        shouldIconPulse: true,
        barBlur: 25,
        isDismissible: true,
        duration: const Duration(milliseconds: 2000),
      );
    }
  }
}

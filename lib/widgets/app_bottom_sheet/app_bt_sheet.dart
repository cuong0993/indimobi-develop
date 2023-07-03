import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class AppBottomSheet {
  static Future<void> showLogin({VoidCallback? onTap}) async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              color: AppColors.mainTextColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'こちらのコンテンツをご覧いただくには、\n+IDアカウントでのログインが必要です。',
                    style: AppTextStyle.textSize_16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  AppButton(
                    bgrColor: AppColors.buttonDarkColor,
                    title: 'Login/Create Account',
                    onPress: () {
                      onTap?.call();
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
      isScrollControlled: true,
    );
  }
}

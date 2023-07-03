import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppNavigate {
  AppNavigate();
  Future<void> toPage({required Widget page}) async {
    Get.to(
      () => page,
      routeName: page.toString(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 250),
    );
  }

  Future<dynamic> backData({required Widget page}) async {
    return Get.to(
      () => page,
      routeName: page.toString(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 250),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/screens/main_home_page/main_home_page.dart';

class IntroVm extends GetxController {
  late PageController controller;
  int indexPage = 0;
  SharedPref sharedPref = Get.find<SharedPref>();

  List<String> listImg = [
    AppImages.imgIntro1,
    AppImages.imgIntro2,
    AppImages.imgIntro3,
  ];

  void initData() {
    controller = PageController(
      keepPage: true,
      initialPage: 0,
      viewportFraction: 1.0,
    );
  }

  void onChangePage(int index) {
    indexPage = index;
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    update();
  }

  void updateIndex(int index) {
    if (index > 2) {
      Get.offAll(
        () => const MainHomePage(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
      );
      sharedPref.setFinishIntro(true);
    } else {
      indexPage = index;
      controller
        ..animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
    }
    update();
  }
}

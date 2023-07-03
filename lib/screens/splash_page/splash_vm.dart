import 'package:get/get.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/screens/main_home_page/main_home_page.dart';
import 'package:indimobi/screens/splash_page/intro_page/intro_page.dart';

class SplashVm extends GetxController {
  bool flagOpacity = false;

  SharedPref sharedPref = Get.find<SharedPref>();

  void init() async {
    Future.delayed(const Duration(milliseconds: 1600), () {
      sharedPref.getFinishIntro().then((value) {
        if (value != null && value == true) {
          Get.offAll(
            () => const MainHomePage(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500),
          );
        } else {
          Get.offAll(
            () => const IntroPage(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500),
          );
        }
      });
    });
  }

  void updateBrg() {
    flagOpacity = true;
    update();
  }
}

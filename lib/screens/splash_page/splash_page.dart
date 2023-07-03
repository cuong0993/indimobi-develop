import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/screens/splash_page/splash_vm.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  SplashVm vm = Get.put<SplashVm>(SplashVm());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      vm.updateBrg();
    });
    vm.init();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<SplashVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      body: Center(
        child: GetBuilder<SplashVm>(
          builder: (logic) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: logic.flagOpacity ? 1.0 : 0.1,
              child: Image.asset(
                AppImages.imgSplash,
                width: Get.width * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}

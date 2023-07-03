import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/generated/l10n.dart';
import 'package:indimobi/screens/splash_page/intro_page/intro_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  IntroVm vm = Get.put<IntroVm>(IntroVm());

  @override
  void initState() {
    super.initState();
    vm.initData();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<IntroVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            buildLogo(),
            SizedBox(height: Get.height * 0.05),
            buildBody(),
            const SizedBox(height: 15),
            buildDot(),
            const SizedBox(height: 20),
            buildButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      AppImages.imgSplash,
      height: Get.height * 0.1,
      fit: BoxFit.fitHeight,
    );
  }

  Widget buildBody() {
    List<String> listIntro = [
      S.of(context).txt_intro_1,
      S.of(context).txt_intro_2,
      S.of(context).txt_intro_3,
    ];
    return Expanded(
      child: PageView.builder(
        scrollBehavior: const ScrollBehavior(),
        controller: vm.controller,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.asset(
                vm.listImg[index],
                width: Get.width,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.03,
                  horizontal: 35,
                ),
                child: Text(
                  listIntro[index],
                  style: AppTextStyle.textSize_16.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          );
        },
        onPageChanged: (index) {
          vm.onChangePage(index);
        },
      ),
    );
  }

  Widget buildButton() {
    return GetBuilder<IntroVm>(builder: (logic) {
      return AppButton(
        width: Get.width * 0.45,
        title: logic.indexPage == 2
            ? 'Bắt đầu'.toUpperCase()
            : S.of(context).txt_continue.toUpperCase(),
        onPress: () {
          vm.updateIndex(logic.indexPage + 1);
        },
      );
    });
  }

  Widget buildDot() {
    return GetBuilder<IntroVm>(builder: (logic) {
      List<int> list = [0, 1, 2];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.map((e) {
          return Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  e == logic.indexPage ? AppColors.primary : Colors.transparent,
              border: Border.all(color: AppColors.primary, width: 0.7),
            ),
          );
        }).toList(),
      );
    });
  }
}

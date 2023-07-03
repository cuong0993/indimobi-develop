import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/ic_back_cpn.dart';
import 'package:indimobi/screens/input_phone_page/input_phone_page.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      IcBackCpn(
                        colorIconBack: Colors.white,
                      ),
                      Text(
                        'Quay lại',
                        style: AppTextStyle.textSize_14.copyWith(
                          color: AppColors.textWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              AppButton(
                height: 32,
                radius: 3,
                onPress: () {
                  Get.to(
                    () => InputPhonePage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 250),
                  );
                },
                bgrColor: AppColors.colorButtonGreen,
                title: 'Thanh toán',
                textSize: 13,
                width: 95,
              ),
              SizedBox(width: 12),
            ],
          ),
          Spacer(),
          SizedBox(height: Get.height * 0.07),
          Spacer(),
        ],
      ),
    );
  }
}

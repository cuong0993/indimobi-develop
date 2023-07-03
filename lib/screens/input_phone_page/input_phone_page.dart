import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/ic_back_green_cpn.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/input_phone_page/input_phone_vm.dart';
import 'package:indimobi/screens/main_home_page/main_home_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:indimobi/widgets/app_gradient/app_greadient.dart';
import 'package:indimobi/widgets/app_text_fields/app_text_field.dart';

class InputPhonePage extends StatefulWidget {
  const InputPhonePage({Key? key}) : super(key: key);

  @override
  InputPhonePageState createState() => InputPhonePageState();
}

class InputPhonePageState extends State<InputPhonePage> {
  InputPhoneVm vm = Get.put<InputPhoneVm>(InputPhoneVm());
  TextEditingController textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<MainHomeVm>().login();
  }

  @override
  void dispose() {
    textCtrl.dispose();
    Get.delete<InputPhoneVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientOtp,
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Row(children: [IcBackGreenCpn()]),
                buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Xác thực số điện thoại',
              style: AppTextStyle.textBoldWhiteSize_22,
            ),
            SizedBox(height: Get.height * 0.05),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8),
                boxShadow: AppShadows.boxShadowAll,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Nhập số điện thoại',
                    style: AppTextStyle.textBoldSize_18,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Đăng nhập ngay lập tức thông qua số điện thoại của bạn',
                    style: AppTextStyle.textSize_16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.colorBrg,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.7,
                          ),
                        ),
                        height: 35,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+84',
                          style: AppTextStyle.textSize_16,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorBrg,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.7,
                            ),
                          ),
                          height: 35,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          alignment: Alignment.centerLeft,
                          child: AppTextField(
                            fillColor: Colors.transparent,
                            borderColor: Colors.transparent,
                            maxLine: 1,
                            maxLength: 10,
                            inputType: TextInputType.number,
                            contentPadding: EdgeInsets.zero,
                            hintStyle: AppTextStyle.textSize_12.copyWith(
                              color: AppColors.buttonColorGrey,
                            ),
                            hintText: 'Nhập số điện thoại',
                            controller: textCtrl,
                            style: AppTextStyle.textSize_16,
                            onChange: (text) {
                              vm.enableBtn(text);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5,
                    ),
                    child: Text(
                      'Indi sẽ gửi tin nhắn SMS xác thực đến số điện thoại của bạn',
                      style: AppTextStyle.textSize_16.copyWith(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Bằng cách nhấn ',
                        style: AppTextStyle.textSize_16.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                        children: [
                          TextSpan(
                            text: 'Đăng nhập,',
                            style: AppTextStyle.textSize_16
                                .copyWith(fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
                          ),
                          const TextSpan(text: ' bạn sẽ đồng ý với các'),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Điều khoản sử dụng của Indi',
                    style: AppTextStyle.textBoldSize_16.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  GetBuilder<InputPhoneVm>(builder: (logic) {
                    return AppButton(
                      onPress: () {
                        if (logic.enableButton) {
                          FocusScope.of(context).unfocus();
                          vm.sendOtp(context, phone: textCtrl.text);
                        }
                      },
                      bgrColor: logic.enableButton ? AppColors.colorGreen : AppColors.borderColors,
                      isLoad: logic.loadStatus == LoadStatus.loading,
                      title: 'Đăng nhập',
                      textSize: 14,
                      width: Get.width,
                      height: 38,
                      radius: 6,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

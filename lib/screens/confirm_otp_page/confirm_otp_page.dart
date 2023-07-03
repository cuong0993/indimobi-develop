import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/ic_back_green_cpn.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/confirm_otp_page/confirm_otp_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:indimobi/widgets/app_gradient/app_greadient.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmOtpPage extends StatefulWidget {
  final String phone;

  ConfirmOtpPage({required this.phone});

  @override
  ConfirmOtpPageState createState() => ConfirmOtpPageState();
}

class ConfirmOtpPageState extends State<ConfirmOtpPage> {
  ConfirmOtpVm vm = Get.put<ConfirmOtpVm>(ConfirmOtpVm());
  TextEditingController textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    textCtrl.dispose();
    Get.delete<ConfirmOtpVm>();
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.1),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8),
                boxShadow: AppShadows.boxShadowAll,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 35),
              padding: const EdgeInsets.only(
                  top: 25, left: 25, right: 25, bottom: 10),
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nhập mã xác nhận',
                    style: AppTextStyle.textBoldSize_18,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Sửa +${widget.phone}',
                      style: AppTextStyle.textSize_14,
                    ),
                  ),
                  const SizedBox(height: 45),
                  buildPinCode(),
                  const SizedBox(height: 35),
                  buildBtn(),
                  const SizedBox(height: 10),
                  GetBuilder<ConfirmOtpVm>(builder: (logic) {
                    return TextButton(
                      onPressed: () {
                        textCtrl.text = '';
                        vm.sendOtp(phone: widget.phone);
                      },
                      child: logic.loadReSend == LoadStatus.loading
                          ? LoadWidget()
                          : Text(
                              'Tôi không nhận được Mã xác nhận',
                              style: AppTextStyle.textSize_14,
                            ),
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

  Widget buildPinCode() {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      blinkWhenObscuring: false,
      autoFocus: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        borderWidth: 1.5,
        fieldHeight: 45,
        fieldWidth: 40,
        activeFillColor: AppColors.textWhite,
        activeColor: AppColors.primary,
        selectedFillColor: AppColors.primary.withOpacity(0.4),
        selectedColor: AppColors.primary,
        inactiveColor: AppColors.primary,
        inactiveFillColor: AppColors.textWhite,
      ),
      cursorColor: AppColors.black,
      cursorHeight: 20,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: true,
      controller: textCtrl,
      autoDisposeControllers: false,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        vm.enableBtn(value);
        if (kDebugMode) {
          print(value);
        }
      },
    );
  }

  Widget buildBtn() {
    return GetBuilder<ConfirmOtpVm>(builder: (logic) {
      return AppButton(
        onPress: () {
          if (logic.enableButton) {
            FocusScope.of(context).unfocus();
            vm.sendConfirmOtp(context, phone: widget.phone, otp: textCtrl.text);
          }
        },
        bgrColor:
            logic.enableButton ? AppColors.colorGreen : AppColors.borderColors,
        isLoad: logic.loadStatus == LoadStatus.loading,
        title: 'Tiếp theo',
        textSize: 14,
        width: Get.width,
        height: 38,
        radius: 6,
      );
    });
  }
}

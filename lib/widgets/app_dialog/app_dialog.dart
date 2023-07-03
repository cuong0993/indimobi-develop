import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/generated/l10n.dart';
import 'package:indimobi/widgets/app_dialog/widgets/body_confirm.dart';

class AppDialog {
  static Future<void> messages({
    @required String? message,
    String? title,
    String? titleButton,
    VoidCallback? onTapOk,
    bool? iconNext = false,
  }) async {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: Get.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                title != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 15,
                          right: 15,
                          left: 15,
                        ),
                        child: Text(
                          title,
                          style: AppTextStyle.textSize_18.copyWith(
                            color: AppColors.mainTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    message ?? S.current.txt_system_error,
                    style: AppTextStyle.textSize_16.copyWith(
                      color: AppColors.mainTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 0.5,
                  width: Get.width,
                  color: AppColors.borderColors,
                ),
                GestureDetector(
                  onTap: onTapOk ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Expanded(
                          child: Text(
                            titleButton ?? 'OK',
                            style: AppTextStyle.textSizeBold_16.copyWith(
                              color: AppColors.colorButtonGreen,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        iconNext == true
                            ? const Icon(
                                Icons.navigate_next_outlined,
                                color: AppColors.borderColors,
                                size: 15,
                              )
                            : const SizedBox(width: 15),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  static Future<void> confirm({
    required String? message,
    String? title,
    String? titleButtonL,
    String? titleButtonR,
    VoidCallback? onTapR,
    VoidCallback? onTapL,
  }) async {
    Get.generalDialog(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: BodyConfirm(
              title: title,
              titleButtonL: titleButtonL,
              titleButtonR: titleButtonR,
              message: message,
              onTapL: onTapL,
              onTapR: onTapR,
            ),
          ),
        );
      },
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 50),
    );
  }

  static Future<void> question() async {
    List<String> titles = [
      'Câu hỏi thường gặp',
      S.current.txt_video,
      'Tổng đài hỗ trợ',
    ];
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.99),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.separated(
              itemCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 8,
                  ),
                  child: Text(
                    titles[index],
                    textAlign: TextAlign.center,
                    style: AppTextStyle.textSize_16.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: Get.width,
                  color: AppColors.textBlack.withOpacity(0.8),
                  height: 0.2,
                );
              },
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 8,
                  bottom: 15,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Hủy',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textSize_18.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierColor: AppColors.black.withOpacity(0.15),
      enableDrag: false,
      isDismissible: true,
      enterBottomSheetDuration: Duration(milliseconds: 150),
      exitBottomSheetDuration: Duration(milliseconds: 150),
    );
  }
}

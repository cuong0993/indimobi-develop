import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/generated/l10n.dart';

class BodyConfirm extends StatelessWidget {
  final String? message;
  final String? title;
  final String? titleButtonL;
  final String? titleButtonR;
  final Color? bgrColor;
  final VoidCallback? onTapR;
  final VoidCallback? onTapL;

  const BodyConfirm({
    Key? key,
    required this.message,
    this.title,
    this.titleButtonL,
    this.titleButtonR,
    this.onTapR,
    this.onTapL,
    this.bgrColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: Get.width * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 15),
            child: Text(
              title ?? 'Thông báo',
              style: AppTextStyle.textSize_18.copyWith(
                color: AppColors.mainTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// Content
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, left: 15, right: 15),
            child: Text(
              message ?? '${S.of(context).txt_system_error}!',
              style: AppTextStyle.textSize_16.copyWith(
                color: AppColors.mainTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 0.3,
            width: Get.width,
            color: AppColors.buttonColor,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTapL?.call();
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      titleButtonL ?? 'Hủy',
                      style: AppTextStyle.textSize_16.copyWith(
                        color: AppColors.mainTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                width: 0.3,
                color: AppColors.buttonColor,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTapR?.call();
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      titleButtonR ?? 'Xóa',
                      style: AppTextStyle.textSize_16.copyWith(
                        color: AppColors.colorLoadRed,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

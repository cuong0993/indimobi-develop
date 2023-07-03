import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';

class AppButtonNext extends StatelessWidget {
  final String? title;
  final String? subTitle;

  final VoidCallback onPress;

  final Color? bgrColor;
  final Color? borderColor;

  final double? height;
  final double? width;
  final double? radius;

  final bool? disable;

  final Color? textColor;

  const AppButtonNext({
    Key? key,
    this.title,
    required this.onPress,
    this.height,
    this.bgrColor,
    this.width,
    this.textColor,
    this.radius,
    this.subTitle,
    this.disable = false,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      height: height ?? 42,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: bgrColor ?? AppColors.primary,
              onPrimary: Colors.greenAccent,
              elevation: 0,
              padding: const EdgeInsets.only(left: 18, right: 2)),
          onPressed: () async {
            onPress();
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title ?? 'Next',
                  style: AppTextStyle.textSize_16.copyWith(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.navigate_next,
                color: AppColors.textWhite,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

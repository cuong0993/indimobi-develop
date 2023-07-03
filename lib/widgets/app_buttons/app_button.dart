import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/load_widget_white.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final String? subTitle;

  final VoidCallback onPress;

  final Color? bgrColor;
  final Color? borderColor;

  final double? height;
  final double? width;
  final double? radius;

  final bool? disable;
  final bool? isLoad;

  final Color? textColor;
  final double? textSize;
  final TextStyle? textStyle;

  const AppButton({
    Key? key,
    this.title,
    required this.onPress,
    this.height,
    this.bgrColor,
    this.width,
    this.textColor,
    this.radius,
    this.subTitle,
    this.isLoad = false,
    this.disable = false,
    this.borderColor,
    this.textStyle,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      height: height ?? 42,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(radius ?? 6),
        color: bgrColor ?? AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        onPressed: () {
          onPress();
        },
        child: isLoad == true
            ? Center(child: LoadWidget(width: 25, height: 25))
            : Text(
                title ?? 'Next',
                style: textStyle ??
                    AppTextStyle.textSize_16.copyWith(
                      color: textColor ?? AppColors.textWhite,
                      fontWeight: FontWeight.w400,
                      fontSize: textSize ?? 16,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}

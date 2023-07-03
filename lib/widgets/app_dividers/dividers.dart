import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';

class DividersCustom extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const DividersCustom({Key? key, this.width, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      width: width ?? Get.width,
      color: color ?? AppColors.subColor.withOpacity(0.8),
    );
  }
}

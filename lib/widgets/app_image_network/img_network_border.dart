import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';

class ImgNetWorkBorder extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final BorderRadius? borderCustom;

  const ImgNetWorkBorder({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.radius,
    this.borderCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderCustom ?? BorderRadius.circular(radius ?? 10),
      child: (url == null || url == '')
          ? Container(
              height: height ?? Get.height,
              width: width ?? Get.width,
              color: AppColors.bgrDarkColor,
              child: Center(
                child: Image.asset(
                  AppImages.imgSplash,
                  fit: BoxFit.cover,
                  height: height ?? Get.height,
                  width: width ?? Get.width,
                ),
              ),
            )
          : FadeInImage.assetNetwork(
              placeholder: AppImages.imgSplash,
              image: url ?? '',
              fit: BoxFit.cover,
              height: height ?? Get.height,
              width: width ?? Get.width,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppImages.imgSplash,
                  fit: BoxFit.cover,
                  height: height ?? Get.height,
                  width: width ?? Get.width,
                );
              },
            ),
    );
  }
}

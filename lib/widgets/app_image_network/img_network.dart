import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_images.dart';

class ImgNetWork extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;

  const ImgNetWork({Key? key, required this.url, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (url == null || url == '')
        ? Image.asset(
            AppImages.imgSplash,
            fit: BoxFit.cover,
            height: height ?? Get.height,
            width: width ?? Get.width,
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
          );
  }
}

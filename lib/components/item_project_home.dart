import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/image_file_cpn.dart';

class ItemProjectHome extends StatelessWidget {
  final int totalProject;
  final String imageLayout;
  final String image;

  ItemProjectHome({
    required this.totalProject,
    required this.imageLayout,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      margin: const EdgeInsets.only(top: 5, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: AppShadows.boxShadowAllProject,
      ),
      child: Row(
        children: [
          SizedBox(width: 3),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              boxShadow: AppShadows.boxShadowAllProject,
            ),
            width: 75,
            height: 75,
            child: Stack(
              children: [
                ImageFileCpn(image: image ?? ''),
                Image.asset(imageLayout, fit: BoxFit.cover),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              'Dự án hiện tại của bạn ($totalProject)',
              style: AppTextStyle.textSize_16.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.navigate_next,
            size: 25,
            color: AppColors.mainTextColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/image_file_cpn.dart';

class ItemCurrentProject extends StatelessWidget {
  final String image;
  final String imageLayout;
  final String type;
  final String name;

  ItemCurrentProject({
    required this.name,
    required this.image,
    required this.imageLayout,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          SizedBox(width: 6),
          Container(
            decoration: BoxDecoration(
              boxShadow: AppShadows.boxShadowAllProject,
            ),
            width: 75,
            height: 75,
            child: Stack(
              children: [
                image != '' ? ImageFileCpn(image: image) : SizedBox(),
                Image.asset(imageLayout, fit: BoxFit.cover),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.textSize_14,
                ),
                const SizedBox(height: 5),
                Text(
                  '(${type}cm)',
                  style: AppTextStyle.textSize_14,
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.navigate_next,
            size: 25,
            color: AppColors.colorButtonGreen,
          ),
        ],
      ),
    );
  }
}

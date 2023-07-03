import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/late_start/black_frame_page/black_frame_vm.dart';

class BlackFramePage extends StatefulWidget {
  const BlackFramePage({Key? key}) : super(key: key);

  @override
  BlackFramePageState createState() => BlackFramePageState();
}

class BlackFramePageState extends State<BlackFramePage> {
  BlackFrameVm vm = Get.put<BlackFrameVm>(BlackFrameVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BlackFrameVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Khung đen',
        colorTitle: AppColors.black,
      ),
      body: buildAlbum(),
    );
  }

  Widget buildAlbum() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: Get.width * 0.5,
        childAspectRatio: 1 / 1.1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Text('Bộ ${index + 1}', style: AppTextStyle.textSize_16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: AppShadows.boxShadow,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppImages.imgPlane,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

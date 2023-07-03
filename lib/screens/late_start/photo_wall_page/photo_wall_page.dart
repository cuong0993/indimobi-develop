import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/late_start/grain_frame_page/grain_frame_page.dart';
import 'package:indimobi/screens/late_start/photo_wall_page/photo_wall_vm.dart';

class PhotoWallPage extends StatefulWidget {
  const PhotoWallPage({Key? key}) : super(key: key);

  @override
  PhotoWallPageState createState() => PhotoWallPageState();
}

class PhotoWallPageState extends State<PhotoWallPage> {
  PhotoWallVm vm = Get.put<PhotoWallVm>(PhotoWallVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PhotoWallVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(
        title: 'Ảnh treo tường',
        colorTitle: AppColors.black,
      ),
      body: buildAlbum(),
    );
  }

  Widget buildAlbum() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => const GrainFramePage());
          },
          child: Column(
            children: [
              Text('Khung vân gỗ', style: AppTextStyle.textSize_16),
              Container(
                width: Get.width * 0.4,
                height: Get.width * 0.4,
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
              const SizedBox(height: 30)
            ],
          ),
        );
      },
    );
  }
}

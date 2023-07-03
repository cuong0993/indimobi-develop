import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_constants.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/photo_books_page/photo_books_page.dart';
import 'package:indimobi/screens/product_option_page/product_option_vm.dart';

class ProductOptionPage extends StatefulWidget {
  const ProductOptionPage({Key? key}) : super(key: key);

  @override
  State<ProductOptionPage> createState() => ProductOptionPageState();
}

class ProductOptionPageState extends State<ProductOptionPage> {
  ProductOptionVm vm = Get.put<ProductOptionVm>(ProductOptionVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<ProductOptionVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: CustomAppBar(
        title: 'Tùy chọn sản phẩm',
        bgr: AppColors.colorBrg,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25, width: Get.width),
              Text(
                'Chọn phong cách',
                style: AppTextStyle.textSize_18.copyWith(color: Colors.green),
              ),
              SizedBox(height: Get.height * 0.05),
              buildItem(
                title: 'Photobook mở phẳng',
                img: AppImages.imgPlane,
                onPress: () {
                  Get.to(
                    () => const PhotoBooksPage(name: AppConst.photoPha),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 250),
                  );
                },
              ),
              SizedBox(height: Get.height * 0.06),
              buildItem(
                title: 'Photobook mở cong',
                img: AppImages.imgCurved,
                onPress: () {
                  Get.to(
                    () => const PhotoBooksPage(name: AppConst.photoCong),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 250),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem({
    required String title,
    required String img,
    required VoidCallback onPress,
  }) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 3),
            ),
            child: Image.asset(
              img,
              height: Get.height * 0.25,
              fit: BoxFit.cover,
              width: Get.width * 0.8,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: AppTextStyle.textSize_16,
          ),
        ],
      ),
    );
  }
}

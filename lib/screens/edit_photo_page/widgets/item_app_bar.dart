import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/screens/add_emoji_page/add_emoji_page.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class ItemAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    EditPhotoVm vm = Get.find<EditPhotoVm>();

    return CustomAppBar(
      title: '',
      colorTitle: AppColors.black,
      actions: [
        GetBuilder<EditPhotoVm>(builder: (logic) {
          return GestureDetector(
            onTap: () async {
              final res = await Get.to(
                () => AddEmojiPage(
                  stickers: logic.currentPage.stickers ?? [],
                  imageWidget: LayoutWidget(
                    isEditEmoji: false,
                    isView: true,
                    isGrid: false,
                    pagesEntity: logic.currentPage,
                  ),
                  pagesEntity: logic.currentPage,
                ),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 250),
              );
              if (res != null) {
                print('object');
                vm.updateEmoji(res);
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppImages.icAddImage,
                width: 26,
                height: 26,
                color: AppColors.colorButtonGreen,
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () {
            AppDialog.question();
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.icQuestion,
              width: 26,
              height: 26,
              color: AppColors.colorButtonGreen,
            ),
          ),
        ),
      ],
    );
  }
}

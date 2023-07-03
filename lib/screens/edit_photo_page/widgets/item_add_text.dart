import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/add_content_page/add_content_page.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';

class ItemAddText extends StatelessWidget {
  final EditPhotoVm vm = Get.find<EditPhotoVm>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPhotoVm>(
      builder: (logic) {
        return GestureDetector(
          onTap: () async {
            final result = await Get.to(
              () => AddContentPage(pagesEntity: logic.currentPage),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 250),
            );
            if (result != null) {
              vm.updateExtraText(result);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textWhite,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 18),
                Text(
                  (logic.currentPage.texts != null && logic.currentPage.texts?.length != 0)
                      ? 'Sửa nội dung'
                      : 'Thêm nội dung',
                  style: AppTextStyle.textSize_16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

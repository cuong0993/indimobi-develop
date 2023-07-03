import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class ItemSave extends StatelessWidget {
  final bool isEditCover;
  final String id;

  ItemSave({required this.isEditCover, required this.id});

  @override
  Widget build(BuildContext context) {
    EditPhotoVm vm = Get.find<EditPhotoVm>();
    return Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 8),
      color: AppColors.colorBottomBar,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isEditCover
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      vm.backPage();
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: 70,
                      child: Row(
                        children: [
                          Icon(Icons.navigate_before_outlined,
                              size: 24, color: AppColors.textWhite),
                          SizedBox(width: 5),
                          GetBuilder<EditPhotoVm>(builder: (logic) {
                            return Text(
                              logic.indexP == 1
                                  ? ''
                                  : 'Trg ${logic.indexP - 1}',
                              style: AppTextStyle.textSize_12.copyWith(
                                color: AppColors.textWhite,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
            GetBuilder<EditPhotoVm>(builder: (logic) {
              return AppButton(
                height: 32,
                radius: 4,
                onPress: () {
                  if (isEditCover) {
                    Get.back(result: logic.currentPage);
                  } else {
                    vm.updatePage();
                    Get.back(result: 1);
                  }
                },
                bgrColor: AppColors.colorButtonGreen,
                title: 'Lưu thay đổi',
                textSize: 14,
                width: 120,
              );
            }),
            isEditCover
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      vm.nextPage();
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GetBuilder<EditPhotoVm>(builder: (logic) {
                            return Text(
                              logic.indexP == logic.listPage.length - 2
                                  ? ''
                                  : 'Trg ${logic.indexP + 1}',
                              style: AppTextStyle.textSize_12.copyWith(
                                color: AppColors.textWhite,
                              ),
                            );
                          }),
                          SizedBox(width: 5),
                          Icon(
                            Icons.navigate_next_outlined,
                            size: 24,
                            color: AppColors.textWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

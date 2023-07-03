import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ItemLayout extends StatelessWidget {
  final bool isEditCover;

  ItemLayout({this.isEditCover = false});

  @override
  Widget build(BuildContext context) {
    EditPhotoVm vm = Get.find();
    return SizedBox(
      height: 72,
      child: GetBuilder<EditPhotoVm>(builder: (logic) {
        return ScrollablePositionedList.separated(
          initialScrollIndex: 0,
          physics: BouncingScrollPhysics(),
          itemScrollController: logic.itemScroll,
          scrollDirection: Axis.horizontal,
          itemCount:
              isEditCover ? coverLayouts.length : imagePageLayouts.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                vm.updateLayout(
                  isEditCover ? coverLayouts[index] : imagePageLayouts[index],
                );
              },
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  border: Border.all(
                    color: (isEditCover
                            ? (coverLayouts[index] == logic.layout)
                            : (imagePageLayouts[index] == logic.layout))
                        ? AppColors.colorButtonGreen
                        : Colors.white,
                    width: 1.5,
                  ),
                ),
                child: Image.asset(
                  isEditCover ? imageCovers[index] : imagePageLayouts[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 5),
        );
      }),
    );
  }
}

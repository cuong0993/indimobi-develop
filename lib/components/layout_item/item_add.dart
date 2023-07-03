import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/utils/function_utils.dart';

class ItemAdd extends StatelessWidget {
  final bool isEditCover;
  final bool? isView;
  final Function(XFile file) addImage;

  ItemAdd({this.isEditCover = false, this.isView = false, required this.addImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isView != true) {
          XFile? file = await FunctionUtil.getPhoto();
          if (file != null) {
            addImage.call(file);
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.colorLayout.withOpacity(isView == true ? 0.5 : 1),
        child: Center(
          child: isEditCover == true ? SizedBox() : buildImageNull(),
        ),
      ),
    );
  }

  Widget buildImageNull() {
    return isView == true
        ? Icon(
            Icons.add_photo_alternate_outlined,
            size: 15,
            color: AppColors.borderColors,
          )
        : Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Icon(
              Icons.add,
              size: 12,
              color: AppColors.primary,
            ),
          );
  }
}

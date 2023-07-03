import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/packages/crop_image/crop_image.dart';
import 'package:indimobi/screens/crop_img/crop_image_widget_vm.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class CropImageWidget extends StatefulWidget {
  const CropImageWidget({
    Key? key,
    required this.photo,
    required this.aspectRatio,
  }) : super(key: key);

  final PhotosEntity photo;
  final double aspectRatio;

  @override
  State<CropImageWidget> createState() => CropImageWidgetState();
}

class CropImageWidgetState extends State<CropImageWidget> {
  CropImageVm vm = Get.put<CropImageVm>(CropImageVm());

  @override
  void initState() {
    super.initState();
    vm.initData(widget.photo, widget.aspectRatio);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                    child: GetBuilder<CropImageVm>(builder: (logic) {
                      return logic.images == null
                          ? SizedBox()
                          : CropImage(
                              controller: logic.controller,
                              image: logic.images ??
                                  Image.memory(Uint8List.fromList([])),
                              paddingSize: 0.0,
                              alwaysMove: true,
                            );
                    }),
                  ),
                  bottomWidget(),
                ],
              ),
              GetBuilder<CropImageVm>(
                builder: (logic) {
                  return logic.loadCrop == LoadStatus.loading
                      ? LoadWidget()
                      : SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          itemIcon(
            'Huỷ',
            isReplace: true,
            textSize: 16,
            onTap: () async {
              Get.back();
            },
          ),
          itemIcon(
            'Thay thế',
            icon: Icons.repeat_outlined,
            isReplace: true,
            onTap: () async {
              vm.replaceImage();
            },
          ),
          GetBuilder<CropImageVm>(builder: (logic) {
            return itemIcon(
              'Xóa',
              icon: Icons.delete_outline,
              onTap: () async {
                await AppDialog.confirm(
                  message: 'Bạn muốn xóa ảnh này?',
                  title: 'Thông báo',
                  onTapR: () {
                    vm.deleteImage();
                  },
                );
              },
            );
          }),
          itemIcon(
            'Lưu',
            textSize: 16,
            textColor: AppColors.colorButtonGreen,
            onTap: () {
              vm.savePage();
            },
          ),
        ],
      ),
    );
  }

  Widget itemIcon(String title,
      {Color? textColor,
      double? textSize,
      IconData? icon,
      Function? onTap,
      bool? isReplace}) {
    return GetBuilder<CropImageVm>(builder: (logic) {
      return GestureDetector(
        onTap: () {
          if (onTap != null && logic.loadCrop != LoadStatus.loading) {
            onTap.call();
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: (title == 'Thay thế' || title == 'Xóa') ? 0 : 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              icon != null
                  ? RotatedBox(
                      quarterTurns: isReplace == true ? 1 : 0,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 3),
              Text(
                title,
                style: AppTextStyle.textWhiteSize_14.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: textSize ?? 14,
                  color: textColor ?? Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

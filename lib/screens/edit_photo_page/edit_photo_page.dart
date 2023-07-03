import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/screens/crop_img/crop_image_widget.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';
import 'package:indimobi/screens/edit_photo_page/widgets/item_add_text.dart';
import 'package:indimobi/screens/edit_photo_page/widgets/item_app_bar.dart';
import 'package:indimobi/screens/edit_photo_page/widgets/item_image.dart';
import 'package:indimobi/screens/edit_photo_page/widgets/item_layout.dart';
import 'package:indimobi/screens/edit_photo_page/widgets/item_save.dart';

class EditPhotoPage extends StatefulWidget {
  final String idAlbum;
  final String idPage;
  final bool isEditCover;

  EditPhotoPage({
    required this.idPage,
    required this.idAlbum,
    required this.isEditCover,
  });

  @override
  EditPhotoPageState createState() => EditPhotoPageState();
}

class EditPhotoPageState extends State<EditPhotoPage> {
  EditPhotoVm vm = Get.put<EditPhotoVm>(EditPhotoVm());
  AppCtrl appCtrl = Get.find<AppCtrl>();
  GlobalKey scrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    vm.initData(
      idAlbum: widget.idAlbum,
      idPage: widget.idPage,
      isCover: widget.isEditCover,
    );
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<EditPhotoVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: ItemAppBar(),
      body: Column(
        children: [
          ItemImage(),
          SizedBox(height: 30),
          GetBuilder<EditPhotoVm>(builder: (logic) {
            return RepaintBoundary(
              key: scrKey,
              child: SizedBox(
                width: Get.width * 0.8,
                height: Get.width * 0.8,
                child: LayoutWidget(
                  pagesEntity: logic.currentPage,
                  isView: false,
                  isEditEmoji: false,
                  isGrid: false,
                  addImage: (file, index) {
                    vm.addFileToIndex(file, index);
                  },
                  cropImage: (photo, aspectRatio) async {
                    final PhotosEntity? res = await Get.to(
                      () => CropImageWidget(photo: photo, aspectRatio: aspectRatio),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 400),
                    );
                    if (res != null) {
                      vm.updateCropImg(res);
                    }
                  },
                ),
              ),
            );
          }),
          SizedBox(height: 25),
          ItemAddText(),
          Spacer(),
          ItemLayout(isEditCover: widget.isEditCover),
          ItemSave(isEditCover: widget.isEditCover, id: widget.idAlbum),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/image_unit_cpn.dart';
import 'package:indimobi/components/layout_item/item_add.dart';
import 'package:indimobi/components/layout_item/item_text_cover.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';
import 'package:indimobi/packages/drs_widget/drs_widget.dart';
import 'package:indimobi/screens/add_content_page/add_content_page.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';
import 'package:indimobi/utils/function_utils.dart';

class LayoutWidget extends StatelessWidget {
  final PagesEntity pagesEntity;
  final bool? isView;
  final bool? isGrid;
  final bool? isEditEmoji;
  final bool? isEditText;
  final Function(PhotosEntity photo, double aspectRatio)? cropImage;
  final Function(XFile file, int index)? addImage;

  LayoutWidget({
    required this.pagesEntity,
    this.isView = true,
    this.isGrid = false,
    this.isEditEmoji = false,
    this.isEditText = false,
    this.cropImage,
    this.addImage,
  });

  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();

  double width = Get.width * 0.8;
  double height = Get.width * 0.8;

  PhotosEntity? photo1;
  PhotosEntity? photo2;
  PhotosEntity? photo3;
  PhotosEntity? photo4;

  int indexItem = 0;

  @override
  Widget build(BuildContext context) {
    initData();
    List<Widget> listWidget = [
      buildType1(),
      buildType2(),
      buildType3(),
      buildType4(),
      buildType5(),
      buildType6(),
      buildType7(),
      buildType8(),
      buildType9(),
      buildType10(),
      buildType11(),
      buildType12(),
      buildType13(),
      buildType14(),
      buildType15(),
      buildType16(),
      buildType17(),
      buildType18(),
      buildType19(),
      buildType20(),
      buildType21(),
      buildType22(),
      buildType23(),
      buildType24(),
      buildType25(),
    ];
    Future.delayed(Duration(milliseconds: 500), () {
      initRender();
    });
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(isView == true ? 5 : 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                (pagesEntity.isEditCover == true)
                    ? GestureDetector(
                        onTap: () {
                          callCropImage(0, 1);
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            listWidget[0],
                            Image.asset(
                              coverLayouts[indexItem],
                              fit: BoxFit.cover,
                            ),
                            isEditText == false
                                ? ItemTextCover(
                                    index: indexItem,
                                    isGrid: isGrid ?? false,
                                    texts: pagesEntity.texts ?? [],
                                    width: isGrid == true ? Get.width * 0.42 : Get.width * 0.8,
                                    height: isGrid == true ? Get.width * 0.42 : Get.width * 0.8,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    : listWidget[indexItem != -1 ? indexItem : 0],
                isEditEmoji == true
                    ? SizedBox()
                    : Stack(
                        fit: StackFit.expand,
                        children:
                            pagesEntity.stickers?.map((e) => buildDrsWidget(e)).toList() ?? [],
                      ),
              ],
            ),
          ),
          SizedBox(
            height: pagesEntity.isEditCover == true ? 0 : (isView == true ? 1 : 2),
          ),
          pagesEntity.isEditCover == true ? SizedBox() : buildText(),
        ],
      ),
    );
  }

  Widget buildType1() {
    return checkViewImage(key1, 1);
  }

  Widget buildType2() {
    return checkViewImage(key1, 1.1);
  }

  Widget buildType3() {
    return Row(
      children: [
        Expanded(child: checkViewImage(key1, 0.5)),
        horizontalLine(),
        Expanded(child: checkViewImage(key2, 0.5)),
      ],
    );
  }

  Widget buildType4() {
    return Column(
      children: [
        Expanded(child: checkViewImage(key1, 2)),
        verticalLine(),
        Expanded(child: checkViewImage(key2, 2)),
      ],
    );
  }

  Widget buildType5() {
    double h = isView == true ? height * 0.09 : height * 0.2;
    return Column(
      children: [
        SizedBox(height: h, width: Get.width),
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 0.9)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 0.9)),
            ],
          ),
        ),
        SizedBox(height: h, width: Get.width),
      ],
    );
  }

  Widget buildType6() {
    double h = isView == true ? height * 0.09 : height * 0.2;
    return Column(
      children: [
        SizedBox(height: h, width: Get.width),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: checkViewImage(key1, 1)),
              horizontalLine(),
              Expanded(flex: 2, child: checkViewImage(key2, 0.7)),
            ],
          ),
        ),
        SizedBox(height: h, width: Get.width),
      ],
    );
  }

  Widget buildType7() {
    double h = isView == true ? height * 0.085 : height * 0.175;
    return Column(
      children: [
        SizedBox(height: h, width: Get.width),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: checkViewImage(key1, 0.9)),
              horizontalLine(),
              Expanded(flex: 2, child: checkViewImage(key2, 0.65)),
            ],
          ),
        ),
        SizedBox(height: h, width: Get.width),
      ],
    );
  }

  Widget buildType8() {
    return Row(
      children: [
        Expanded(child: checkViewImage(key1, 0.5)),
        horizontalLine(),
        Expanded(
          child: Column(
            children: [
              Expanded(child: checkViewImage(key2, 1)),
              verticalLine(),
              Expanded(child: checkViewImage(key3, 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType9() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(child: checkViewImage(key1, 1)),
              verticalLine(),
              Expanded(child: checkViewImage(key3, 1)),
            ],
          ),
        ),
        horizontalLine(),
        Expanded(child: checkViewImage(key2, 0.5)),
      ],
    );
  }

  Widget buildType10() {
    return Column(
      children: [
        Expanded(child: checkViewImage(key1, 2)),
        verticalLine(),
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key2, 1)),
              horizontalLine(),
              Expanded(child: checkViewImage(key3, 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType11() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 1)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 1)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(child: checkViewImage(key3, 2)),
      ],
    );
  }

  Widget buildType12() {
    return Column(
      children: [
        Expanded(flex: 3, child: checkViewImage(key1, 1.7)),
        verticalLine(),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key2, 1.2)),
              horizontalLine(),
              Expanded(child: checkViewImage(key3, 1.2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType13() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(child: checkViewImage(key1, 1.2)),
              verticalLine(),
              Expanded(child: checkViewImage(key2, 1.2)),
            ],
          ),
        ),
        horizontalLine(),
        Expanded(flex: 2, child: checkViewImage(key3, 0.4)),
      ],
    );
  }

  Widget buildType14() {
    double h = isView == true ? height * 0.1 : height * 0.22;
    return Column(
      children: [
        SizedBox(height: h, width: Get.width),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 2, child: checkViewImage(key1, 0.55)),
              horizontalLine(),
              Expanded(flex: 3, child: checkViewImage(key2, 0.8)),
              horizontalLine(),
              Expanded(flex: 2, child: checkViewImage(key3, 0.55)),
            ],
          ),
        ),
        SizedBox(height: h, width: Get.width),
      ],
    );
  }

  Widget buildType15() {
    return Row(
      children: [
        Expanded(flex: 1, child: checkViewImage(key1, 0.35)),
        horizontalLine(),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(child: checkViewImage(key2, 1.35)),
              verticalLine(),
              Expanded(child: checkViewImage(key3, 1.35)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType16() {
    return Column(
      children: [
        Expanded(flex: 1, child: checkViewImage(key1, 3)),
        verticalLine(),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key2, 0.75)),
              horizontalLine(),
              Expanded(child: checkViewImage(key3, 0.75)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType17() {
    return Row(
      children: [
        Expanded(child: checkViewImage(key1, 0.35)),
        horizontalLine(),
        Expanded(child: checkViewImage(key2, 0.35)),
        horizontalLine(),
        Expanded(child: checkViewImage(key3, 0.35)),
      ],
    );
  }

  Widget buildType18() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 1)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 1)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key3, 1)),
              horizontalLine(),
              Expanded(child: checkViewImage(key4, 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType19() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 0.8)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 0.8)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key3, 1.5)),
              horizontalLine(),
              Expanded(child: checkViewImage(key4, 1.5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType20() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 0.7)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 0.7)),
              horizontalLine(),
              Expanded(child: checkViewImage(key3, 0.7)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(child: checkViewImage(key4, 2)),
      ],
    );
  }

  Widget buildType21() {
    return Row(
      children: [
        Expanded(child: checkViewImage(key1, 0.5)),
        horizontalLine(),
        Expanded(
          child: Column(
            children: [
              Expanded(child: checkViewImage(key2, 1.5)),
              verticalLine(),
              Expanded(child: checkViewImage(key3, 1.5)),
              verticalLine(),
              Expanded(child: checkViewImage(key4, 1.5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType22() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 0.85)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 0.85)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: checkViewImage(key3, 1.3)),
              horizontalLine(),
              Expanded(child: checkViewImage(key4, 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType23() {
    double h = isView == true ? height * 0.09 : height * 0.2;
    return Column(
      children: [
        SizedBox(height: h, width: Get.width),
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key1, 1.8)),
              horizontalLine(),
              Expanded(child: checkViewImage(key2, 1.8)),
            ],
          ),
        ),
        verticalLine(),
        Expanded(
          child: Row(
            children: [
              Expanded(child: checkViewImage(key3, 1.8)),
              horizontalLine(),
              Expanded(child: checkViewImage(key4, 1.8)),
            ],
          ),
        ),
        SizedBox(height: h, width: Get.width),
      ],
    );
  }

  Widget buildType24() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 2, child: checkViewImage(key1, 1.2)),
              verticalLine(),
              Expanded(flex: 3, child: checkViewImage(key2, 0.85)),
            ],
          ),
        ),
        horizontalLine(),
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 3, child: checkViewImage(key3, 0.85)),
              verticalLine(),
              Expanded(flex: 2, child: checkViewImage(key4, 1.2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildType25() {
    return buildType2();
  }

  Widget horizontalLine() {
    return SizedBox(width: 1);
  }

  Widget verticalLine() {
    return SizedBox(height: 1);
  }

  Widget checkViewImage(Key key, double aspectRatio) {
    PhotosEntity photo = PhotosEntity();
    int index = 0;
    if (key == key1) {
      photo = photo1 ?? PhotosEntity();
      index = 0;
    } else if (key == key2) {
      photo = photo2 ?? PhotosEntity();
      index = 1;
    } else if (key == key3) {
      photo = photo3 ?? PhotosEntity();
      index = 2;
    } else if (key == key4) {
      photo = photo4 ?? PhotosEntity();
      index = 3;
    } else {
      photo = photo1 ?? PhotosEntity();
      index = 0;
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      key: isGrid == true ? null : key,
      child: (photo.path != '' && photo.path != null)
          ? GestureDetector(
              onTap: () {
                callCropImage(index, aspectRatio);
              },
              // child: (photo.imageCrop != null && photo.imageCrop != [])
              //     ?

              child: ImageUnitCpn(images: photo.imageCrop ?? []),
              // : ImageFileCpn(image: photo.path ?? ''),
            )
          : ItemAdd(
              isView: isView,
              isEditCover: pagesEntity.isEditCover ?? false,
              addImage: (file) {
                addImage?.call(file, index);
              },
            ),
    );
  }

  buildText() {
    TextsEntity? text = pagesEntity.texts?.length != 0 ? pagesEntity.texts?.first : TextsEntity();

    return GestureDetector(
      onTap: () async {
        if (isEditEmoji == false) {
          if (text?.content != null &&
              text?.content != '' &&
              Get.isRegistered<EditPhotoVm>() == true) {
            final result = await Get.to(
              () => AddContentPage(pagesEntity: pagesEntity),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 250),
            );
            if (result != null) {
              Get.find<EditPhotoVm>().updateExtraText(result);
            }
          }
        }
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 2,
          right: 2,
          top: isView == true ? 1 : 2,
          bottom: isView == true ? 0 : 2,
        ),
        child: Material(
          color: Colors.transparent,
          child: Text(
            text?.content ?? '',
            style: AppTextStyle.textSize_8.copyWith(
              fontSize: ((text?.size?.toDouble() ?? 0) + (isView == true ? -2 : 0)),
              fontFamily: text?.font,
            ),
            textAlign: FunctionUtil.getTextAlign(text?.textAlign ?? ''),
          ),
        ),
      ),
    );
  }

  Widget buildDrsWidget(StickersEntity e) {
    return DRSWidget(
      isEdit: false,
      isGrid: isGrid ?? false,
      nameImage: e.image,
      stickers: e,
    );
  }

  void callCropImage(int index, double aspectRatio) {
    List<PhotosEntity> photos = pagesEntity.photos ?? [];
    for (int i = 0; i < photos.length; i++) {
      if (photos[i].indexL == index) {
        cropImage?.call(photos[i], aspectRatio);
      }
    }
  }

  void initRender() async {
    if (isView == false && Get.isRegistered<EditPhotoVm>()) {
      RenderBox? ren1;
      RenderBox? ren2;
      RenderBox? ren3;
      RenderBox? ren4;

      if (key1.currentContext?.findRenderObject() != null) {
        ren1 = await getWidgetInfo(key1);
      }
      if (key2.currentContext?.findRenderObject() != null) {
        ren2 = await getWidgetInfo(key2);
      }
      if (key3.currentContext?.findRenderObject() != null) {
        ren3 = await getWidgetInfo(key3);
      }
      if (key4.currentContext?.findRenderObject() != null) {
        ren4 = await getWidgetInfo(key4);
      }

      Get.find<EditPhotoVm>().updateRenderBox(
        ren1: ren1,
        ren2: ren2,
        ren3: ren3,
        ren4: ren4,
      );
    }
  }

  void initData() {
    indexItem = (pagesEntity.isEditCover == true)
        ? coverLayouts.indexOf(pagesEntity.layout ?? '')
        : imagePageLayouts.indexOf(pagesEntity.layout ?? '');

    List<PhotosEntity> list = List.from(pagesEntity.photos ?? []);

    for (int i = 0; i < list.length; i++) {
      PhotosEntity photo = list[i];
      if (photo.indexL == 0) {
        photo1 = photo;
      }
      if (photo.indexL == 1) {
        photo2 = photo;
      }
      if (photo.indexL == 2) {
        photo3 = photo;
      }
      if (photo.indexL == 3) {
        photo4 = photo;
      }
    }
  }

  Future<RenderBox?> getWidgetInfo(GlobalKey widgetKey) async {
    final RenderBox? renderBox = await widgetKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox;
  }
}

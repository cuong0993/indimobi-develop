import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/packages/reorder_able_grid_view/reorder_able_grid_view.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_page.dart';

class ItemGridWidget extends StatelessWidget {
  final String id;

  ItemGridWidget({required this.id});

  final DetailProjectVm vm = Get.find<DetailProjectVm>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProjectVm>(builder: (logic) {
      int length = logic.listPage.length;
      return ReorderAbleGridView.builder(
        dragEnabled: true,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 25,
          crossAxisCount: 2,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: length,
        itemBuilder: (context, index) {
          PagesEntity pagesEntity = logic.listPage[index];
          if (index != 0 && index != length - 1) {
            return ReorderAbleItemView(
              child: buildItemGrid(
                index: index,
                page: pagesEntity,
                length: length,
                showCancel: true,
                isPlaceHolder: false,
              ),
              key: ValueKey(index),
              index: index,
            );
          } else {
            return buildItemGrid(
              index: index,
              page: pagesEntity,
              length: length,
              showCancel: false,
              isPlaceHolder: false,
            );
          }
        },
        placeholderBuilder: (dragIndex, dropIndex, dragWidget) {
          return Opacity(
            opacity: 0.6,
            child: buildItemGrid(
              index: dropIndex,
              page: logic.listPage[dragIndex],
              length: length,
              showCancel: false,
              isPlaceHolder: true,
            ),
          );
        },
        unableDrag: [0, length - 1],
        dragStartDelay: Duration(milliseconds: 500),
        onReorder: (dragIndex, dropIndex) {
          vm.dragPageAlbum(dragIndex, dropIndex);
        },
        onDragStart: (index) {},
        addAutomaticKeepAlive: true,
      );
    });
  }

  Widget buildItemGrid({
    required int index,
    PagesEntity? page,
    required int length,
    required bool showCancel,
    required bool isPlaceHolder,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                margin: EdgeInsets.only(
                  top: 8,
                  right: index % 2 == 0 ? 0 : 8,
                  left: index % 2 != 0 ? 0 : 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 0.6),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                child: (showCancel == false && isPlaceHolder == false)
                    ? buildBlank()
                    : LayoutWidget(
                        isView: true,
                        isGrid: true,
                        isEditEmoji: false,
                        pagesEntity: page ?? PagesEntity(),
                      ),
              ),
            ),
            SizedBox(height: 5),
            buildName(index, isPlaceHolder, length),
          ],
        ),
        GestureDetector(
          onTap: () async {
            if (showCancel) {
              final res = await Get.to(
                () => EditPhotoPage(
                  idPage: page?.idLocal ?? '',
                  idAlbum: id,
                  isEditCover: false,
                ),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 250),
              );
              if (res != null) {
                vm.initData(id);
              }
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        (showCancel) ? buildDelete(index, page) : SizedBox(),
      ],
    );
  }

  Widget buildDelete(int index, PagesEntity? page) {
    return Align(
      alignment: index % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          vm.deletePage(page?.idLocal ?? '');
        },
        child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
              width: 0.3,
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(2),
          child: Image.asset(
            AppImages.icDelete,
            fit: BoxFit.fitWidth,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget buildName(int index, bool isPlaceHolder, int length) {
    return Padding(
      padding: EdgeInsets.only(
        right: index % 2 == 0 ? 0 : 8,
        left: index % 2 != 0 ? 0 : 8,
      ),
      child: Material(
        color: Colors.transparent,
        child: Text(
          isPlaceHolder == false
              ? ((index != 0 && index != length - 1) ? 'Trang ${index}' : 'Bìa bên trong')
              : '',
          style: AppTextStyle.textSize_14,
        ),
      ),
    );
  }

  Widget buildBlank() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.3),
        color: Colors.white,
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Colors.grey.withOpacity(0.8),
        ),
      ),
    );
  }
}

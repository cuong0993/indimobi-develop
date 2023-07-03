import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';

class PreviewAlbumVm extends GetxController {
  bool isLeft = true;

  List<PagesEntity> listPage = [];

  List<Widget> listWidgetL = [];
  List<Widget> listWidgetR = [];
  PagesEntity? pageCover;
  int indexTemp = 0;

  Widget widgetLeft = SizedBox();
  Widget widgetRight = SizedBox();
  Widget widgetBack = SizedBox();
  Widget widgetFront = SizedBox();

  void updateUiLeft() {
    widgetRight = widgetBack;
    update();
  }

  void updateUiRight() {
    widgetLeft = widgetBack;
    update();
  }

  void clickLeft() {
    widgetLeft = listWidgetL[indexTemp - 1];
    widgetFront = listWidgetL[indexTemp];
    widgetBack = listWidgetR[indexTemp - 1];
    indexTemp--;
    update();
  }

  void clickRight() {
    int lengthL = listWidgetL.length - 1;
    int lengthR = listWidgetR.length - 1;

    if (indexTemp < lengthL && indexTemp < lengthR) {
      widgetRight = listWidgetR[indexTemp + 1];
      widgetFront = listWidgetR[indexTemp];
      widgetBack = listWidgetL[indexTemp + 1];

      indexTemp++;
      update();
    }
  }

  void initListPage(AlbumEntity albumEntity) {
    listPage = [];
    indexTemp = 0;
    pageCover = albumEntity.cover;
    listPage = albumEntity.pages ?? [];
    for (int i = 0; i < listPage.length; i++) {
      if (i % 2 == 0) {
        listWidgetL.add(buildItemGrid(
          index: i,
          page: listPage[i],
        ));
      } else {
        listWidgetR.add(buildItemGrid(
          index: i,
          page: listPage[i],
        ));
      }
    }
    widgetLeft = listWidgetL[0];
    widgetRight = listWidgetR[0];
    update();
  }

  void initUi() {
    widgetLeft = listWidgetL[0];
    widgetRight = listWidgetR[0];
    update();
  }

  Widget buildItemGrid({
    required int index,
    PagesEntity? page,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        LayoutWidget(
          isView: true,
          isGrid: true,
          isEditEmoji: false,
          pagesEntity: page ?? PagesEntity(),
        ),
        Container(color: Colors.transparent)
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EditPhotoVm extends GetxController {
  ItemScrollController itemScroll = ItemScrollController();
  LoadStatus loadStatusEmoji = LoadStatus.initial;
  int countImage = 0;

  RenderBox? renderBox1;
  RenderBox? renderBox2;
  RenderBox? renderBox3;
  RenderBox? renderBox4;

  bool isEditCover = false;

  PagesEntity currentPage = PagesEntity();
  List<PagesEntity> listPage = [];
  AlbumEntity albumEntity = AlbumEntity();

  int indexP = -1;
  int indexAlbum = -1;
  String layout = '';
  List<String> listPathImage = [];

  HiveData hiveData = Get.find();
  List<AlbumEntity> listAlbum = [];

  void initData({required String idAlbum, required String idPage, required bool isCover}) async {
    try {
      isEditCover = isCover;
      listAlbum = await hiveData.getProjectsDeep() ?? [];
      indexAlbum = listAlbum.indexWhere((e) => e.id == idAlbum);
      albumEntity = listAlbum[indexAlbum];
      listPage.addAll(albumEntity.pages ?? []);

      if (isCover) {
        currentPage = albumEntity.cover ?? PagesEntity();
        itemScroll.jumpTo(index: coverLayouts.indexOf(currentPage.layout ?? ''));
      } else {
        indexP = listPage.indexWhere((e) => e.idLocal == idPage);
        currentPage = listPage[indexP];
        itemScroll.jumpTo(index: imagePageLayouts.indexOf(currentPage.layout ?? ''));
      }
      layout = currentPage.layout ?? '';

      if (currentPage.photos?.length != 0) {
        if (currentPage.photos?[0].path?.trim() != '') {
          listPathImage.add(currentPage.photos?[0].path ?? '');
        }
      }
      for (int i = 0; i < listPage.length; i++) {
        List<PhotosEntity> photos = [];
        photos.addAll(listPage[i].photos ?? []);
        if (photos.isNotEmpty) {
          for (int j = 0; j < photos.length; j++) {
            if (photos[j].path != null &&
                photos[j].path?.trim() != '' &&
                !listPathImage.contains(photos[j].path)) {
              listPathImage.add(photos[j].path ?? '');
            }
          }
        }
      }
      update(['img_list']);
      update();
    } catch (e) {
      logger.e(e);
    }
  }

  void addFileToIndex(XFile file, int index) async {
    List<int> fileInt = await file.readAsBytes();
    List<PhotosEntity> list = List.from(currentPage.photos ?? []);
    PhotosEntity photo = PhotosEntity(
      idLocal: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    photo = photo.copyWith(path: file.path, indexL: index, imageCrop: fileInt);
    bool haveImage = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i].indexL == index) {
        haveImage = true;
        list[i] = photo;
        break;
      }
    }
    if (!haveImage) {
      list.add(photo);
    }
    currentPage.photos = list;
    listPage.firstWhere((element) => element.idLocal == currentPage.idLocal).photos =
        List<PhotosEntity>.from(list);
    update();
  }

  void updateCropImg(PhotosEntity photo) {
    List<PhotosEntity> list = List<PhotosEntity>.from(currentPage.photos ?? []);

    for (int i = 0; i < list.length; i++) {
      if (list[i].idLocal == photo.idLocal) {
        list[i] = photo;
        break;
      }
    }
    currentPage = currentPage.copyWith(photos: list);
    listPage.firstWhere((element) => element.idLocal == currentPage.idLocal).photos =
        List.from(list);
    update();
  }

  void updateLayout(String layoutImage) {
    currentPage = currentPage.copyWith(layout: layoutImage);
    if (!isEditCover) {
      listPage[indexP] = currentPage;
    }
    layout = layoutImage;
    update();
  }

  void updatePage() async {
    listAlbum[indexAlbum].pages?.clear();
    listAlbum[indexAlbum].pages?.addAll(listPage);
    await hiveData.addProjectDeep(listAlbum);
  }

  void nextPage() {
    if (indexP < listPage.length - 2) {
      indexP = indexP + 1;
      currentPage = listPage[indexP];
      layout = currentPage.layout ?? '';
      itemScroll.scrollTo(
        index: imagePageLayouts.indexOf(layout),
        duration: Duration(milliseconds: 300),
      );
      update();
    }
  }

  void backPage() {
    if (indexP > 1) {
      indexP = indexP - 1;
      currentPage = listPage[indexP];
      layout = currentPage.layout ?? '';
      itemScroll.scrollTo(
        index: imagePageLayouts.indexOf(layout),
        duration: Duration(milliseconds: 300),
      );
      update();
    }
  }

  void dragAndUpdateImage(Offset offset, String path) async {
    List<PhotosEntity> list = List.from(currentPage.photos ?? []);
    PhotosEntity photo = PhotosEntity(
      idLocal: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    int indexL = -1;

    if (checkRenderBox(renderBox1, offset)) {
      indexL = 0;
    }
    if (checkRenderBox(renderBox2, offset)) {
      indexL = 1;
    }
    if (checkRenderBox(renderBox3, offset)) {
      indexL = 2;
    }
    if (checkRenderBox(renderBox4, offset)) {
      indexL = 3;
    }

    if (indexL != -1) {
      List<int> listInt = await File(path).readAsBytes();
      photo = photo.copyWith(path: path, indexL: indexL, imageCrop: listInt);
      bool haveImage = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i].indexL == indexL) {
          haveImage = true;
          list[i] = photo;
          break;
        }
      }
      if (!haveImage) {
        list.add(photo);
      }
      currentPage.photos = list;
      listPage.firstWhere((element) => element.idLocal == currentPage.idLocal).photos =
          List<PhotosEntity>.from(list);
      update();
    }
  }

  void updateRenderBox({
    RenderBox? ren1,
    RenderBox? ren2,
    RenderBox? ren3,
    RenderBox? ren4,
  }) {
    renderBox1 = ren1;
    renderBox2 = ren2;
    renderBox3 = ren3;
    renderBox4 = ren4;
  }

  bool checkRenderBox(RenderBox? renderBox, Offset offset) {
    bool result = false;
    if (renderBox != null &&
        isSmallOffset(offset, renderBox.localToGlobal(Offset.zero), renderBox.size)) {
      result = true;
    }
    return result;
  }

  bool isSmallOffset(Offset offsetPar, Offset offsetMin, Size size) {
    final offsetMax = getOffsetMax(offsetMin, size);
    if ((offsetPar.dx > offsetMin.dx && offsetPar.dx < offsetMax.dx) &&
        (offsetPar.dy > offsetMin.dy && offsetPar.dy < offsetMax.dy)) {
      return true;
    } else {
      return false;
    }
  }

  Offset getOffsetMax(Offset offset, Size size) {
    double dx = offset.dx + size.width - 10;
    double dy = offset.dy + size.height;
    return Offset(dx, dy);
  }

  void updateExtraText(List<TextsEntity> texts) {
    currentPage = currentPage.copyWith(texts: texts);
    listPage.firstWhere((e) => e.idLocal == currentPage.idLocal).texts = List.from(texts);
    update();
  }

  void updateEmoji(List<StickersEntity> stickers) {
    currentPage = currentPage.copyWith(stickers: stickers);
    listPage.firstWhere((element) => element.idLocal == currentPage.idLocal).stickers =
        List.from(stickers);
    update();
  }
}

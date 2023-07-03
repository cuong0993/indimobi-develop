import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/packages/crop_image/crop_controller.dart';
import 'package:indimobi/utils/function_utils.dart';

class CropImageVm extends GetxController {
  late CropController controller;

  late Rect? rect;
  Uint8List? imageCrop;
  HiveData hiveData = Get.find();
  LoadStatus loadStatus = LoadStatus.initial;
  LoadStatus loadCrop = LoadStatus.initial;

  PhotosEntity photo = PhotosEntity();

  Image? images;
  double scale = 1.0;

  void scaleImage(double s) {
    scale = s;
    print(scale);
    update();
  }

  void initData(PhotosEntity image, double aspectRatio) async {
    loadStatus = LoadStatus.loading;
    update();
    controller = CropController(
      aspectRatio: aspectRatio,
      defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
    );
    photo = image;
    imageCrop = await Uint8List.fromList(File(photo.path ?? '').readAsBytesSync());
    rect = Rect.fromLTWH(0, 0, 0, 0);

    images = Image.file(File(photo.path ?? ''));

    loadStatus = LoadStatus.success;
    update();
  }

  void updateRect(Rect? rec) {
    rect = rec;
    update();
  }

  Future<void> updateImage(Uint8List image) async {
    imageCrop = image;

    photo = photo.copyWith(imageCrop: imageCrop);
    Get.back(result: photo);
  }

  void savePage() async {
    loadCrop = LoadStatus.loading;
    update();

    await controller.croppedImage().then((value) {
      if (value.isNotEmpty) {
        photo = photo.copyWith(imageCrop: value);
        loadCrop = LoadStatus.success;
        update();
        Get.back(result: photo);
      }
    });
  }

  void deleteImage() async {
    photo = await photo.copyWith(path: '', imageCrop: []);
    Get.back(result: photo);
  }

  Future<void> replaceImage() async {
    final res = await FunctionUtil.getPhoto();
    if (res != null) {
      photo = photo.copyWith(imageCrop: [], path: res.path);
      images = Image.file(File(res.path));
      update();
    }
  }
}

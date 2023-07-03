import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class AddEmojiVm extends GetxController {
  int indexLayout = 0;
  int index = 0;

  List<String> listEmojiContent = listEmoji1;
  StickersEntity sticker = StickersEntity();

  List<StickersEntity> listSticker = [];

  List<List<String>> listPath = [
    listEmoji1,
    listEmoji2,
    listEmoji3,
    listEmoji4,
    listEmoji5,
  ];

  void initData(List<StickersEntity> list) {
    listSticker.clear();
    List<StickersEntity> listStick = List<StickersEntity>.from(list);
    listSticker.addAll(listStick);
    update();
  }

  void selectEmoji(String inD) {
    index = listSticker.indexWhere((element) => element.idLocal == inD);
    StickersEntity stick = listSticker[index];
    sticker = StickersEntity.fromJson(stick.toJson());
    update();
  }

  void saveSticker() {
    Get.back(result: listSticker);
  }

  void addEmoji(String emojiPath) {
    listSticker.add(
      StickersEntity(
        centerX: double.parse((Get.width * 0.41 - 62).toStringAsFixed(2)),
        angle: 0.0,
        centerY: double.parse((Get.width * 0.41 - 62).toStringAsFixed(2)),
        image: emojiPath,
        width: 42,
        height: 42,
        isFlip: false,
        idLocal: '${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    update();
  }

  void removeEmoji() {
    listSticker.removeAt(index);
    index = 0;
    update();
  }

  void updatePosition({
    Offset? offset,
    double? scaleFactor,
    double? rotation,
    bool? isFlip,
  }) {
    sticker = sticker.copyWith(
      isFlip: isFlip,
      angle: rotation,
      centerY: double.parse((offset?.dy)?.toStringAsFixed(2) ?? '0.0'),
      centerX: double.parse((offset?.dx)?.toStringAsFixed(2) ?? '0.0'),
      width: (scaleFactor ?? 1) * 42,
      height: (scaleFactor ?? 1) * 42,
    );
    listSticker[index] = sticker;
    update();
  }

  void updateIndexLayout(int index) {
    indexLayout = index;
    listEmojiContent = listPath[index];
    update();
  }

  void deleteAllEmoji() {
    AppDialog.confirm(
      message: 'Bạn muốn xóa tất cả emoji?',
      title: 'Thông báo',
      onTapR: () {
        listSticker.clear();
        update();
      },
    );
  }
}

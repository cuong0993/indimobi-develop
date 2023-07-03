import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/commons/app_constants.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/entity/hive_entity/size_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';
import 'package:indimobi/models/entity/set_price.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_page.dart';
import 'package:indimobi/services/home_service.dart';
import 'package:indimobi/utils/logger.dart';

class BookCoverVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  String type = coverLayouts[0];
  String layoutBlank = 'layout_blank';
  HiveData hiveData = Get.find();
  HomeService homeService = Get.find();

  Future<void> createAlbum(
      {required List<XFile> listFile,
      required String names,
      required String typeAlbum,
      required List<List<int>> listInt,
      required BuildContext context}) async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      String typeName = names == AppConst.photoPha
          ? 'PHOTOBOOK_MOPHANG_$typeAlbum'
          : 'PHOTOBOOK_MOCONG_$typeAlbum';

      String idProduct = await settingProduct(typeName);

      XFile fileCover = await listFile[0];
      List<int> intCover = listInt[0];
      await listFile.removeAt(0);
      await listInt.removeAt(0);

      listInt.insert(0, []);
      listFile.insert(0, XFile('', name: layoutBlank));
      listInt.add([]);
      listFile.add(XFile('', name: layoutBlank));

      int genId = DateTime.now().millisecondsSinceEpoch;
      List<PagesEntity> listPage = [];

      for (int i = 0; i < listFile.length; i++) {
        if (i == 2 || i == 6 || i == 10) {
          listPage.add(PagesEntity(
            idLocal: '${genId + i}',
            photos: [
              PhotosEntity(
                idLocal: '${genId + i}',
                path: listFile[i].path,
                indexL: 0,
                imageCrop: listInt[i],
              ),
              PhotosEntity(
                idLocal: '${genId + i + 1}',
                path: listFile[i + 1].path,
                indexL: 1,
                imageCrop: listInt[i + 1],
              ),
            ],
            isEditCover: false,
            layout: imagePageLayouts[2],
          ));
        } else if (i != 3 && i != 7 && i != 11) {
          listPage.add(PagesEntity(
            idLocal: '${genId + i}',
            photos: [
              PhotosEntity(
                idLocal: '${genId + i}',
                path: listFile[i].path,
                indexL: 0,
                imageCrop: listInt[i],
              ),
            ],
            isEditCover: false,
            layout: imagePageLayouts[0],
          ));
        }
      }
      AlbumEntity current = await AlbumEntity(
        id: '$genId',
        product_id: idProduct,
        pages: listPage,
        cover: PagesEntity(
          idLocal: '$genId',
          isEditCover: true,
          photos: [
            PhotosEntity(
              idLocal: '$genId',
              path: fileCover.path,
              indexL: 0,
              imageCrop: intCover,
            )
          ],
          texts: [
            TextsEntity(idLocal: '$genId 1'),
            TextsEntity(idLocal: '$genId 2'),
            TextsEntity(idLocal: '$genId 3'),
          ],
          layout: type,
        ),
        size: SizeEntity(width: 320, height: 320),
        name: names,
        type: typeAlbum,
        typeName: typeName,
        isAndroid: Platform.isAndroid == true ? 'Android' : 'IOS',
      );
      List<AlbumEntity> listProject = await hiveData.getProjects() ?? [];
      listProject.insert(0, current);
      await hiveData.addProject(listProject);
      loadStatus = LoadStatus.success;
      update();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailProjectPage(id: current.id ?? '$genId'),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void updateSelect(String image) {
    type = image;
    update();
  }

  Future<String> settingProduct(String type) async {
    try {
      final res = await homeService.getSetting();
      if (res != null) {
        Map<String, dynamic> json = await res.toJson();
        PhotoBook? photoBook = await json[type];
        return photoBook?.indiID ?? '';
      }
      return '';
    } catch (e) {
      logger.e(e);
      return '';
    }
  }
}

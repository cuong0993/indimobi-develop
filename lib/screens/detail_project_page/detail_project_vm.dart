import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/body/price_body.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/services/home_service.dart';
import 'package:indimobi/utils/function_utils.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class DetailProjectVm extends GetxController {
  int indexSelect = -1;
  int actionSelect = -1;
  LoadStatus loadStatus = LoadStatus.initial;
  AppCtrl appCtrl = Get.find<AppCtrl>();
  ScrollController scrollController = ScrollController();
  HiveData hiveData = Get.find();
  List<PagesEntity> listPage = [];
  AlbumEntity albumEntity = AlbumEntity();
  HomeService homeService = Get.find();
  List<AlbumEntity> listAlbum = [];
  List<String> listSort = [
    'Thiết kế tự động',
    'Mỗi ảnh một trang',
    'Ảnh từ cũ đến mới',
    'Ảnh từ mới đến cũ',
  ];
  List<String> listOption = [
    'Chọn chủ đề',
    'Xóa dự án',
  ];
  int indexA = 0;
  num price = 0;
  String idProduct = '';
  bool isInit = false;

  void updateCover(PagesEntity page) async {
    albumEntity = albumEntity.copyWith(cover: page);
    listAlbum[indexA] = albumEntity;
    await hiveData.addProject(listAlbum);
    update();
  }

  void initData(String id) async {
    List<AlbumEntity>? list = await hiveData.getProjects() ?? [];
    indexA = list.indexWhere((e) => e.id == id);
    listAlbum = List.from(list);
    albumEntity = await listAlbum[indexA];
    listPage = List.from(albumEntity.pages ?? []);
    update();
    if (isInit == false) {
      await getPrice(listPage.length, albumEntity.product_id);
      isInit = true;
    }
  }

  void addPage() async {
    int genId = DateTime.now().millisecondsSinceEpoch;
    listPage.insertAll(listPage.length - 1, [
      PagesEntity(
        idLocal: '${genId + listPage.length}',
        photos: [
          PhotosEntity(idLocal: '$genId', indexL: 0),
        ],
        layout: imagePageLayouts[0],
        isEditCover: false,
      ),
      PagesEntity(
        idLocal: '${genId + listPage.length + 1}',
        photos: [
          PhotosEntity(idLocal: '$genId', indexL: 0),
        ],
        isEditCover: false,
        layout: imagePageLayouts[0],
      )
    ]);
    int length = listPage.length;
    updateProject();
    getPrice(length, albumEntity.product_id);
  }

  void deletePage(String id) {
    AppDialog.confirm(
      message: 'Bạn muốn xóa trang này?',
      title: 'Thông báo',
      onTapR: () {
        if (listPage.firstWhere((e) => e.idLocal == id).photos == null) {
          listPage.removeWhere(((e) => e.idLocal == id));
        } else {
          listPage.firstWhere((e) => e.idLocal == id).photos = null;
          listPage.firstWhere((e) => e.idLocal == id).stickers = null;
          listPage.firstWhere((e) => e.idLocal == id).layout = imagePageLayouts[0];
          int length = listPage.length;
          getPrice(length, albumEntity.product_id);
        }
        updateProject();
      },
    );
  }

  void dragPageAlbum(int drag, int drop) {
    var item = listPage.removeAt(drag);
    listPage.insert(drop, item);
    updateProject();
  }

  void updateIndexSelect(int index, String text) {
    actionSelect = -1;
    indexSelect = index;
    update();
    switch (text) {
      case 'Thiết kế tự động':
        break;
      case 'Mỗi ảnh một trang':
        break;
      case 'Ảnh từ cũ đến mới':
        break;
      case 'Ảnh từ mới đến cũ':
        break;
      case 'Chọn chủ đề':
        break;
      case 'Xóa dự án':
        deleteProject();
        break;
    }
  }

  void updateActionSelect(int index) {
    actionSelect = index;
    update();
  }

  void deleteProject() {
    AppDialog.confirm(
      message: 'Bạn muốn xóa dự án?',
      title: 'Thông báo',
      onTapR: () async {
        listAlbum.removeAt(indexA);
        await hiveData.addProject(listAlbum);
        Get.back();
      },
    );
  }

  void getImages() async {
    loadStatus = LoadStatus.loading;
    update();
    int genId = DateTime.now().millisecondsSinceEpoch;
    List<XFile> images = await FunctionUtil.getMultiPhoto();
    List<List<int>> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(await images[i].readAsBytes());
    }
    if (images.isNotEmpty) {
      listPage.insertAll(listPage.length - 1, images.map((e) {
        int index = images.indexOf(e);
        return PagesEntity(
          idLocal: '${genId + listPage.length + index}',
          photos: [
            PhotosEntity(path: e.path, idLocal: '$genId', indexL: 0, imageCrop: list[index]),
          ],
          isEditCover: false,
          layout: imagePageLayouts[0],
        );
      }));
      int length = listPage.length;
      updateProject();
      getPrice(length, albumEntity.product_id);
    }
    loadStatus = LoadStatus.success;
    update();
  }

  void updateProject() {
    albumEntity = albumEntity.copyWith(pages: listPage, price: price.toString());
    listAlbum[indexA] = albumEntity.copyWith(pages: listPage);
    hiveData.addProject(listAlbum);
    // List<AlbumEntity>? list = await hiveData.getProjects() ?? [];
    // listAlbum = List.from(list);
    update();
  }

  Future<void> getPrice(int length, String? id) async {
    try {
      final result = await homeService.getPrice(
          body: PriceBody(
        indiIdValue: id ?? '',
        pageNumber: length,
      ));
      price = await result?.data?.price ?? 0;
      update(['price']);
      albumEntity = albumEntity.copyWith(price: price.toInt().toString());
    } catch (e) {
      logger.e(e);
    }
  }
}

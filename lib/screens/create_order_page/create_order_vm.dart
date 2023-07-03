import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as form;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:indimobi/models/body/create_order_body.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/create_order_res.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';
import 'package:indimobi/services/home_service.dart';
import 'package:indimobi/utils/logger.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screenshot/screenshot.dart';

class CreateOrderVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  LoadStatus loadUpload = LoadStatus.initial;
  HomeService homeService = Get.find();
  ScrollController scrollController = ScrollController();
  List<ScreenshotController> ctrlShots = [];
  DetailProjectVm detailVm = Get.find<DetailProjectVm>();
  final listenDialog = BehaviorSubject<bool>.seeded(false);
  final listenCall = BehaviorSubject<bool>.seeded(false);
  final listenCallGoc = BehaviorSubject<bool>.seeded(false);
  int page = 0;
  int pageGoc = 0;

  CreateOderRes? res;

  PageController pageCtrl = PageController(
    viewportFraction: 1,
    keepPage: true,
    initialPage: 0,
  );
  List<FileInfo> listFile = [];
  List<PagesEntity> listPage = [];

  void initData() {
    listPage.add(detailVm.albumEntity.cover ?? PagesEntity());
    listPage.addAll(detailVm.albumEntity.pages ?? []);
    for (int i = 0; i < listPage.length; i++) {
      List<PhotosEntity> list = listPage[i].photos ?? [];
      for (int j = 0; j < list.length; j++) {
        if (list[j].path?.isNotEmpty == true) {
          listFile.add(
            FileInfo(File(list[j].path ?? ''), i, j),
          );
        }
      }
    }
  }

  Future<void> getDetailOrder(AddressEntity? addressEntity) async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      res = await homeService.createOrder(
        body: CreateOrderBody(
          phone: addressEntity?.phone,
          pageNumber: detailVm.listPage.length,
          address: addressEntity?.address,
          paymentMethod: 'COD',
          productId: detailVm.idProduct,
        ),
      );
      if (res != null) {
        Future.delayed(Duration(milliseconds: 100), () {
          uploadFile(res);
        });
      }
      loadStatus = LoadStatus.success;
      update();
    } catch (e) {
      logger.e(e);
      loadStatus = LoadStatus.failure;
      update();
    }
  }

  void uploadFile(CreateOderRes? res) async {
    loadUpload = LoadStatus.loading;
    update();

    if (page < listPage.length - 1) {
      page = page + 1;
      update(['page']);
      await pageCtrl.animateToPage(
        page,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      Uint8List uin8list = await ctrlShots[page].capture() ?? Uint8List(1);
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}_image$page.png').create();
      file.writeAsBytesSync(uin8list);
      await callApiCreateImage(res, file);
      listenCall.add(true);
    } else {
      listenCall.add(false);
      uploadFileGoc(res);
    }
  }

  void uploadFileGoc(CreateOderRes? res) async {
    pageGoc = pageGoc + 1;
    if (pageGoc < listFile.length) {
      final result = await callApiCreateImageGoc(
          res, listFile[pageGoc].file, listFile[pageGoc].indexParent, listFile[pageGoc].index);
      if (result != null) {
        listenCallGoc.add(true);
      }
    } else {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File f = File('${directory.path}/json_file.json');

      AlbumEntity album = detailVm.albumEntity;
      if (album.cover?.photos?.isNotEmpty == true) {
        album.cover?.photos?[0].path = '';
        album.cover?.photos?[0].imageCrop = [];
      }
      for (int i = 0; i < (album.pages?.length ?? 0); i++) {
        for (int j = 0; j < (album.pages?[i].photos?.length ?? 0); j++) {
          album.pages?[i].photos?[j].imageCrop = [];
          album.pages?[i].photos?[j].path = '';
        }
      }
      await f.writeAsString(json.encode(album));
      await callApiCreateImage(res, f, name: 'json_file.json');
      loadUpload = LoadStatus.success;
      loadStatus = LoadStatus.success;
      update();
      listenCallGoc.add(false);
      listenDialog.add(true);
    }
  }

  Future<String?> callApiCreateImage(CreateOderRes? res, File file, {String? name}) async {
    final result = await homeService.createImage(
        formData: form.FormData.fromMap({
      'Policy': res?.s3Info?.policy,
      'key': name == null ? '${res?.s3Info?.key}screen_shoot$page' : '${res?.s3Info?.key}$name',
      'Signature': res?.s3Info?.signature,
      'filename': name != null ? '$name' : '/screen_shoot$page',
      'acl': res?.s3Info?.acl,
      'Content-Type': res?.s3Info?.contentType,
      'AWSAccessKeyId': res?.s3Info?.aWSAccessKeyId,
      "file": await form.MultipartFile.fromFile(file.path),
    }));

    return result;
  }

  Future<String?> callApiCreateImageGoc(
      CreateOderRes? res, File file, int indexPar, int index) async {
    final result = await homeService.createImage(
        formData: form.FormData.fromMap({
      'Policy': res?.s3Info?.policy,
      'key': '${res?.s3Info?.key}screen${indexPar}image$index',
      'Signature': res?.s3Info?.signature,
      'filename': '/screen${indexPar}image$index',
      'acl': res?.s3Info?.acl,
      'Content-Type': res?.s3Info?.contentType,
      'AWSAccessKeyId': res?.s3Info?.aWSAccessKeyId,
      "file": await form.MultipartFile.fromFile(file.path),
    }));

    return result;
  }

  void showDialogSuccess(BuildContext context) {
    loadStatus = LoadStatus.success;
    update();
    AppDialog.messages(
      message: 'Tạo đơn hàng thành công, quay lại trang chủ!',
      onTapOk: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }
}

class FileInfo {
  File file;
  int indexParent;
  int index;

  FileInfo(this.file, this.indexParent, this.index);
}

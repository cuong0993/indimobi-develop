import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/utils/logger.dart';

class HiveData extends GetxService {
  Future<HiveData> init() async {
    return this;
  }

  /// key hive
  static const String keyAlbum = 'key_albums';
  static const String keyAddress = 'key_address';

  Future<void> addProject(List<AlbumEntity> projects) async {
    var box = await Hive.openBox(keyAlbum);
    box.put(keyAlbum, projects);
  }

  Future<void> addProjectDeep(List<AlbumEntity> projects) async {
    var box = await Hive.openBox(keyAlbum);
    box.put(keyAlbum, projects);
  }

  Future<List<AlbumEntity>?> getProjects() async {
    try {
      final box = await Hive.openBox(keyAlbum);
      List<dynamic>? list = [];
      list = await box.get(keyAlbum);
      List<AlbumEntity>? listA = List<AlbumEntity>.from(list ?? []);
      return listA;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<List<AlbumEntity>?> getProjectsDeep() async {
    try {
      final box = await Hive.openBox(keyAlbum);
      List<dynamic>? list = [];
      list = await box.get(keyAlbum);
      List<AlbumEntity>? listA = List<AlbumEntity>.from(list ?? []);
      return listA;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<void> addAddress(List<AddressEntity> address) async {
    var box = await Hive.openBox(keyAddress);
    box.put(keyAddress, address);
  }

  Future<List<AddressEntity>> getAddress() async {
    try {
      final box = await Hive.openBox(keyAddress);
      List<dynamic>? list = await box.get(keyAddress);
      List<AddressEntity>? address = list?.cast<AddressEntity>();
      return address ?? [];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

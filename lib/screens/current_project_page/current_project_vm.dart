import 'package:get/get.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/utils/logger.dart';

class CurrentProjectVm extends GetxController {
  List<AlbumEntity> listProject = [];
  HiveData hiveData = Get.find();

  void initData() async {
    try {
      listProject = await hiveData.getProjects() ?? [];
      update();
    } catch (e) {
      logger.e(e);
    }
  }
}

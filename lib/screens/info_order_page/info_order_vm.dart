import 'package:get/get.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/order_detail_res.dart';
import 'package:indimobi/services/home_service.dart';
import 'package:indimobi/utils/logger.dart';

class InfoOrderVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  HomeService homeService = Get.find();
  OrderDetailRes? order;

  Future<void> getDetailOrder(String id) async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      final res = await homeService.getDetailOder(id: id);
      if (res != null) {
        order = res;
        loadStatus = LoadStatus.success;
        update();
      } else {
        loadStatus = LoadStatus.success;
        update();
      }
    } catch (e) {
      logger.e(e);
      loadStatus = LoadStatus.failure;
      update();
    }
  }
}

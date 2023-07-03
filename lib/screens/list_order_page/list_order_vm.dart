import 'package:get/get.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/order_res.dart';
import 'package:indimobi/services/home_service.dart';
import 'package:indimobi/utils/logger.dart';

class ListOrderVm extends GetxController {
  LoadStatus loadStatus = LoadStatus.initial;
  HomeService homeService = Get.find();
  SharedPref sharedPref = Get.find();

  List<Orders> listOrder = [];

  Future<void> getListOrder() async {
    try {
      loadStatus = LoadStatus.loading;
      update();
      String phone = await sharedPref.getPhone() ?? '';
      final res = await homeService.getListOrder(phone: phone);
      if (res != null) {
        listOrder = res;
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

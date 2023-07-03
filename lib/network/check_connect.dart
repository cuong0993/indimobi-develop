import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:indimobi/app_ctrl.dart';

/// check connect internet
class CheckConnect {
  static Future<bool> checkConnect() async {
    final connectResult = await Connectivity().checkConnectivity();
    if (connectResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

class ConnectivityService extends GetxService {
  AppCtrl controller = Get.find();

  @override
  void onInit() async {
    super.onInit();
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      controller.showDialogE('Mất kết nối vui lòng kiểm tra lại!');
    }

    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        controller.showDialogE('Mất kết nối vui lòng kiểm tra lại!');
      }
    });
  }
}

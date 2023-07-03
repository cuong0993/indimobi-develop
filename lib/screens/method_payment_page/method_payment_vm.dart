import 'package:get/get.dart';

class MethodPaymentVm extends GetxController {
  bool isCod = true;

  void updateMethod(bool isPayCod) {
    isCod = isPayCod;
    update();
  }
}

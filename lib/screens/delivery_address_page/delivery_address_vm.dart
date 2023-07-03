import 'package:get/get.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/method_payment_page/method_payment_page.dart';
import 'package:indimobi/screens/new_address_page/new_address_page.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class DeliveryAddressVm extends GetxController {
  HiveData hiveData = Get.find();
  List<AddressEntity> address = [];
  LoadStatus loadStatus = LoadStatus.initial;
  int indexSelect = -1;

  void initData() async {
    address = await hiveData.getAddress();
    print("address.toString()");
    print(address.toString());
    update();
  }

  void selectItem(int index) async {
    indexSelect = index;
    update();
  }

  void deleteItem(int index) async {
    if (loadStatus != LoadStatus.loading) {
      loadStatus = LoadStatus.loading;
      update();
      if (indexSelect == index) {
        indexSelect = -1;
      }
      address.removeAt(index);
      await hiveData.addAddress(address).then((value) {
        loadStatus = LoadStatus.success;
        update();
      });
    }
  }

  void navigateNewAdd() {
    Get.to(
      () => NewAddressPage(address: address),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 250),
    )?.then(
      (value) {
        initData();
      },
    );
  }

  void navigateDeliver() {
    if (indexSelect != -1) {
      Get.to(
        () => MethodPayPage(address: address[indexSelect]),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 250),
      );
    } else {
      AppDialog.messages(message: 'Vui lòng chọn một địa chỉ!');
    }
  }
}

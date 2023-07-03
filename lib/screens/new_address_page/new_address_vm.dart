import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/method_payment_page/method_payment_page.dart';
import 'package:indimobi/utils/validate.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class NewAddressVm extends GetxController {
  HiveData hiveData = Get.find();
  LoadStatus loadStatus = LoadStatus.initial;
  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlPhone = TextEditingController();
  TextEditingController ctrlAddress = TextEditingController();
  TextEditingController ctrlTP = TextEditingController();
  TextEditingController ctrlQH = TextEditingController();
  TextEditingController ctrlPX = TextEditingController();
  TextEditingController ctrlNote = TextEditingController();
  SharedPref sharedPref = Get.find();

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPhone.dispose();
    ctrlAddress.dispose();
    ctrlTP.dispose();
    ctrlQH.dispose();
    ctrlPX.dispose();
    ctrlNote.dispose();
    super.dispose();
  }

  void initData() async {
    ctrlPhone.text = await sharedPref.getPhone() ?? '';
  }

  void addAddress({
    required List<AddressEntity> listAddress,
  }) async {
    if (loadStatus != LoadStatus.loading) {
      loadStatus = LoadStatus.loading;
      update();
      AddressEntity address = AddressEntity(
        name: ctrlName.text.trim(),
        phone: ctrlPhone.text.trim(),
        address: ctrlAddress.text.trim(),
        city: ctrlTP.text.trim(),
        district: ctrlQH.text.trim(),
        commune: ctrlPX.text.trim(),
        note: ctrlNote.text.trim(),
      );
      String validate = ValidateString.validateAddress(addressEntity: address);
      if (validate == '') {
        listAddress.add(address);
        await hiveData.addAddress(listAddress).then((value) {
          loadStatus = LoadStatus.success;
          update();
        });
        Get.to(
          () => MethodPayPage(address: address),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 250),
        );
      } else {
        loadStatus = LoadStatus.failure;
        update();
        AppDialog.messages(message: validate);
      }
    }
  }
}

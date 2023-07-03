import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IcBackGreenCpn extends StatelessWidget {
  final Color? colorIconBack;

  IcBackGreenCpn({this.colorIconBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.transparent,
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 20,
          color: colorIconBack ?? Colors.green,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IcBackCpn extends StatelessWidget {
  final Color? colorIconBack;
  final VoidCallback? onPressBack;

  IcBackCpn({this.colorIconBack, this.onPressBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onPressBack != null ? onPressBack?.call() : Get.back();
      },
      child: Container(
        padding: const EdgeInsets.only(right: 12),
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

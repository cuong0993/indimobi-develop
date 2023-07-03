import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/add_content_page/add_content_vm.dart';

class TextFieldWidget extends StatelessWidget {
  final bool isCover;

  TextFieldWidget(this.isCover);

  final AddContentVm vm = Get.find<AddContentVm>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddContentVm>(builder: (logic) {
      return TextField(
        autofocus: true,
        controller: vm.controller,
        minLines: 1,
        maxLines: 2,
        textAlign: logic.textAlign,
        focusNode: vm.focusNode,
        style: AppTextStyle.textSize_10.copyWith(
          fontSize: vm.getTextSize() + 10,
          fontFamily: logic.fontFa,
        ),
        cursorWidth: 1.2,
        maxLength: 150,
        onChanged: (text) {
          vm.updateContent(text);
        },
        decoration: InputDecoration(
          isDense: true,
          fillColor: isCover == true ? Colors.white : AppColors.colorItemOder,
          alignLabelWithHint: false,
          filled: true,
          counterText: '',
          contentPadding: EdgeInsets.only(top: 5, bottom: 7, left: 7, right: 7),
          border: InputBorder.none,
        ),
      );
    });
  }
}

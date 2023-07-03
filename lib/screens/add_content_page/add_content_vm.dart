import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_constants.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';

class AddContentVm extends GetxController {
  IconData align = Icons.align_horizontal_left;
  TextAlign textAlign = TextAlign.left;
  String fontFa = AppConst.fontKeyMedium;
  String fontSi = '60.0pt';
  List<String> fontSizes = [];
  TextEditingController controller = TextEditingController();
  List<TextsEntity> listText = [];
  TextsEntity currentText =
      TextsEntity(idLocal: DateTime.now().millisecondsSinceEpoch.toString());
  FocusNode focusNode = FocusNode();
  List<String> fontFamily = [
    AppConst.fontKeyMedium,
    AppConst.fontKeyMediumItalic,
    AppConst.fontKeyRegular,
    AppConst.fontKeySemiBold,
    AppConst.fontKeySemiBoldItalic,
    AppConst.fontKeyVariableFont,
    AppConst.fontKeyItalic,
    AppConst.fontKeyItalicVariableFont,
    AppConst.fontKeyLight,
    AppConst.fontKeyLightItalic,
    AppConst.fontKeyBlack,
    AppConst.fontKeyBlackItalic,
    AppConst.fontKeyBold,
    AppConst.fontKeyBoldItalic,
    AppConst.fontKeyExtraBold,
    AppConst.fontKeyExtraBoldItalic,
    AppConst.fontKeyExtraLight,
    AppConst.fontKeyExtraLightItalic,
  ];
  List<IconData> icons = [
    Icons.align_horizontal_left,
    Icons.align_horizontal_center,
    Icons.align_horizontal_right,
  ];
  int indexCover = -1;
  final CustomPopupMenuController ctrlMenuFont = CustomPopupMenuController();
  final CustomPopupMenuController ctrlMenuSize = CustomPopupMenuController();
  final CustomPopupMenuController ctrlMenuAlign = CustomPopupMenuController();

  void initData(PagesEntity page) {
    if (page.isEditCover == true) {
      indexCover = coverLayouts.indexOf(page.layout ?? '');
    }
    listText = page.texts ?? [];
    if (listText.isNotEmpty) {
      currentText = listText.first;
      updateText(listText.first);
    } else {
      currentText = TextsEntity(
          idLocal: DateTime.now().millisecondsSinceEpoch.toString());
      listText.add(currentText);
      updateText(currentText);
    }
  }

  void updateFontFamily(String text) {
    currentText = currentText.copyWith(font: text);
    listText
        .firstWhere((element) => element.idLocal == currentText.idLocal)
        .font = text;
    updateText(currentText);
  }

  void onChangeText(int index) {
    currentText = listText[index];
    updateText(currentText);
  }

  void updateContent(String text) {
    currentText = currentText.copyWith(content: text);
    listText
        .firstWhere((element) => element.idLocal == currentText.idLocal)
        .content = text;
  }

  void updateText(TextsEntity text) {
    controller.text = text.content ?? '';
    fontFa = text.font ?? AppConst.fontKeyMedium;
    fontSi = '${(text.size ?? 6) * 10}pt';
    updateFontSize(fontSi);
    getAlign(text.textAlign ?? '');
    update();
  }

  void updateAlign(IconData icon) {
    align = icon;
    if (align == icons[1]) {
      textAlign = TextAlign.center;
    } else if (align == icons[0]) {
      textAlign = TextAlign.left;
    } else {
      textAlign = TextAlign.right;
    }

    currentText = currentText.copyWith(textAlign: textAlign.toString());
    listText
        .firstWhere((element) => element.idLocal == currentText.idLocal)
        .textAlign = textAlign.toString();
    update();
  }

  void updateFontSize(String text) {
    fontSi = text;
    double temp = double.parse(fontSi.split('pt')[0]);
    fontSizes = [];
    for (int i = 0; i <= 10; i++) {
      fontSizes.add('${temp - 5 + i}pt');
    }
    currentText = currentText.copyWith(size: getTextSize());
    listText
        .firstWhere((element) => element.idLocal == currentText.idLocal)
        .size = getTextSize();
    update();
  }

  double getTextSize() {
    return double.parse(fontSi.split('pt')[0]) / 10;
  }

  void getAlign(String text) {
    if (text == TextAlign.left.toString()) {
      updateAlign(icons[0]);
    } else if (text == TextAlign.right.toString()) {
      updateAlign(icons[2]);
    } else if (text == TextAlign.center.toString()) {
      updateAlign(icons[1]);
    } else {
      updateAlign(icons[0]);
    }
  }
}

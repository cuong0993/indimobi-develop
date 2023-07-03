import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';
import 'package:indimobi/utils/function_utils.dart';

class ItemTextCover extends StatelessWidget {
  final List<TextsEntity> texts;
  final int index;
  final double width;
  final double height;
  final bool isGrid;
  final bool isEditText;
  final Function(int index)? onChange;

  ItemTextCover({
    required this.texts,
    required this.index,
    this.width = 1,
    this.height = 1,
    this.onChange,
    this.isGrid = false,
    this.isEditText = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      buildType1(),
      buildType2(),
      buildType3(),
      buildType4(),
      buildType5(),
      buildType6(),
      buildType7(),
      buildType8(),
      buildType9(),
      buildType10(),
      buildType11(),
      buildType12(),
      buildType13(),
      buildType14(),
      buildType15(),
      buildType16(),
      buildType17(),
      buildType18(),
      buildType19(),
      buildType20(),
      buildType21(),
      buildType22(),
    ];
    return listWidget[index];
  }

  Widget buildType1() {
    return Container(
      margin: EdgeInsets.only(right: width * 0.05, top: 10),
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width * 0.3,
        height: width * 0.3,
        child: buildText(0, Colors.white),
      ),
    );
  }

  Widget buildType2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.04),
        SizedBox(
          width: width * 0.5,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.1),
      ],
    );
  }

  Widget buildType3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: height * 0.02),
        SizedBox(
          width: width * 0.65,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.1),
        SizedBox(
          width: width * 0.65,
          child: buildText(1, Colors.black),
        ),
        Spacer(),
        SizedBox(
          width: width * 0.65,
          child: buildText(2, Colors.black),
        ),
        SizedBox(height: height * 0.01),
      ],
    );
  }

  Widget buildType4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: height * 0.06),
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.05),
        SizedBox(
          width: width * 0.5,
          child: buildText(1, Colors.black),
        ),
        Spacer(),
        SizedBox(
          width: width * 0.5,
          child: buildText(2, Colors.black),
        ),
        SizedBox(height: height * 0.16),
      ],
    );
  }

  Widget buildType5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.13),
        SizedBox(
          width: width * 0.25,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.05),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.05),
        SizedBox(
          width: width * 0.25,
          child: buildText(2, Colors.black),
        ),
      ],
    );
  }

  Widget buildType6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.09),
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.015),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.black),
        ),
      ],
    );
  }

  Widget buildType7() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.35,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.025),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.22),
      ],
    );
  }

  Widget buildType8() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.4),
        SizedBox(
          width: width * 0.4,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.08),
        SizedBox(
          width: width * 0.22,
          child: buildText(1, Colors.black),
        ),
      ],
    );
  }

  Widget buildType9() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.4,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.01),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.14),
      ],
    );
  }

  Widget buildType10() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.2),
      ],
    );
  }

  Widget buildType11() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.4,
          child: Padding(
            padding: EdgeInsets.only(right: width * 0.07),
            child: buildText(0, Colors.white),
          ),
        ),
        SizedBox(height: height * 0.15),
      ],
    );
  }

  Widget buildType12() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.white),
        ),
        SizedBox(height: height * 0.18),
      ],
    );
  }

  Widget buildType13() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.white),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(
          width: width * 0.5,
          child: buildText(1, Colors.white),
        ),
        SizedBox(height: height * 0.16),
      ],
    );
  }

  Widget buildType14() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(
          width: width * 0.5,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.2),
      ],
    );
  }

  Widget buildType15() {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: width * 0.3,
            child: buildText(0, Colors.black),
          ),
          SizedBox(height: height * 0.08),
          SizedBox(
            width: width * 0.2,
            child: buildText(1, Colors.black),
          ),
          SizedBox(height: height * 0.18),
        ],
      ),
    );
  }

  Widget buildType16() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.white),
        ),
        SizedBox(height: height * 0.04),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.white),
        ),
        SizedBox(height: height * 0.15),
      ],
    );
  }

  Widget buildType17() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.white),
        ),
        SizedBox(height: height * 0.25),
      ],
    );
  }

  Widget buildType18() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.22),
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.white),
        ),
        SizedBox(height: height * 0.04),
        SizedBox(
          width: width * 0.25,
          child: buildText(1, Colors.white),
        ),
      ],
    );
  }

  Widget buildType19() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: height * 0.09),
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.03),
        SizedBox(
          width: width * 0.3,
          child: buildText(1, Colors.black),
        ),
        Spacer(),
        SizedBox(
          width: width * 0.65,
          child: buildText(2, Colors.black),
        ),
        SizedBox(height: height * 0.08),
      ],
    );
  }

  Widget buildType20() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.5,
          child: buildText(0, Colors.black),
        ),
      ],
    );
  }

  Widget buildType21() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.28,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.2),
      ],
    );
  }

  Widget buildType22() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.35,
          child: buildText(0, Colors.black),
        ),
        SizedBox(height: height * 0.015),
        SizedBox(
          width: width * 0.35,
          child: buildText(1, Colors.black),
        ),
        SizedBox(height: height * 0.28),
      ],
    );
  }

  Widget buildText(int index, Color color) {
    String? text = (texts[index].content != null && texts[index].content != '')
        ? texts[index].content
        : (isEditText == true ? 'Nhấn để sửa' : '');

    double size = texts[index].size?.toDouble() ?? 3;

    return (isEditText == true && isGrid == false)
        ? GestureDetector(
            onTap: () {
              onChange?.call(index);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Text(
                text ?? '',
                style: AppTextStyle.textBoldWhiteSize_10.copyWith(
                  color: color,
                  fontSize: size,
                  fontFamily: texts[index].font,
                ),
                textAlign:
                    FunctionUtil.getTextAlign(texts[index].textAlign ?? ''),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          )
        : Text(
            text ?? '',
            style: AppTextStyle.textBoldWhiteSize_10.copyWith(
              color: color,
              fontSize: isGrid == true ? (size - 4) : size,
              fontFamily: texts[index].font,
            ),
            textAlign: FunctionUtil.getTextAlign(texts[index].textAlign ?? ''),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          );
  }
}

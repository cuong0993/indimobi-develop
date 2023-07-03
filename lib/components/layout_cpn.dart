import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';

class LayoutCpn extends StatefulWidget {
  final PagesEntity pagesEntity;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final bool? isView;

  LayoutCpn({
    required this.pagesEntity,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.isView = false,
  });

  @override
  State<LayoutCpn> createState() => LayoutCpnState();
}

class LayoutCpnState extends State<LayoutCpn>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getLayout();
  }

  Widget buildType1() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.colorLayout,
      child: checkViewImage(0, image: widget.image1),
    );
  }

  Widget checkViewImage(int id, {String? image}) {
    if (image != null && image.isNotEmpty) {
      List<int>? imageInt;

      int length = widget.pagesEntity.photos?.length ?? 0;
      //  List<PhotosEntity> photos = widget.pagesEntity.photos ?? [];

      // for (int i = 0; i < length; i++) {
      //   if (photos[i].index == id) {
      //     imageInt = photos[i].bytesList;
      //   }
      // }

      if (imageInt != null) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.memory(
            Uint8List.fromList(
              imageInt,
            ),
            fit: BoxFit.cover,
          ),
        );
      } else {
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.file(
            File(image),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      if (widget.isView == true) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        );
      } else {
        return Center(
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 20,
            color: AppColors.buttonColorGrey,
          ),
        );
      }
    }
  }

  Widget buildType2() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: AppColors.colorLayout,
            child: checkViewImage(0, image: widget.image1),
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType3() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType4() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(0, image: widget.image1),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(1, image: widget.image2),
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: Get.width * 0.4,
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  height: Get.width * 0.4,
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        buildText(),
      ],
    );
  }

  Widget buildType6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: Get.width * 0.4,
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: Get.width * 0.4,
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        buildText(),
      ],
    );
  }

  Widget buildType7() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: Get.width * 0.3,
                margin: EdgeInsets.only(right: 0.3),
                color: AppColors.colorLayout,
                child: checkViewImage(0, image: widget.image1),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: Get.width * 0.3,
                margin: EdgeInsets.only(left: 0.3),
                color: AppColors.colorLayout,
                child: checkViewImage(1, image: widget.image2),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        buildText(),
      ],
    );
  }

  Widget buildType8() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(2, image: widget.image3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType9() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.3, right: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(0, image: widget.image1),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.3, right: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType10() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(0, image: widget.image1),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType11() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(2, image: widget.image3),
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType12() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(bottom: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(0, image: widget.image1),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType13() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.3, right: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(0, image: widget.image1),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.3, right: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType14() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: Get.width * 0.35,
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: Get.width * 0.35,
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: Get.width * 0.35,
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        buildText(),
      ],
    );
  }

  Widget buildType15() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(2, image: widget.image3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType16() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(bottom: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(0, image: widget.image1),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType17() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType18() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(3, image: widget.image4),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType19() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(3, image: widget.image4),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType20() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3, left: 0.3, right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3, left: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 0.3),
            color: AppColors.colorLayout,
            child: checkViewImage(3, image: widget.image4),
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType21() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 0.3, left: 0.3, top: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(2, image: widget.image3),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.3, left: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(3, image: widget.image4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType22() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(3, image: widget.image4),
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType23() {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(0, image: widget.image1),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, bottom: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(1, image: widget.image2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(2, image: widget.image3),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.3, top: 0.3),
                  color: AppColors.colorLayout,
                  child: checkViewImage(3, image: widget.image4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        buildText(),
      ],
    );
  }

  Widget buildType24() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 0.3, bottom: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(0, image: widget.image1),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(right: 0.3, top: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(1, image: widget.image2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(left: 0.3, bottom: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(2, image: widget.image3),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(left: 0.3, top: 0.3),
                        color: AppColors.colorLayout,
                        child: checkViewImage(3, image: widget.image4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildText(),
      ],
    );
  }

  Widget buildType25() {
    return buildType2();
  }

  Widget buildText() {
    if (widget.pagesEntity.texts != null &&
        widget.pagesEntity.texts?.length != 0) {
      return Container(
          padding: const EdgeInsets.only(top: 3),
          width: double.infinity,
          child: Text(
            widget.pagesEntity.texts?.first.content ?? '',
            maxLines: 3,
            // textAlign: FunctionUtil.getTextAlign(
            //     widget.pagesEntity.texts?.first.textAlign ?? ''),
            style: AppTextStyle.textSize_8.copyWith(
              fontSize:
                  (widget.pagesEntity.texts?.first.size?.toDouble() ?? 5) - 2,
              fontFamily: widget.pagesEntity.texts?.first.font,
            ),
            overflow: TextOverflow.ellipsis,
          ));
    } else {
      return SizedBox();
    }
  }

  Widget getLayout() {
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
      buildType23(),
      buildType24(),
      buildType25(),
    ];
    return listWidget[1];
    //  return listWidget[pageTypeLayouts.indexOf(widget.pagesEntity.layout ?? '')];
  }

  @override
  bool get wantKeepAlive => true;
}

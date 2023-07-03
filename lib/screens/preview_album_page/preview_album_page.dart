import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/screens/preview_album_page/preview_album_vm.dart';
import 'package:indimobi/screens/preview_album_page/widgets/app_bar_widget.dart';

class PreviewAlbumPage extends StatefulWidget {
  final AlbumEntity albumEntity;

  PreviewAlbumPage({required this.albumEntity});

  @override
  State<PreviewAlbumPage> createState() => PreviewAlbumPageState();
}

class PreviewAlbumPageState extends State<PreviewAlbumPage> with TickerProviderStateMixin {
  PreviewAlbumVm vm = Get.put<PreviewAlbumVm>(PreviewAlbumVm());

  int index = 0;
  bool isLeft = true;

  late AnimationController ctrlSlide;
  late AnimationController ctrlFlipLeft;
  late AnimationController ctrlFlipRight;
  late Animation aniSlide;
  late Animation aniFlip;
  late Animation aniFlipLeft;
  late Animation aniFlipRight;

  @override
  void initState() {
    super.initState();
    vm.initListPage(widget.albumEntity);

    ctrlSlide = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    ctrlFlipLeft = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    ctrlFlipRight = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    aniSlide = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(Get.width * 0.25 - 6, 0),
    ).animate(
      CurvedAnimation(parent: ctrlSlide, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    aniFlip = Tween(begin: 0.0, end: 1.0).animate(ctrlSlide)
      ..addListener(() {
        setState(() {});
      });
    aniFlipLeft = Tween(begin: 1.0, end: 0.0).animate(ctrlFlipLeft)
      ..addListener(() {
        setState(() {});
        if (aniFlipLeft.isCompleted) {
          vm.updateUiLeft();
        }
      });
    aniFlipRight = Tween(begin: 0.0, end: 1.0).animate(ctrlFlipRight)
      ..addListener(() {
        setState(() {});
        if (aniFlipRight.isCompleted) {
          vm.updateUiRight();
        }
      });
  }

  @override
  void dispose() {
    vm.dispose();
    ctrlFlipLeft.dispose();
    ctrlSlide.dispose();
    ctrlFlipRight.dispose();
    Get.delete<PreviewAlbumVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.imgBgr,
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Center(
            child: Stack(
              children: [
                buildFirstPage(),
                buildPlace(),
                buildFlipLeft(),
                buildFlipRight(),
              ],
            ),
          ),
          AppBarWidget(),
        ],
      ),
    );
  }

  Widget buildFlipLeft() {
    return Visibility(
      visible: (aniFlipLeft.value != 1 && aniFlipLeft.value != 0),
      child: GetBuilder<PreviewAlbumVm>(
        builder: (logic) {
          return Align(
            alignment: Alignment.centerRight,
            child: Transform(
              alignment: FractionalOffset.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * aniFlipLeft.value),
              child: buildFlip(
                child: aniFlipLeft.value > 0.5
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: logic.widgetFront,
                      )
                    : logic.widgetBack,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFlipRight() {
    return Visibility(
      visible: (aniFlipRight.value != 1 && aniFlipRight.value != 0),
      child: GetBuilder<PreviewAlbumVm>(
        builder: (logic) {
          return Align(
            alignment: Alignment.centerRight,
            child: Transform(
              alignment: FractionalOffset.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * aniFlipRight.value),
              child: buildFlip(
                child: aniFlipRight.value > 0.5
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: logic.widgetBack,
                      )
                    : logic.widgetFront,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPlace() {
    return Center(
      child: aniFlip.value == 1
          ? Container(
              height: Get.width * 0.5 - 24,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: GetBuilder<PreviewAlbumVm>(
                      builder: (logic) {
                        return GestureDetector(
                          onHorizontalDragStart: (detail) {
                            if ((aniFlipRight.value == 0 || aniFlipRight.value == 1) &&
                                (aniFlipLeft.value == 0 || aniFlipLeft.value == 1)) {
                              if (logic.indexTemp < 1) {
                                ctrlSlide.reverse();
                              } else {
                                vm.clickLeft();
                                ctrlFlipLeft.reset();
                                ctrlFlipLeft.forward();
                              }
                            }
                          },
                          onTap: () {
                            if ((aniFlipRight.value == 0 || aniFlipRight.value == 1) &&
                                (aniFlipLeft.value == 0 || aniFlipLeft.value == 1)) {
                              if (logic.indexTemp < 1) {
                                ctrlSlide.reverse();
                              } else {
                                vm.clickLeft();
                                ctrlFlipLeft.reset();
                                ctrlFlipLeft.forward();
                              }
                            }
                          },
                          child: logic.widgetLeft,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<PreviewAlbumVm>(
                      builder: (logic) {
                        return GestureDetector(
                          onHorizontalDragStart: (detail) {
                            if ((logic.indexTemp < (logic.listWidgetR.length - 1)) &&
                                (aniFlipRight.value == 0 || aniFlipRight.value == 1) &&
                                (aniFlipLeft.value == 0 || aniFlipLeft.value == 1)) {
                              vm.clickRight();
                              ctrlFlipRight.reset();
                              ctrlFlipRight.forward();
                            }
                          },
                          onTap: () {
                            if ((logic.indexTemp < (logic.listWidgetR.length - 1)) &&
                                (aniFlipRight.value == 0 || aniFlipRight.value == 1) &&
                                (aniFlipLeft.value == 0 || aniFlipLeft.value == 1)) {
                              vm.clickRight();
                              ctrlFlipRight.reset();
                              ctrlFlipRight.forward();
                            }
                          },
                          child: logic.widgetRight,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget buildFirstPage() {
    return Center(
      child: Transform.translate(
        offset: aniSlide.value,
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildContainer(
              child: aniFlip.value > 0
                  ? GetBuilder<PreviewAlbumVm>(
                      builder: (logic) {
                        return logic.listWidgetR[0];
                      },
                    )
                  : SizedBox(),
            ),
            buildPageCover(),
          ],
        ),
      ),
    );
  }

  Widget buildPageCover() {
    return buildContainer(
      child: Transform(
        alignment: FractionalOffset.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(pi * aniFlip.value),
        child: GestureDetector(
          onHorizontalDragStart: (detail) {
            ctrlSlide.forward();
            vm.initUi();
          },
          onTap: () {
            ctrlSlide.forward();
            vm.initUi();
          },
          child: aniFlip.value > 0.5
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: GetBuilder<PreviewAlbumVm>(builder: (logic) {
                    return logic.listWidgetL[0];
                  }),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    LayoutWidget(
                      isView: true,
                      isGrid: true,
                      isEditEmoji: false,
                      pagesEntity: widget.albumEntity.cover ?? PagesEntity(),
                    ),
                    Container(
                      color: Colors.transparent,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildItemGrid({
    PagesEntity? page,
  }) {
    return LayoutWidget(
      isView: true,
      isGrid: true,
      isEditEmoji: false,
      pagesEntity: page ?? PagesEntity(),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      height: Get.width * 0.5 - 24,
      width: Get.width * 0.5 - 12,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: child,
    );
  }

  Widget buildFlip({required Widget child}) {
    return Container(
      height: Get.width * 0.5 - 24,
      width: Get.width * 0.5 - 12,
      margin: EdgeInsets.only(right: 12),
      child: child,
    );
  }
}

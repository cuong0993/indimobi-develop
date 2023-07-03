import 'dart:math' as math;

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';

class DRSWidget extends StatefulWidget {
  final bool isSelect;
  final String? id;
  final String? nameImage;
  final bool isEdit;
  final bool isGrid;
  final Function? onDelete;
  final Function(String)? onSelect;
  final Function(Offset, double, double, bool)? onUpdate;
  final StickersEntity? stickers;

  DRSWidget({
    Key? key,
    required this.nameImage,
    this.onDelete,
    this.onSelect,
    this.onUpdate,
    this.id,
    this.stickers,
    this.isSelect = false,
    this.isGrid = false,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<DRSWidget> createState() => DRSWidgetState();
}

class DRSWidgetState extends State<DRSWidget> {
  Offset offset = Offset(Get.width * 0.41 - 60, Get.width * 0.41 - 60);
  double initialScale = 1.0;
  double scaleFactor = 1.0;
  double rotation = 0.0;
  double iRotation = 0.0;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  FlipCardController flipController = FlipCardController();

  @override
  void initState() {
    super.initState();

    if (widget.stickers != null) {
      rotation = widget.stickers?.angle ?? 0.0;
      if (widget.isGrid) {
        scaleFactor = ((widget.stickers?.width ?? 42) / 42) * 0.5;
        offset = Offset(
          (widget.stickers?.centerX ?? (Get.width * 0.41 - 60)) * 0.5 - 20,
          (widget.stickers?.centerY ?? (Get.width * 0.41 - 60)) * 0.5 - 20,
        );
      } else {
        scaleFactor = (widget.stickers?.width ?? 42) / 42;
        offset = Offset(
          widget.stickers?.centerX ?? (Get.width * 0.41 - 60),
          widget.stickers?.centerY ?? (Get.width * 0.41 - 60),
        );
      }
      if (widget.stickers?.isFlip == true) {
        flipController.state?.isFront = false;
      }
    }
  }

  @override
  void didUpdateWidget(covariant DRSWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.stickers != oldWidget.stickers) {
      if (widget.stickers != null) {
        rotation = widget.stickers?.angle ?? 0.0;
        if (widget.isGrid) {
          scaleFactor = ((widget.stickers?.width ?? 42) / 42) * 0.5;
          offset = Offset(
            (widget.stickers?.centerX ?? (Get.width * 0.41 - 60)) * 0.5 - 20,
            (widget.stickers?.centerY ?? (Get.width * 0.41 - 60)) * 0.5 - 20,
          );
        } else {
          scaleFactor = (widget.stickers?.width ?? 42) / 42;
          offset = Offset(
            widget.stickers?.centerX ?? (Get.width * 0.41 - 60),
            widget.stickers?.centerY ?? (Get.width * 0.41 - 60),
          );
        }
        if (widget.stickers?.isFlip == true) {
          flipController.state?.isFront = false;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onScaleStart: (_) {
          if (widget.isEdit) {
            widget.onSelect?.call(widget.id ?? '');
            if (widget.id != '') {
              initialScale = scaleFactor;
              iRotation = rotation;
            }
          }
        },
        onScaleUpdate: (details) {
          if (widget.isEdit) {
            if (widget.id != '') {
              offset += details.focalPointDelta;

              scaleFactor = initialScale * details.scale;
              rotation = iRotation + details.rotation;

              widget.onUpdate?.call(
                offset,
                scaleFactor <= 4 ? scaleFactor : 4.0,
                rotation,
                flipController.state?.isFront == false,
              );
            }
          }
        },
        child: Stack(
          children: [
            FlipCard(
              key: cardKey,
              controller: flipController,
              flipOnTouch: false,
              front: buildItem(),
              back: buildItem(isFront: false),
            ),
            widget.isSelect == true ? btnFlip() : SizedBox(),
            widget.isSelect == true ? bntCancel() : SizedBox(),
            widget.isSelect == true ? bntZoom() : SizedBox(),
            widget.isSelect == true ? bntZoomS() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget bntZoom() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          if (widget.isEdit) {
            if (widget.id != '' && scaleFactor <= 4 && scaleFactor > 0.4) {
              scaleFactor = scaleFactor + 0.2;
              widget.onUpdate?.call(
                offset,
                scaleFactor,
                rotation,
                flipController.state?.isFront == false,
              );
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(
            Icons.add_circle_outlined,
            color: AppColors.colorButtonGreen,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget bntZoomS() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          if (widget.isEdit) {
            if (widget.id != '' && scaleFactor <= 4 && scaleFactor > 0.6) {
              scaleFactor = scaleFactor - 0.1;
              widget.onUpdate?.call(
                offset,
                scaleFactor,
                rotation,
                flipController.state?.isFront == false,
              );
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(
            Icons.remove_circle_outlined,
            color: AppColors.colorButtonGreen,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget bntCancel() {
    return Positioned(
      left: 0,
      top: 0,
      child: InkWell(
        onTap: () {
          flipController.toggleCard();
        },
        child: Container(
          height: 20,
          width: 20,
          color: Colors.transparent,
          child: Image.asset(AppImages.icFlip, height: 20, width: 20),
        ),
      ),
    );
  }

  Widget btnFlip() {
    return Positioned(
      right: 0,
      top: 0,
      child: InkWell(
        onTap: () {
          widget.onDelete?.call();
        },
        child: Icon(Icons.cancel, size: 20, color: Colors.red),
      ),
    );
  }

  Widget buildItem({bool isFront = true}) {
    double padding = (((widget.stickers?.width ?? 1) * scaleFactor) / 10);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: widget.isSelect == true ? Colors.black87 : Colors.transparent,
          width: 0.4,
        ),
      ),
      child: Transform.rotate(
        alignment: FractionalOffset.center,
        angle: rotation,
        child: Transform.scale(
          alignment: FractionalOffset.center,
          scale: scaleFactor,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isFront ? 0 : math.pi),
            child: widget.nameImage?.isNotEmpty == true
                ? Image.asset(
                    widget.nameImage ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}

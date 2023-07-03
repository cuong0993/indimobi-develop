import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:indimobi/packages/crop_image/crop_grid.dart';
import 'package:indimobi/packages/crop_image/crop_rect.dart';
import 'package:indimobi/packages/crop_image/crop_rotation.dart';

import 'crop_controller.dart';

class CropImage extends StatefulWidget {
  final CropController? controller;

  final Image image;

  final Color gridColor;

  final double paddingSize;

  final double touchSize;

  final double gridCornerSize;

  final double gridThinWidth;

  final double gridThickWidth;

  final Color scrimColor;

  final bool alwaysShowThirdLines;

  final ValueChanged<Rect>? onCrop;

  final double minimumImageSize;
  final bool alwaysMove;

  const CropImage({
    Key? key,
    this.controller,
    required this.image,
    this.gridColor = Colors.white70,
    this.paddingSize = 0,
    this.touchSize = 45,
    this.gridCornerSize = 25,
    this.gridThinWidth = 0.7,
    this.gridThickWidth = 2.5,
    this.scrimColor = Colors.black54,
    this.alwaysShowThirdLines = false,
    this.onCrop,
    this.minimumImageSize = 70,
    this.alwaysMove = false,
  });

  @override
  State<CropImage> createState() => _CropImageState();
}

enum _CornerTypes { UpperLeft, UpperRight, LowerRight, LowerLeft, None, Move }

class _CropImageState extends State<CropImage> {
  late CropController controller;
  late ImageStream _stream;
  late ImageStreamListener _streamListener;
  var currentCrop = Rect.zero;
  var size = Size.zero;
  _TouchPoint? panStart;

  Map<_CornerTypes, Offset> get gridCorners => <_CornerTypes, Offset>{
        _CornerTypes.UpperLeft: controller.crop.topLeft
            .scale(size.width, size.height)
            .translate(widget.paddingSize, widget.paddingSize),
        _CornerTypes.UpperRight: controller.crop.topRight
            .scale(size.width, size.height)
            .translate(widget.paddingSize, widget.paddingSize),
        _CornerTypes.LowerRight: controller.crop.bottomRight
            .scale(size.width, size.height)
            .translate(widget.paddingSize, widget.paddingSize),
        _CornerTypes.LowerLeft: controller.crop.bottomLeft
            .scale(size.width, size.height)
            .translate(widget.paddingSize, widget.paddingSize),
      };

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? CropController();
    controller.addListener(onChange);
    currentCrop = controller.crop;

    _stream = widget.image.image.resolve(const ImageConfiguration());
    _streamListener = ImageStreamListener((info, _) => controller.image = info.image);
    _stream.addListener(_streamListener);
  }

  @override
  void dispose() {
    controller.removeListener(onChange);
    _stream.removeListener(_streamListener);
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(CropImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.image != oldWidget.image) {
      _stream = widget.image.image.resolve(const ImageConfiguration());
      _streamListener = ImageStreamListener((info, _) => controller.image = info.image);
      _stream.addListener(_streamListener);
    }

    if (widget.controller == null && oldWidget.controller != null) {
      controller = CropController.fromValue(oldWidget.controller!.value);
      setState(() {});
    } else if (widget.controller != null && oldWidget.controller == null) {
      controller.dispose();
    }
  }

  double _getImageRatio(final double maxWidth, final double maxHeight) =>
      controller.getImage()!.width / controller.getImage()!.height;

  double _getWidth(final double maxWidth, final double maxHeight) {
    double imageRatio = _getImageRatio(maxWidth, maxHeight);
    final screenRatio = maxWidth / maxHeight;
    if (controller.value.rotation.isSideways) {
      imageRatio = 1 / imageRatio;
    }
    if (imageRatio > screenRatio) {
      return maxWidth;
    }
    return maxHeight * imageRatio;
  }

  double _getHeight(final double maxWidth, final double maxHeight) {
    double imageRatio = _getImageRatio(maxWidth, maxHeight);
    final screenRatio = maxWidth / maxHeight;
    if (controller.value.rotation.isSideways) {
      imageRatio = 1 / imageRatio;
    }
    if (imageRatio < screenRatio) {
      return maxHeight;
    }
    return maxWidth / imageRatio;
  }

  @override
  Widget build(BuildContext context) => Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (controller.getImage() == null) {
              return const CircularProgressIndicator();
            }

            final double maxWidth = constraints.maxWidth - 2 * widget.paddingSize;
            final double maxHeight = constraints.maxHeight - 2 * widget.paddingSize;
            final double width = _getWidth(maxWidth, maxHeight);
            final double height = _getHeight(maxWidth, maxHeight);
            size = Size(width, height);
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: width,
                  height: height,
                  child: CustomPaint(
                    painter: RotatedImagePainter(
                      controller.getImage()!,
                      controller.rotation,
                    ),
                  ),
                ),
                SizedBox(
                  width: width + 2 * widget.paddingSize,
                  height: height + 2 * widget.paddingSize,
                  child: GestureDetector(
                    onPanStart: onPanStart,
                    onPanUpdate: onPanUpdate,
                    onPanEnd: onPanEnd,
                    child: CropGrid(
                      crop: currentCrop,
                      gridColor: widget.gridColor,
                      paddingSize: widget.paddingSize,
                      cornerSize: widget.gridCornerSize,
                      thinWidth: widget.gridThinWidth,
                      thickWidth: widget.gridThickWidth,
                      scrimColor: widget.scrimColor,
                      alwaysShowThirdLines: widget.alwaysShowThirdLines,
                      isMoving: panStart != null,
                      onSize: (size) {
                        this.size = size;
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

  void onPanStart(DragStartDetails details) {
    if (panStart == null) {
      final type = hitTest(details.localPosition);
      if (type != _CornerTypes.None) {
        var basePoint = gridCorners[(type == _CornerTypes.Move) ? _CornerTypes.UpperLeft : type]!;
        setState(() {
          panStart = _TouchPoint(type, details.localPosition - basePoint);
        });
      }
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (panStart != null) {
      final offset =
          details.localPosition - panStart!.offset - Offset(widget.paddingSize, widget.paddingSize);
      if (panStart!.type == _CornerTypes.Move) {
        moveArea(offset);
      } else {
        moveCorner(panStart!.type, offset);
      }
      widget.onCrop?.call(controller.crop);
    }
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      panStart = null;
    });
  }

  void onChange() {
    setState(() {
      currentCrop = controller.crop;
    });
  }

  _CornerTypes hitTest(Offset point) {
    for (final gridCorner in gridCorners.entries) {
      final area = Rect.fromCenter(
          center: gridCorner.value, width: widget.touchSize, height: widget.touchSize);
      if (area.contains(point)) {
        return gridCorner.key;
      }
    }

    if (widget.alwaysMove) {
      return _CornerTypes.Move;
    }

    final area = Rect.fromPoints(
        gridCorners[_CornerTypes.UpperLeft]!, gridCorners[_CornerTypes.LowerRight]!);
    return area.contains(point) ? _CornerTypes.Move : _CornerTypes.None;
  }

  void moveArea(Offset point) {
    final crop = controller.crop.multiply(size);
    controller.crop = Rect.fromLTWH(
      point.dx.clamp(0, size.width - crop.width),
      point.dy.clamp(0, size.height - crop.height),
      crop.width,
      crop.height,
    ).divide(size);
  }

  void moveCorner(_CornerTypes type, Offset point) {
    final crop = controller.crop.multiply(size);
    var left = crop.left;
    var top = crop.top;
    var right = crop.right;
    var bottom = crop.bottom;

    switch (type) {
      case _CornerTypes.UpperLeft:
        left = point.dx.clamp(0, right - widget.minimumImageSize);
        top = point.dy.clamp(0, bottom - widget.minimumImageSize);
        break;
      case _CornerTypes.UpperRight:
        right = point.dx.clamp(left + widget.minimumImageSize, size.width);
        top = point.dy.clamp(0, bottom - widget.minimumImageSize);
        break;
      case _CornerTypes.LowerRight:
        right = point.dx.clamp(left + widget.minimumImageSize, size.width);
        bottom = point.dy.clamp(top + widget.minimumImageSize, size.height);
        break;
      case _CornerTypes.LowerLeft:
        left = point.dx.clamp(0, right - widget.minimumImageSize);
        bottom = point.dy.clamp(top + widget.minimumImageSize, size.height);
        break;
      default:
        assert(false);
    }

    if (controller.aspectRatio != null) {
      final width = right - left;
      final height = bottom - top;
      if (width / height > controller.aspectRatio!) {
        switch (type) {
          case _CornerTypes.UpperLeft:
          case _CornerTypes.LowerLeft:
            left = right - height * controller.aspectRatio!;
            break;
          case _CornerTypes.UpperRight:
          case _CornerTypes.LowerRight:
            right = left + height * controller.aspectRatio!;
            break;
          default:
            assert(false);
        }
      } else {
        switch (type) {
          case _CornerTypes.UpperLeft:
          case _CornerTypes.UpperRight:
            top = bottom - width / controller.aspectRatio!;
            break;
          case _CornerTypes.LowerRight:
          case _CornerTypes.LowerLeft:
            bottom = top + width / controller.aspectRatio!;
            break;
          default:
            assert(false);
        }
      }
    }

    controller.crop = Rect.fromLTRB(left, top, right, bottom).divide(size);
  }
}

class _TouchPoint {
  final _CornerTypes type;
  final Offset offset;

  _TouchPoint(this.type, this.offset);
}

class RotatedImagePainter extends CustomPainter {
  RotatedImagePainter(this.image, this.rotation);

  final ui.Image image;
  final CropRotation rotation;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    double targetWidth = size.width;
    double targetHeight = size.height;
    double offset = 0;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(offset, offset, targetWidth, targetHeight),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

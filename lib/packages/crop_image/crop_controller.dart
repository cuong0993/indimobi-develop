import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:indimobi/packages/crop_image/crop_rect.dart';
import 'package:indimobi/packages/crop_image/crop_rotation.dart';

class CropController extends ValueNotifier<CropControllerValue> {
  double? get aspectRatio => value.aspectRatio;

  set aspectRatio(double? newAspectRatio) {
    if (newAspectRatio != null) {
      value = value.copyWith(
        aspectRatio: newAspectRatio,
        crop: _adjustRatio(value.crop, newAspectRatio),
      );
    } else {
      value = CropControllerValue(
        1.0,
        value.crop,
        value.rotation,
        value.minimumImageSize,
      );
    }
    notifyListeners();
  }

  Rect get crop => value.crop;

  set crop(Rect newCrop) {
    value = value.copyWith(crop: _adjustRatio(newCrop, value.aspectRatio));
    notifyListeners();
  }

  CropRotation get rotation => value.rotation;

  set rotation(CropRotation rotation) {
    value = value.copyWith(rotation: rotation);
    notifyListeners();
  }

  void rotateRight() => _rotate(left: false);

  void rotateLeft() => _rotate(left: true);

  void _rotate({required final bool left}) {
    final CropRotation newRotation =
        left ? value.rotation.rotateLeft : value.rotation.rotateRight;
    final Offset newCenter = left
        ? Offset(crop.center.dy, 1 - crop.center.dx)
        : Offset(1 - crop.center.dy, crop.center.dx);
    value = CropControllerValue(
      aspectRatio,
      _adjustRatio(
        Rect.fromCenter(
          center: newCenter,
          width: crop.height,
          height: crop.width,
        ),
        aspectRatio,
        rotation: newRotation,
      ),
      newRotation,
      value.minimumImageSize,
    );
    notifyListeners();
  }

  Rect get cropSize => value.crop.multiply(_bitmapSize);

  set cropSize(Rect newCropSize) {
    value = value.copyWith(
      crop: _adjustRatio(newCropSize.divide(_bitmapSize), value.aspectRatio),
    );
    notifyListeners();
  }

  ui.Image? _bitmap;
  late Size _bitmapSize;

  set image(ui.Image newImage) {
    _bitmap = newImage;
    _bitmapSize = Size(newImage.width.toDouble(), newImage.height.toDouble());
    aspectRatio = aspectRatio;
    notifyListeners();
  }

  ui.Image? getImage() => _bitmap;

  CropController({
    double? aspectRatio,
    Rect defaultCrop = const Rect.fromLTWH(0, 0, 1, 1),
    CropRotation rotation = CropRotation.up,
    double minimumImageSize = 100,
  }) : super(CropControllerValue(
          aspectRatio,
          defaultCrop,
          rotation,
          minimumImageSize,
        ));

  CropController.fromValue(CropControllerValue value) : super(value);

  Rect _adjustRatio(
    Rect crop,
    double? aspectRatio, {
    CropRotation? rotation,
  }) {
    if (aspectRatio == null) {
      return crop;
    }
    final bool justRotated = rotation != null;
    rotation ??= value.rotation;
    final bitmapWidth =
        rotation.isSideways ? _bitmapSize.height : _bitmapSize.width;
    final bitmapHeight =
        rotation.isSideways ? _bitmapSize.width : _bitmapSize.height;
    if (justRotated) {
      const center = Offset(.5, .5);
      final width = bitmapWidth;
      final height = bitmapHeight;
      if (width / height > aspectRatio) {
        final w = height * aspectRatio / bitmapWidth;
        return Rect.fromCenter(center: center, width: w, height: 1);
      }
      final h = width / aspectRatio / bitmapHeight;
      return Rect.fromCenter(center: center, width: 1, height: h);
    }
    final width = crop.width * bitmapWidth;
    final height = crop.height * bitmapHeight;
    if (width / height > aspectRatio) {
      final w = height * aspectRatio / bitmapWidth;
      return Rect.fromLTWH(crop.center.dx - w / 2, crop.top, w, crop.height);
    } else {
      final h = width / aspectRatio / bitmapHeight;
      return Rect.fromLTWH(crop.left, crop.center.dy - h / 2, crop.width, h);
    }
  }

  Future<ui.Image> croppedBitmap({
    final double? maxSize,
    final ui.FilterQuality quality = FilterQuality.high,
  }) async =>
      getCroppedBitmap(
        maxSize: maxSize,
        quality: quality,
        crop: crop,
        rotation: value.rotation,
        image: _bitmap!,
      );

  static Future<ui.Image> getCroppedBitmap({
    final double? maxSize,
    final ui.FilterQuality quality = FilterQuality.high,
    required final Rect crop,
    required final CropRotation rotation,
    required final ui.Image image,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final bool tilted = rotation.isSideways;
    final double cropWidth;
    final double cropHeight;
    if (tilted) {
      cropWidth = crop.width * image.height;
      cropHeight = crop.height * image.width;
    } else {
      cropWidth = crop.width * image.width;
      cropHeight = crop.height * image.height;
    }

    double factor = 1;
    if (maxSize != null) {
      if (cropWidth > maxSize || cropHeight > maxSize) {
        if (cropWidth >= cropHeight) {
          factor = maxSize / cropWidth;
        } else {
          factor = maxSize / cropHeight;
        }
      }
    }

    final Offset cropCenter = rotation.getRotatedOffset(
      crop.center,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final double alternateWidth = tilted ? cropHeight : cropWidth;
    final double alternateHeight = tilted ? cropWidth : cropHeight;
    if (rotation != CropRotation.up) {
      canvas.save();
      final double x = alternateWidth / 2 * factor;
      final double y = alternateHeight / 2 * factor;
      canvas.translate(x, y);
      canvas.rotate(rotation.radians);
      if (rotation == CropRotation.right) {
        canvas.translate(
          -y,
          -cropWidth * factor + x,
        );
      } else if (rotation == CropRotation.left) {
        canvas.translate(
          y - cropHeight * factor,
          -x,
        );
      } else if (rotation == CropRotation.down) {
        canvas.translate(-x, -y);
      }
    }

    canvas.drawImageRect(
      image,
      Rect.fromCenter(
        center: cropCenter,
        width: alternateWidth,
        height: alternateHeight,
      ),
      Rect.fromLTWH(
        0,
        0,
        alternateWidth * factor,
        alternateHeight * factor,
      ),
      Paint()..filterQuality = quality,
    );

    if (rotation != CropRotation.up) {
      canvas.restore();
    }

    return await pictureRecorder
        .endRecording()
        .toImage((cropWidth * factor).round(), (cropHeight * factor).round());
  }

  Future<Uint8List> croppedImage(
      {ui.FilterQuality quality = FilterQuality.high}) async {
    ui.Image image = await croppedBitmap(quality: quality);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(1);
    return Uint8List.view(byteData.buffer);
  }
}

class CropControllerValue {
  final double? aspectRatio;
  final Rect crop;
  final CropRotation rotation;
  final double minimumImageSize;

  const CropControllerValue(
    this.aspectRatio,
    this.crop,
    this.rotation,
    this.minimumImageSize,
  );

  CropControllerValue copyWith({
    double? aspectRatio,
    Rect? crop,
    CropRotation? rotation,
    double? minimumImageSize,
  }) =>
      CropControllerValue(
        aspectRatio ?? this.aspectRatio,
        crop ?? this.crop,
        rotation ?? this.rotation,
        minimumImageSize ?? this.minimumImageSize,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CropControllerValue &&
        other.aspectRatio == aspectRatio &&
        other.crop == crop &&
        other.rotation == rotation &&
        other.minimumImageSize == minimumImageSize;
  }

  @override
  int get hashCode => Object.hash(
        aspectRatio.hashCode,
        crop.hashCode,
        rotation.hashCode,
        minimumImageSize.hashCode,
      );
}

class UiImageProvider extends ImageProvider<UiImageProvider> {
  final ui.Image image;

  const UiImageProvider(this.image);

  @override
  Future<UiImageProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<UiImageProvider>(this);

  @override
  ImageStreamCompleter loadBuffer(
    UiImageProvider key,
    DecoderBufferCallback decode,
  ) =>
      OneFrameImageStreamCompleter(_loadAsync(key));

  Future<ImageInfo> _loadAsync(UiImageProvider key) async {
    assert(key == this);
    return ImageInfo(image: image);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final UiImageProvider typedOther = other;
    return image == typedOther.image;
  }

  @override
  int get hashCode => image.hashCode;
}

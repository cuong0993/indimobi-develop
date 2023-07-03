import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_colors.dart';

class ImageUnitCpn extends StatelessWidget {
  final List<int> images;

  const ImageUnitCpn({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.memory(
        Uint8List.fromList(images),
        errorBuilder: (c, e, s) {
          return Container(
            color: AppColors.colorLayout.withOpacity(0.5),
            width: 33,
            height: 44,
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class ImageFileCpn extends StatelessWidget {
  final String image;
  const ImageFileCpn({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.file(
        File(image),
        errorBuilder: (c, e, s) {
          return SizedBox();
        },
        fit: BoxFit.cover,
      ),
    );
  }
}

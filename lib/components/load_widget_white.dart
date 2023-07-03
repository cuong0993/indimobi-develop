import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_colors.dart';

class LoadWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  LoadWidget({this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 32,
        width: width ?? 32,
        child: CircularProgressIndicator(
          color: color ?? AppColors.colorLoadRed,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

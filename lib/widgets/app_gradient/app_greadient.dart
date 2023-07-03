import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_colors.dart';

class AppGradient {
  static LinearGradient gradientCenter = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.bgrDarkColor,
      AppColors.mainColor,
      AppColors.bgrDarkColor,
    ],
  );
  static LinearGradient gradientTopToBottom = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.cyan,
      Colors.cyan.withOpacity(0.6),
    ],
  );

  static LinearGradient gradientOtp = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.bgrOtpBottom,
      AppColors.bgrOtpTop,
    ],
  );
  static LinearGradient gradientLeftRight = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.bgrAccLeft,
      AppColors.bgrAccRight,
    ],
  );

  static LinearGradient gradientTransparent = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      AppColors.bgrDarkColor.withOpacity(0.7),
    ],
  );
  static LinearGradient gradientDisable = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF747474),
      Color(0xFFACACAC),
      Color(0xFFACACAC),
      Color(0xFF747474),
    ],
  );
}

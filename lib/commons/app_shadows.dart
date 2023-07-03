import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_colors.dart';

class AppShadows {
  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Color(0xFFC0C0C0),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(2, 2),
    ),
  ];

  static List<BoxShadow> boxShadowAll = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 3,
      offset: const Offset(0, 0),
    ),
  ];
  static List<BoxShadow> boxShadowAllProject = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 3,
      offset: const Offset(0, 0),
    ),
  ];

  static final List<BoxShadow> boxShadowInputChat = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 8,
      offset: const Offset(0, 0),
    ),
  ];

  static final List<BoxShadow> boxShadowInfo = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0, 2),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:indimobi/commons/app_style.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Không có dữ liệu!',
        style: AppTextStyle.textSize_14,
      ),
    );
  }
}

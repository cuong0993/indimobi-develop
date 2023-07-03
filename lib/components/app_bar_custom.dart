import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/ic_back_cpn.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(48);

  final String title;
  final bool? isDone;
  final bool? isBack;
  final bool? centerTitle;
  final double? elevation;
  final double? leadingWidth;
  final Color? bgr;
  final Color? colorIconBack;
  final Color? colorTitle;
  final VoidCallback? onPressDone;
  final VoidCallback? onPressBack;
  final List<Widget>? actions;
  final Widget? backBtn;

  CustomAppBar({
    Key? key,
    required this.title,
    this.isDone,
    this.isBack = true,
    this.centerTitle = true,
    this.bgr,
    this.colorIconBack,
    this.colorTitle,
    this.elevation,
    this.onPressDone,
    this.onPressBack,
    this.actions,
    this.backBtn,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyle.textSize_16.copyWith(
          color: colorTitle ?? AppColors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: bgr ?? Colors.white,
      automaticallyImplyLeading: true,
      elevation: elevation ?? 1,
      leadingWidth: leadingWidth,
      leading: isBack == true ? (backBtn ?? IcBackCpn()) : SizedBox(),
      actions: actions ??
          [
            isDone == true ? buildDone() : const SizedBox(),
          ],
    );
  }

  Widget buildDone() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          onPressDone != null ? onPressDone?.call() : Get.back();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          color: Colors.transparent,
          child: Center(
            child: Text(
              'Lưu',
              style: AppTextStyle.textSize_16.copyWith(
                color: AppColors.colorButtonGreen,
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/add_content_page/add_content_vm.dart';

class AppBarItem extends StatelessWidget {
  final AddContentVm vm = Get.find<AddContentVm>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.back();
          },
          child: Text(
            'Hủy',
            style: AppTextStyle.textSize_16.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        buildMenu(
          height: Get.height * 0.6,
          ctrl: vm.ctrlMenuFont,
          context: context,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GetBuilder<AddContentVm>(builder: (logic) {
              return Text(
                'Font',
                style: AppTextStyle.textSize_14.copyWith(
                  fontFamily: logic.fontFa,
                ),
              );
            }),
          ),
          body: GetBuilder<AddContentVm>(builder: (logic) {
            return buildListMenu(
              list: vm.fontFamily,
              onTap: (text) {
                vm.ctrlMenuFont.hideMenu();
                vm.updateFontFamily(text);
              },
              textSelect: logic.fontFa,
            );
          }),
        ),
        buildMenu(
          height: Get.height * 0.4,
          ctrl: vm.ctrlMenuSize,
          context: context,
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GetBuilder<AddContentVm>(
              builder: (logic) {
                return Text(logic.fontSi, style: AppTextStyle.textSize_14);
              },
            ),
          ),
          body: GetBuilder<AddContentVm>(builder: (logic) {
            return buildListMenu(
              list: vm.fontSizes,
              onTap: (text) {
                vm.ctrlMenuSize.hideMenu();
                vm.updateFontSize(text);
              },
              textSelect: logic.fontSi,
            );
          }),
        ),
        buildMenu(
          height: 55,
          width: 170,
          ctrl: vm.ctrlMenuAlign,
          context: context,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GetBuilder<AddContentVm>(builder: (logic) {
              return Icon(
                logic.align,
                size: 22,
                color: AppColors.colorButtonGreen,
              );
            }),
          ),
          body: GetBuilder<AddContentVm>(builder: (logic) {
            return buildListMenuAlign(
              list: vm.icons,
              onTap: (icons) {
                vm.ctrlMenuAlign.hideMenu();
                vm.updateAlign(icons);
              },
              iconSelect: logic.align,
            );
          }),
        ),
        SizedBox(width: 10),
        Spacer(),
        GetBuilder<AddContentVm>(builder: (logic) {
          return TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (logic.indexCover != -1) {
                Get.back(result: logic.listText);
              } else {
                Get.back(result: [logic.currentText]);
              }
            },
            child: Text(
              'Lưu',
              style: AppTextStyle.textSize_16.copyWith(
                color: AppColors.colorButtonGreen,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget buildListMenu(
      {required List<String> list,
      required Function(String) onTap,
      required String textSelect}) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: list.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTap(list[index]);
          },
          child: Container(
            height: 35,
            width: Get.width,
            color: textSelect == list[index]
                ? AppColors.colorItemOder
                : Colors.transparent,
            margin: EdgeInsets.only(bottom: 1),
            padding: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              list[index],
              style: AppTextStyle.textSize_14.copyWith(
                fontFamily: list[index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildListMenuAlign(
      {required List<IconData> list,
      required Function(IconData) onTap,
      required IconData iconSelect}) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: list.length,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(list[index]);
            },
            child: Container(
              height: 50,
              width: 50,
              color: iconSelect == list[index]
                  ? AppColors.colorItemOder
                  : Colors.transparent,
              child: Center(
                child: Icon(
                  list[index],
                  size: 26,
                  color: AppColors.colorButtonGreen,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMenu({
    required CustomPopupMenuController ctrl,
    required Widget child,
    required Widget body,
    required double height,
    required BuildContext context,
    double? width,
  }) {
    return CustomPopupMenu(
      pressType: PressType.longPress,
      controller: ctrl,
      barrierColor: Colors.black.withOpacity(0.2),
      arrowSize: 18,
      verticalMargin: -10,
      arrowColor: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          ctrl.showMenu();
        },
        child: child,
      ),
      menuBuilder: () {
        return Container(
          width: width ?? Get.width * 0.6,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: body,
        );
      },
    );
  }
}

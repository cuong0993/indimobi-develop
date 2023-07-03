import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';

class ItemActionWidget extends StatefulWidget {
  const ItemActionWidget({Key? key}) : super(key: key);

  @override
  State<ItemActionWidget> createState() => _ItemActionWidgetState();
}

class _ItemActionWidgetState extends State<ItemActionWidget> {
  DetailProjectVm vm = Get.find<DetailProjectVm>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black54, width: 0.3),
        ),
      ),
      child: GetBuilder<DetailProjectVm>(builder: (logic) {
        return Row(
          children: [
            buildItemAction(
              title: 'Thêm ảnh',
              iconName: '',
              isSelect: logic.actionSelect == 1,
              onPress: () {
                vm.updateActionSelect(-1);
                vm.getImages();
              },
            ),
            Container(height: 34, color: Colors.black54, width: 0.3),
            buildItemAction(
              title: 'Sắp xếp',
              iconName: '',
              isSelect: logic.actionSelect == 2,
              onPress: () {
                if (logic.actionSelect != 2) {
                  vm.updateActionSelect(2);
                }
              },
            ),
            Container(height: 34, color: Colors.black54, width: 0.3),
            buildItemAction(
              title: 'Tùy chọn',
              iconName: '',
              isSelect: logic.actionSelect == 3,
              onPress: () {
                if (logic.actionSelect != 3) {
                  vm.updateActionSelect(3);
                }
              },
            ),
          ],
        );
      }),
    );
  }

  Widget buildItemAction({
    required String title,
    required String iconName,
    required bool isSelect,
    required VoidCallback onPress,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onPress();
        },
        child: Container(
          color: isSelect ? AppColors.colorBrg : AppColors.textWhite,
          height: 34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 17,
                color: AppColors.black,
              ),
              SizedBox(width: 5),
              Text(
                title,
                style: AppTextStyle.textSize_14.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

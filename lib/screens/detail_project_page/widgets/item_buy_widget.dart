import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';
import 'package:indimobi/screens/input_phone_page/input_phone_page.dart';
import 'package:indimobi/screens/preview_album_page/preview_album_page.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class ItemBuyWidget extends StatelessWidget {
  const ItemBuyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      color: AppColors.colorBottomBar,
      child: SafeArea(
        child: Row(
          children: [
            GetBuilder<DetailProjectVm>(builder: (logic) {
              return AppButton(
                height: 35,
                radius: 3,
                onPress: () {
                  if (logic.albumEntity.pages?.length != 0) {
                    Get.to(
                      () => PreviewAlbumPage(albumEntity: logic.albumEntity),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 250),
                    );
                  }
                },
                title: 'Xem trước',
                bgrColor: AppColors.textWhite,
                textColor: AppColors.colorButtonGreen,
                textSize: 14,
                width: 95,
              );
            }),
            Expanded(
              child: Column(
                children: [
                  GetBuilder<DetailProjectVm>(
                      id: 'price',
                      builder: (logic) {
                        return Text(
                          '${logic.price}'.toVND().replaceAll('đ', 'vnđ'),
                          style: AppTextStyle.textSize_16.copyWith(
                            color: AppColors.textWhite,
                          ),
                        );
                      }),
                  Text(
                    'Chi tiết',
                    style: AppTextStyle.textSize_12.copyWith(
                      color: AppColors.colorButtonGreen,
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              height: 35,
              radius: 3,
              onPress: () {
                Get.to(() => InputPhonePage());
              },
              bgrColor: AppColors.colorButtonGreen,
              title: 'Thanh toán',
              textSize: 14,
              width: 95,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/history_payment_page/history_payment_vm.dart';

class HistoryPaymentPage extends StatefulWidget {
  const HistoryPaymentPage({Key? key}) : super(key: key);

  @override
  HistoryPaymentPageState createState() => HistoryPaymentPageState();
}

class HistoryPaymentPageState extends State<HistoryPaymentPage> {
  HistoryPaymentVm vm = Get.put<HistoryPaymentVm>(HistoryPaymentVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HistoryPaymentVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(
        title: 'Lịch sử thanh toán',
        bgr: AppColors.colorGreen,
        colorIconBack: AppColors.textWhite,
        colorTitle: AppColors.textWhite,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                color: AppColors.bgrTitle,
                width: Get.width,
                child: Text(
                  'Tháng 0${9 - index}/2022',
                  style: AppTextStyle.textSizeBold_14.copyWith(
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    color: AppColors.textWhite,
                    width: Get.width,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          index % 2 == 0 ? AppImages.icBuy : AppImages.icInvite,
                          height: 30,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      index % 2 == 0
                                          ? 'Giới thiệu'
                                          : 'Mua album',
                                      style: AppTextStyle.textSize_14.copyWith(
                                        color: AppColors.colorGreen,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    index % 2 == 0 ? '+ 200đ' : '- 500đ',
                                    style: AppTextStyle.textSizeBold_14
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                '19:19 - 30/05/2022',
                                style: AppTextStyle.textSize_12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_14,
    );
  }
}

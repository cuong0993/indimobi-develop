import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/widgets/app_gradient/app_greadient.dart';

class InfoPayAccPage extends StatefulWidget {
  const InfoPayAccPage({Key? key}) : super(key: key);

  @override
  InfoPayAccPageState createState() => InfoPayAccPageState();
}

class InfoPayAccPageState extends State<InfoPayAccPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Số tài khoản thanh toán'),
      body: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: AppGradient.gradientLeftRight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText(
                'Quý khách vui lòng chuyển khoản thanh toán theo tài khoản dưới đây:'),
            SizedBox(height: 20),
            Row(
              children: [
                buildText('Số tài khoản: '),
                Text(
                  '26810000446322',
                  style: AppTextStyle.textSize_16.copyWith(
                    color: AppColors.textBlue,
                    height: 1.5,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            buildText('Tên tài khoản: Hoàng Thanh Hà'),
            buildText(
                'BIDV - Ngân hàng Đầu tư và Phát triển Việt Nam - Chi nhánh Thái Hà'),
            SizedBox(height: 20),
            buildText('Cú pháp: NIZI [Số đơn hàng]'),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_16.copyWith(
        color: AppColors.textWhite,
        height: 1.5,
      ),
    );
  }
}

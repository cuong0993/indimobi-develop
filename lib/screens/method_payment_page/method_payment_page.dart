import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/screens/create_order_page/create_order_page.dart';
import 'package:indimobi/screens/method_payment_page/method_payment_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class MethodPayPage extends StatefulWidget {
  final AddressEntity? address;

  MethodPayPage({this.address});

  @override
  MethodPayPageState createState() => MethodPayPageState();
}

class MethodPayPageState extends State<MethodPayPage> {
  MethodPaymentVm vm = Get.put<MethodPaymentVm>(MethodPaymentVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MethodPaymentVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CustomAppBar(title: 'Phương thức thanh toán'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.colorItemOder,
                    ),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        GetBuilder<MethodPaymentVm>(builder: (logic) {
                          return buildOption(
                              isCod: true,
                              title: 'Thanh toán khi nhận hàng(COD)',
                              onTap: () {
                                vm.updateMethod(true);
                              },
                              isSelect: logic.isCod == true,
                              text: 'Chỉ app dụng với đơn hàng dưới 350.000đ');
                        }),
                        SizedBox(height: 30),
                        GetBuilder<MethodPaymentVm>(builder: (logic) {
                          return buildOption(
                            onTap: () {
                              vm.updateMethod(false);
                            },
                            isSelect: logic.isCod == false,
                            isCod: false,
                            title: 'Thanh toán bằng chuyển khoản',
                            text: 'Hoặc qua thẻ Visa/Master Card',
                          );
                        }),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.colorItemOder,
                    ),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Thông tin chuyển khoản",
                            style: AppTextStyle.textSizeBold_16,
                          ),
                        ),
                        SizedBox(height: 20),
                        buildTextNormal('Số tài khoản: 20315485211426'),
                        buildTextNormal('Chủ tài khoản: Nguyễn Văn A'),
                        buildTextNormal(
                            'BIDV - Ngân hàng đầu tư và Phát triển Việt Nam - Chi nhánh Thái Hà'),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            buildTextNormal('Nội dung ck: '),
                            Text(
                              "Indi(Số đơn hàng)",
                              style: AppTextStyle.textSizeBold_14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: AppButton(
                width: Get.width,
                height: 40,
                radius: 30,
                title: 'Tiếp tục thanh toán',
                onPress: () {
                  Get.to(
                    () => CreateOrderPage(address: widget.address),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 250),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextNormal(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_14.copyWith(
        color: Colors.black54,
        height: 1.4,
      ),
    );
  }

  Widget buildOption({
    required bool isCod,
    required bool isSelect,
    required String title,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 1.4),
                shape: BoxShape.circle,
                color: isSelect ? AppColors.colorGreenTog : Colors.transparent,
              ),
              padding: EdgeInsets.all(6),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitle(title),
                  SizedBox(height: 6),
                  buildText(text),
                  if (isCod == false) SizedBox(height: 4),
                  if (isCod == false)
                    Text(
                      'Miễn phí vận chuyển khi thanh toán chuyển khoản với đơn hàng giá trị trên 300.000đ',
                      style: AppTextStyle.textSize_12.copyWith(
                        color: AppColors.colorTextRed,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_12.copyWith(
        color: AppColors.buttonColorGrey,
      ),
    );
  }

  Widget buildTextTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.textSize_14,
    );
  }
}

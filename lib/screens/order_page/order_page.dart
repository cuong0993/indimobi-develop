import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/order_page/order_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  OrderVm vm = Get.put<OrderVm>(OrderVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<OrderVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: CustomAppBar(title: 'Giỏ hàng'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 16,
                      itemBuilder: (context, index) => buildItem(),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      separatorBuilder: (context, index) => buildDivider(),
                    ),
                    buildDivider(),
                    SizedBox(height: 35),
                    AppButton(
                      radius: 30,
                      height: 40,
                      borderColor: AppColors.textWhite,
                      onPress: () {},
                      width: Get.width * 0.7,
                      title: 'Tạo thêm sản phẩm khác',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      buildText('Mã giảm giá:'),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.7),
                        ),
                        child: buildText('GCDSJGSG'),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(child: buildText('Phí vận chuyển:')),
                      buildText('250.000đ'),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 5),
                  buildDivider(),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(child: buildText('Tổng:')),
                      buildText('250.000đ'),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    radius: 30,
                    height: 40,
                    borderColor: AppColors.textWhite,
                    onPress: () {},
                    width: Get.width * 0.7,
                    title: 'Tiếp tục thanh toán',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDivider() {
    return Container(
      height: 1.5,
      width: Get.width,
      color: Colors.grey,
    );
  }

  Widget buildItem() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 8, top: 10, right: 5),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(4),
                ),
                SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    AppImages.imgPlane,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText('Photobook'),
                        buildText('20x20-mở cong - 20 trang'),
                        Spacer(),
                        buildText('200.000đ'),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Icon(Icons.remove),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('10'),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              AppImages.icCancel,
              height: 15,
              width: 15,
              fit: BoxFit.cover,
            ),
          ),
        ],
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

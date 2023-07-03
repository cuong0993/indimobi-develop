import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/order_detail_res.dart';
import 'package:indimobi/models/response/order_res.dart';
import 'package:indimobi/screens/info_order_page/info_order_vm.dart';

class InfoOderPage extends StatefulWidget {
  final String id;

  const InfoOderPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  InfoOderPageState createState() => InfoOderPageState();
}

class InfoOderPageState extends State<InfoOderPage> {
  InfoOrderVm vm = Get.put<InfoOrderVm>(InfoOrderVm());
  TextEditingController textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    vm.getDetailOrder(widget.id);
  }

  @override
  void dispose() {
    textCtrl.dispose();
    Get.delete<InfoOrderVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thông tin đơn hàng'),
      body: GetBuilder<InfoOrderVm>(builder: (logic) {
        return logic.loadStatus == LoadStatus.loading
            ? LoadWidget()
            : Column(
                children: [
                  Expanded(child: buildBody(logic.order?.order)),
                ],
              );
      }),
    );
  }

  Widget buildBody(Order? order) {
    ShippingAddress? address = order?.shippingAddress;
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.colorItemOder,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextTitle('Địa chỉ giao hàng'),
                const SizedBox(height: 12),
                buildText(address?.firstName ?? ''),
                const SizedBox(height: 8),
                buildText(address?.phone ?? ''),
                const SizedBox(height: 8),
                buildText(address?.address1 ?? ''),
                const SizedBox(height: 20),
                buildTextTitle('Thời gian giao hàng'),
                const SizedBox(height: 10),
                buildText(
                  'Dự kiến từ ngày ${order?.shippingDateFrom} '
                  'đến ngày ${order?.shippingDateTo}',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.colorItemOder,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextTitle('Đơn hàng'),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildText('1x')),
                    buildText(
                      '${(order?.totalPrice ?? 0) - (order?.shippingPrice ?? 0)}'
                          .toVND(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                buildRow('Mã giảm giá', '-${order?.discountPrice.toVND()}'),
                const SizedBox(height: 15),
                buildRow(
                    'Phí vận chuyển', '${order?.shippingPrice.toVND()}'),
                const SizedBox(height: 10),
                Text(
                  'Miễn phí vận chuyển khi thanh toán chuyển khoản với đơn hàng giá trị lên đến 300.000đ',
                  style: AppTextStyle.textSize_12.copyWith(color: Colors.red),
                ),
                Container(
                  width: Get.width,
                  color: Colors.grey,
                  height: 0.5,
                  margin: const EdgeInsets.only(
                    left: 0,
                    top: 10,
                    right: 0,
                    bottom: 25,
                  ),
                ),
                buildRowRice('Tổng', '${order?.totalPrice.toVND()}'),
              ],
            ),
          ),
          SizedBox(height: 35),
        ],
      ),
    );
  }

  Widget buildRow(String textLeft, String textRight) {
    return Row(
      children: [
        Expanded(child: buildText(textLeft)),
        buildText(textRight),
      ],
    );
  }

  Widget buildRowRice(String textLeft, String textRight) {
    return Row(
      children: [
        Expanded(
          child: Text(
            textLeft,
            style: AppTextStyle.textSizeBold_14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          textRight,
          style: AppTextStyle.textSizeBold_14.copyWith(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_14,
    );
  }

  Widget buildTextTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.textSize_16.copyWith(fontWeight: FontWeight.w500),
    );
  }
}

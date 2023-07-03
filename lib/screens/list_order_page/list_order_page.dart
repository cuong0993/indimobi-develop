import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/components/no_data.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/models/response/order_res.dart';
import 'package:indimobi/screens/info_order_page/info_order_page.dart';
import 'package:indimobi/screens/list_order_page/list_order_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:intl/intl.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({Key? key}) : super(key: key);

  @override
  ListOrderPageState createState() => ListOrderPageState();
}

class ListOrderPageState extends State<ListOrderPage> {
  ListOrderVm vm = Get.put<ListOrderVm>(ListOrderVm());

  @override
  void initState() {
    super.initState();
    vm.getListOrder();
  }

  @override
  void dispose() {
    Get.delete<ListOrderVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(title: 'Danh sách đơn hàng'),
      body: SafeArea(
        bottom: false,
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        return vm.getListOrder();
      },
      child: SizedBox.expand(
        child: GetBuilder<ListOrderVm>(
          builder: (logic) {
            if (logic.loadStatus == LoadStatus.loading) {
              return LoadWidget();
            }
            if (logic.listOrder == []) {
              return NoData();
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.only(top: 15, bottom: 25),
                physics: AlwaysScrollableScrollPhysics(),
                child: buildBodySingle(logic),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildBodySingle(ListOrderVm logic) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorItemOder,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.listOrder.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => InfoOderPage(id: logic.listOrder[index].id.toString()),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 250),
              );
            },
            child: buildItem(logic.listOrder[index]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget buildItem(Orders order) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(order.createdOn ?? DateTime.now().toString());
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(parseDate);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${order.id}',
            style: AppTextStyle.textSize_16.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText('${order.paymentMethod}'),
                    SizedBox(height: 6),
                    buildText('Đặt hàng: $date'),
                    SizedBox(height: 6),
                    buildText('Sản phẩm: ${order.productId}'),
                  ],
                ),
              ),
              Column(
                children: [
                  AppButton(
                    height: 29,
                    radius: 6,
                    bgrColor: Colors.grey,
                    borderColor: AppColors.colorBottomBar,
                    onPress: () {
                      Get.to(
                        () => InfoOderPage(id: order.id.toString()),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 250),
                      );
                    },
                    width: 95,
                    title: 'Chi tiết',
                    textSize: 14,
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    height: 29,
                    radius: 6,
                    borderColor: AppColors.textWhite,
                    bgrColor: AppColors.colorButtonGreen,
                    onPress: () {},
                    width: 95,
                    title: 'Thanh toán',
                    textSize: 14,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_14.copyWith(
        height: 1.4,
      ),
    );
  }
}

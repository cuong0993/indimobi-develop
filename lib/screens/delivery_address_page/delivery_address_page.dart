import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/delivery_address_page/delivery_address_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  DeliveryAddressPageState createState() => DeliveryAddressPageState();
}

class DeliveryAddressPageState extends State<DeliveryAddressPage> {
  DeliveryAddressVm vm = Get.put<DeliveryAddressVm>(DeliveryAddressVm());

  @override
  void initState() {
    super.initState();
    vm.initData();
  }

  @override
  void dispose() {
    Get.delete<DeliveryAddressVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Địa chỉ giao hàng'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            child: buildCreate(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return vm.initData();
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GetBuilder<DeliveryAddressVm>(builder: (logic) {
                    return ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: logic.address.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            vm.selectItem(index);
                          },
                          child: buildItem(
                            logic.address[index],
                            index == logic.indexSelect,
                            index,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
                  }),
                  GetBuilder<DeliveryAddressVm>(builder: (logic) {
                    return logic.loadStatus == LoadStatus.loading
                        ? LoadWidget()
                        : SizedBox();
                  }),
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
                title: 'Giao hàng đến địa chỉ này',
                onPress: () {
                  vm.navigateDeliver();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(AddressEntity address, bool isSelect, int index) {
    return Container(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: AppColors.colorItemOder,
      ),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          buildOption(
            isSelect: isSelect,
            title: address.name,
            index: index,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                buildText(address.phone),
                SizedBox(height: 8),
                buildText(address.address),
                SizedBox(height: 8),
                buildText(
                  '${address.city}, ${address.district}, ${address.commune}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextNormal(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_16.copyWith(
        color: Colors.black54,
        height: 1.4,
      ),
    );
  }

  Widget buildOption({
    required String title,
    required bool isSelect,
    required int index,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
              width: 1.4,
            ),
            shape: BoxShape.circle,
            color: isSelect ? AppColors.colorGreenTog : Colors.transparent,
          ),
          padding: EdgeInsets.all(6),
        ),
        SizedBox(width: 13),
        Expanded(child: buildTextTitle(title)),
        GestureDetector(
          onTap: () {
            AppDialog.confirm(
              message: 'Bạn muốn xóa địa chỉ này?',
              onTapR: () {
                vm.deleteItem(index);
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Icon(
              Icons.close,
              size: 20,
              color: AppColors.colorLoadRed,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCreate() {
    return GestureDetector(
      onTap: () {
        vm.navigateNewAdd();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColors.colorItemOder,
        ),
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 2),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 1.4),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(6),
            ),
            SizedBox(width: 12),
            Expanded(
              child: buildTextTitle('Tạo địa chỉ giao hàng mới'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: AppTextStyle.textSize_14.copyWith(
        color: Colors.black54,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget buildTextTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.textSize_14.copyWith(fontWeight: FontWeight.w400),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

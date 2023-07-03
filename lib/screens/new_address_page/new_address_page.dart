import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/delivery_address_page/delivery_address_vm.dart';
import 'package:indimobi/screens/new_address_page/new_address_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class NewAddressPage extends StatefulWidget {
  final List<AddressEntity> address;

  const NewAddressPage({required this.address});

  @override
  NewAddressPageState createState() => NewAddressPageState();
}

class NewAddressPageState extends State<NewAddressPage> {
  NewAddressVm vm = Get.put<NewAddressVm>(NewAddressVm());

  @override
  void initState() {
    super.initState();
    vm.initData();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<DeliveryAddressVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Địa chỉ giao hàng'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.colorItemOder,
                ),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextTitle('Họ tên'),
                    SizedBox(height: 3),
                    buildTextField(controller: vm.ctrlName),
                    SizedBox(height: 15),
                    buildTextTitle('Điện thoại'),
                    SizedBox(height: 3),
                    buildTextField(controller: vm.ctrlPhone, isPhone: true),
                    SizedBox(height: 15),
                    buildTextTitle('Địa chỉ'),
                    SizedBox(height: 3),
                    buildTextField(controller: vm.ctrlAddress),
                    SizedBox(height: 15),
                    buildRow('Tỉnh/Thành phố'),
                    buildTextField(controller: vm.ctrlTP, enable: true),
                    SizedBox(height: 15),
                    buildRow('Quận/Huyện'),
                    buildTextField(controller: vm.ctrlQH, enable: true),
                    SizedBox(height: 15),
                    buildRow('Phường/Xã'),
                    buildTextField(controller: vm.ctrlPX, enable: true),
                    SizedBox(height: 15),
                    buildTextTitle('Ghi chú'),
                    SizedBox(height: 3),
                    buildTextField(controller: vm.ctrlNote),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: GetBuilder<NewAddressVm>(builder: (logic) {
                return AppButton(
                  width: Get.width,
                  height: 40,
                  radius: 30,
                  isLoad: logic.loadStatus == LoadStatus.loading,
                  title: 'Giao hàng đến địa chỉ này'.toUpperCase(),
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    vm.addAddress(listAddress: widget.address);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String text) {
    return Row(
      children: [
        Expanded(child: buildTextTitle(text)),
        Container(
          color: Colors.transparent,
          child: Icon(
            Icons.arrow_drop_down_outlined,
            size: 25,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
      {required TextEditingController controller,
      bool? enable,
      bool? isPhone}) {
    return TextField(
      controller: controller,
      enabled: enable ?? true,
      maxLength: isPhone == true ? 10 : null,
      keyboardType: isPhone == true ? TextInputType.number : null,
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.all(4),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.7),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 0.7),
        ),
      ),
      cursorHeight: 20,
      cursorColor: AppColors.primary,
      style: AppTextStyle.textSize_16,
    );
  }

  Widget buildTextTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.textSize_16
              .copyWith(fontWeight: FontWeight.w400, color: Colors.black54),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (title != 'Ghi chú')
          Text(
            ' *',
            style: AppTextStyle.textSize_14.copyWith(
              color: AppColors.colorLoadRed,
            ),
          )
      ],
    );
  }
}

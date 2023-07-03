import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/history_payment_page/history_payment_page.dart';
import 'package:indimobi/screens/info_pay_acc_page/info_pay_acc_page.dart';
import 'package:indimobi/screens/late_start/account_page/account_vm.dart';
import 'package:indimobi/screens/list_order_page/list_order_page.dart';
import 'package:indimobi/widgets/app_buttons/app_button_next.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  AccountVm vm = Get.put<AccountVm>(AccountVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AccountVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(title: 'Tài khoản'),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              boxShadow: AppShadows.boxShadowAll,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            width: Get.width,
            child: Column(
              children: [
                AppButtonNext(
                  onPress: () {
                    Get.to(() => const ListOrderPage());
                  },
                  title: 'Danh sách đơn hàng'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {
                    Get.to(() => const InfoPayAccPage());
                  },
                  title: 'Số tài khoản thanh toán'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {},
                  title: 'Giới thiệu về INDI'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {},
                  title: 'Vận chuyển và giao hàng'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {},
                  title: 'Chính sách bảo mật'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {
                    Get.to(() => const HistoryPaymentPage());
                  },
                  title: 'Lịch sử thanh toán'.toUpperCase(),
                ),
                const SizedBox(height: 15),
                AppButtonNext(
                  onPress: () {},
                  title: 'Yêu cầu rút tiền'.toUpperCase(),
                ),
                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}

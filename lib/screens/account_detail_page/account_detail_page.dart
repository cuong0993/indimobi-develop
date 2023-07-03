import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/screens/account_detail_page/account_detail_vm.dart';
import 'package:indimobi/screens/list_order_page/list_order_page.dart';
import 'package:indimobi/utils/function_utils.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:indimobi/widgets/app_snack_bar/app_snack_bar.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({Key? key}) : super(key: key);

  @override
  AccountDetailPageState createState() => AccountDetailPageState();
}

class AccountDetailPageState extends State<AccountDetailPage> {
  AccountDetailVm vm = Get.put<AccountDetailVm>(AccountDetailVm());
  TextEditingController textCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    textCtrl.dispose();
    Get.delete<AccountDetailVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: CustomAppBar(title: 'Quản lí tài sản'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 30),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //buildAvatar(width),
            //SizedBox(height: 25),
            //buildTotalMoney(width),
            //SizedBox(height: 25),
            buildShareCode(width),
            buildInput(width),
            buildMenu(width),
          ],
        ),
      ),
    );
  }

  Widget buildShareCode(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.colorAcc,
      ),
      width: width,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Giới thiệu một người bạn đến Indi",
            style: AppTextStyle.textSizeBold_16.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Stack(
            children: [
              buildMoney(
                marginR: 78,
                textC: Colors.white,
                colors: Colors.transparent,
                title: '5',
                text: 'Cho bạn bè',
              ),
              buildMoney(
                marginL: 78,
                textC: AppColors.colorButtonGreen,
                colors: Colors.white,
                title: '10',
                text: 'Cho bạn',
              ),
            ],
          ),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Chia sẻ mã giảm giá đặc biệt này với bạn bè để giảm giá \$5 cho đơn hàng đầu tiên của họ và bạn sẽ nhận được \$10 trong tài khoản của mình.',
              style: AppTextStyle.textSize_14.copyWith(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: "2Z8YCB7V")).then((_) {
                AppSnackBar.showSnackBar(mess: 'Bạn đã coppy mã giới thiệu!');
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.white,
                  width: 0.8,
                ),
              ),
              child: Text(
                "2Z8YCB7V",
                style: AppTextStyle.textSizeBold_16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Nhấn để sao chép",
            style: AppTextStyle.textSize_13.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 20),
          AppButton(
            width: Get.width * 0.5,
            height: 34,
            textSize: 15,
            bgrColor: Colors.white,
            textColor: AppColors.mainTextColor,
            radius: 4,
            title: 'Chia sẻ mã',
            onPress: () {
              FunctionUtil.shareDefault("NCHHSGHJBD");
            },
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildMenu(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.colorAcc,
      ),
      width: width,
      child: Column(
        children: [
          buildAppButton(
            title: 'Danh sách đơn hàng',
            onPress: () {
              Get.to(() => ListOrderPage());
            },
          ),
          SizedBox(height: 10),
          buildAppButton(
            title: 'Yêu cầu thanh toán',
            onPress: () {},
          ),
          SizedBox(height: 10),
          buildAppButton(
            title: 'Lịch sử thanh toán',
            onPress: () {},
          ),
        ],
      ),
    );
  }

  Widget buildInput(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 12),
      width: width,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Đổi mã khuyến mãi của thẻ quà tặng",
            style: AppTextStyle.textSize_15.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 22),
          AppButton(
            width: Get.width * 0.5,
            height: 34,
            radius: 4,
            bgrColor: AppColors.colorBtnBlue,
            title: 'Nhập mã của bạn',
            onPress: () {
              //Get.to(() => const InfoOderPage(isPay: true));
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  AppButton buildAppButton(
      {required String title, required VoidCallback onPress}) {
    return AppButton(
      width: Get.width * 0.7,
      height: 35,
      textSize: 15,
      bgrColor: Colors.white,
      textColor: AppColors.mainTextColor,
      radius: 6,
      title: title,
      onPress: () {
        onPress();
      },
    );
  }

  Container buildMoney({
    double? marginL,
    double? marginR,
    required Color colors,
    required Color textC,
    required String title,
    required String text,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      margin: EdgeInsets.only(left: marginL ?? 0, right: marginR ?? 0),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '\$',
                  style: AppTextStyle.textSize_18.copyWith(
                    color: textC,
                  ),
                ),
              ),
              Text(
                '$title ',
                style: AppTextStyle.textSizeBold_30.copyWith(
                  color: textC,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            text,
            style: AppTextStyle.textSize_12.copyWith(
              color: textC,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalMoney(double width) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 25, left: 25, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.colorAcc,
      ),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Số dư của bạn",
            style: AppTextStyle.textSize_16.copyWith(
              color: AppColors.textWhite,
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: Get.width * 0.6,
            height: 2,
            color: Colors.white,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '\$',
                  style: AppTextStyle.textSize_24.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              Text(
                '10',
                style: AppTextStyle.textSizeBold_30.copyWith(
                  color: AppColors.textWhite,
                  fontSize: 65,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$',
                style: AppTextStyle.textSize_24.copyWith(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildAvatar(double width) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.colorItemOder,
          ),
          width: width,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(30),
                child: Icon(Icons.camera_alt_outlined),
              ),
              SizedBox(height: 10),
              Text('0312345678')
            ],
          ),
        ),
      ],
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
    required String title,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
              width: 4,
            ),
            shape: BoxShape.circle,
            color:
                isCod == false ? AppColors.colorGreenTog : Colors.transparent,
          ),
          padding: EdgeInsets.all(8),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';
import 'package:indimobi/screens/detail_project_page/widgets/item_action_widget.dart';
import 'package:indimobi/screens/detail_project_page/widgets/item_buy_widget.dart';
import 'package:indimobi/screens/detail_project_page/widgets/item_grid_widget.dart';
import 'package:indimobi/screens/detail_project_page/widgets/item_menu_widget.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_page.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class DetailProjectPage extends StatefulWidget {
  final String id;

  const DetailProjectPage({required this.id, Key? key}) : super(key: key);

  @override
  DetailProjectPageState createState() => DetailProjectPageState();
}

class DetailProjectPageState extends State<DetailProjectPage> with AutomaticKeepAliveClientMixin {
  DetailProjectVm vm = Get.put<DetailProjectVm>(DetailProjectVm());
  AppCtrl appCtrl = Get.find<AppCtrl>();

  @override
  void initState() {
    super.initState();
    vm.initData(widget.id);
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<DetailProjectVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: CustomAppBar(
        title: 'Chi tiết dự án',
        elevation: 0,
        colorTitle: AppColors.black,
      ),
      body: Column(
        children: [
          ItemActionWidget(),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                buildBody(),
                GetBuilder<DetailProjectVm>(builder: (logic) {
                  return logic.actionSelect != -1 ? ItemMenuWidget() : SizedBox();
                }),
                GetBuilder<DetailProjectVm>(
                  builder: (logic) {
                    return logic.loadStatus == LoadStatus.loading
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            color: AppColors.black.withOpacity(0.2),
                            child: Center(
                              child: LoadWidget(),
                            ),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
          ItemBuyWidget(),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: vm.scrollController,
      child: Column(
        children: [
          buildTop(),
          ItemGridWidget(id: widget.id),
          SizedBox(height: 25),
          buildBottom(),
        ],
      ),
    );
  }

  Widget buildTop() {
    return GetBuilder<DetailProjectVm>(builder: (logic) {
      return Column(
        children: [
          SizedBox(height: 25),
          SizedBox(
            width: Get.width * 0.42,
            height: Get.width * 0.42,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LayoutWidget(
                  isView: true,
                  isGrid: true,
                  isEditEmoji: false,
                  pagesEntity: logic.albumEntity.cover ?? PagesEntity(),
                ),
                GestureDetector(
                  onTap: () async {
                    final res = await Get.to(
                      () => EditPhotoPage(
                        idPage: '',
                        idAlbum: widget.id,
                        isEditCover: true,
                      ),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 250),
                    );
                    if (res != null) {
                      vm.updateCover(res);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Text('Bìa trước', style: AppTextStyle.textSize_14),
          SizedBox(height: 25),
        ],
      );
    });
  }

  Widget buildBottom() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          width: Get.width * 0.43,
          height: Get.width * 0.43,
        ),
        SizedBox(height: 15),
        Text('Bìa sau', style: AppTextStyle.textSize_14),
        SizedBox(height: 25),
        AppButton(
          height: 32,
          radius: 4,
          onPress: () {
            vm.addPage();
          },
          title: 'Thêm trang',
          bgrColor: AppColors.colorButtonGreen,
          textColor: AppColors.textWhite,
          textSize: 14,
          width: 100,
        ),
        SizedBox(height: 12),
        TextButton(
          onPressed: () {
            vm.deleteProject();
          },
          child: Text(
            'Xóa dự án',
            style: AppTextStyle.textSize_14.copyWith(
              color: AppColors.colorLoadRed,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 5),
        TextButton(
          onPressed: () {
            AppDialog.question();
          },
          child: Text(
            'Giúp đỡ? Liên hệ hỗ trợ',
            style: AppTextStyle.textSize_12.copyWith(
              color: AppColors.colorButtonGreen,
            ),
          ),
        ),
        SizedBox(height: 35),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

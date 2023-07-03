import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/create_order_page/create_order_vm.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';
import 'package:screenshot/screenshot.dart';

class CreateOrderPage extends StatefulWidget {
  final AddressEntity? address;

  CreateOrderPage({this.address});

  @override
  CreateOrderPageState createState() => CreateOrderPageState();
}

class CreateOrderPageState extends State<CreateOrderPage> {
  CreateOrderVm vm = Get.put<CreateOrderVm>(CreateOrderVm());
  AppCtrl appCtrl = Get.find<AppCtrl>();
  DetailProjectVm detailProjectVm = Get.find<DetailProjectVm>();

  @override
  void initState() {
    super.initState();

    vm.getDetailOrder(widget.address);

    vm.listenDialog.listen((value) {
      if (value) {
        vm.showDialogSuccess(context);
      }
    });

    vm.listenCall.listen((value) {
      if (value == true) {
        vm.uploadFile(vm.res);
      }
    });
    vm.listenCallGoc.listen((value) {
      if (value == true) {
        vm.uploadFileGoc(vm.res);
      }
    });
    vm.initData();
    for (int i = 0; i < vm.listPage.length; i++) {
      vm.ctrlShots.add(ScreenshotController());
    }
  }

  @override
  void dispose() {
    vm.pageCtrl.dispose();
    vm.dispose();
    Get.delete<CreateOrderVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.textWhite,
        appBar: CustomAppBar(title: 'Tạo đơn hàng'),
        body: GetBuilder<CreateOrderVm>(builder: (logic) {
          return logic.loadStatus == LoadStatus.loading
              ? Center(child: LoadWidget())
              : Column(
                  children: [
                    SizedBox(height: 25, width: Get.width),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.bgrDarkColor.withOpacity(0.9),
                      ),
                      child: GetBuilder<CreateOrderVm>(
                          id: 'page',
                          builder: (logic) {
                            return Text(
                              'Đang tải lên trang số ${logic.page + 1}/${logic.listPage.length}',
                              style: AppTextStyle.textWhiteSize_14,
                            );
                          }),
                    ),
                    Spacer(),
                    SizedBox(
                      width: Get.width * 0.75,
                      height: Get.width * 0.75,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: logic.listPage.length,
                            controller: logic.pageCtrl,
                            physics: NeverScrollableScrollPhysics(),
                            allowImplicitScrolling: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Screenshot(
                                controller: vm.ctrlShots[index],
                                key: ValueKey(index),
                                child: buildItemGrid(
                                  index: index,
                                  page: logic.listPage[index],
                                  length: logic.listPage.length,
                                  showCancel: true,
                                  isPlaceHolder: false,
                                ),
                              );
                            },
                          ),
                          Center(
                            child:
                                logic.loadUpload == LoadStatus.loading ? LoadWidget() : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(height: Get.height * 0.3),
                  ],
                );
        }));
  }

  Widget buildItemGrid({
    required int index,
    PagesEntity? page,
    required int length,
    required bool showCancel,
    required bool isPlaceHolder,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                margin: EdgeInsets.only(
                  top: 8,
                  right: index % 2 == 0 ? 0 : 8,
                  left: index % 2 != 0 ? 0 : 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 0.6),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                child: LayoutWidget(
                  isView: true,
                  isGrid: false,
                  isEditEmoji: false,
                  pagesEntity: page ?? PagesEntity(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

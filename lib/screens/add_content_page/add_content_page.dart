import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/layout_item/item_text_cover.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/screens/add_content_page/add_content_vm.dart';
import 'package:indimobi/screens/add_content_page/widgets/app_bar_item.dart';
import 'package:indimobi/screens/add_content_page/widgets/text_field.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({
    Key? key,
    required this.pagesEntity,
  }) : super(key: key);
  final PagesEntity pagesEntity;

  @override
  AddContentPageState createState() => AddContentPageState();
}

class AddContentPageState extends State<AddContentPage> {
  AddContentVm vm = Get.put<AddContentVm>(AddContentVm());

  @override
  void initState() {
    super.initState();
    vm.initData(widget.pagesEntity);
  }

  @override
  void dispose() {
    Get.delete<AddContentVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backBtn: AppBarItem(),
        leadingWidth: Get.width,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            buildBody(),
            editTextCover(),
          ],
        ),
      ),
    );
  }

  Widget editTextCover() {
    return GetBuilder<AddContentVm>(
      builder: (logic) {
        bool isCover = widget.pagesEntity.isEditCover ?? false;
        return isCover == true
            ? Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom > 100 ? 0 : 10,
                child: SafeArea(
                  bottom: true,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.colorButtonGreen,
                          width: 0.8,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(child: TextFieldWidget(isCover)),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            vm.controller.clear();
                          },
                          child: Container(
                            height: 43,
                            width: 55,
                            color: AppColors.colorGrayOk,
                            child: Center(
                              child: Text(
                                'OK',
                                style: AppTextStyle.textSize_14.copyWith(
                                  color: AppColors.colorButtonGreen,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox();
      },
    );
  }

  Widget buildBody() {
    bool isCover = widget.pagesEntity.isEditCover ?? false;
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 55),
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: Get.width * (isCover == false ? 0.84 : 0.82),
          width: Get.width * 0.82,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LayoutWidget(
                isView: true,
                pagesEntity: widget.pagesEntity,
                isEditText: true,
              ),
              GetBuilder<AddContentVm>(builder: (logic) {
                return isCover == true
                    ? ItemTextCover(
                        index: logic.indexCover != 1 ? logic.indexCover : 0,
                        isEditText: true,
                        texts: logic.listText,
                        width: Get.width * 0.8,
                        height: Get.width * 0.8,
                        onChange: (index) {
                          FocusScope.of(context).requestFocus(vm.focusNode);
                          vm.onChangeText(index);
                        },
                      )
                    : SizedBox();
              }),
              buildInputCover(isCover),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputCover(bool isCover) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: isCover == false
          ? Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey, width: 0.4),
                  right: BorderSide(color: Colors.grey, width: 0.4),
                  bottom: BorderSide(color: Colors.grey, width: 0.4),
                ),
                color: Colors.white,
              ),
              child: TextFieldWidget(isCover),
            )
          : SizedBox(),
    );
  }
}

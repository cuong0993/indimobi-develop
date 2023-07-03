import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/layout_item/layout_widget.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/packages/drs_widget/drs_widget.dart';
import 'package:indimobi/screens/add_emoji_page/add_emoji_vm.dart';

class AddEmojiPage extends StatefulWidget {
  final Widget imageWidget;
  final List<StickersEntity> stickers;
  final PagesEntity pagesEntity;

  AddEmojiPage({
    required this.imageWidget,
    required this.stickers,
    required this.pagesEntity,
  });

  @override
  AddEmojiPageState createState() => AddEmojiPageState();
}

class AddEmojiPageState extends State<AddEmojiPage> {
  AddEmojiVm vm = Get.put<AddEmojiVm>(AddEmojiVm());

  @override
  void initState() {
    super.initState();
    vm.initData(widget.stickers);
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<AddEmojiVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildImage() {
    return SizedBox(
      height: Get.width * 0.8,
      width: Get.width * 0.8,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LayoutWidget(
            isView: true,
            isGrid: false,
            isEditEmoji: true,
            pagesEntity: widget.pagesEntity,
          ),
          //SizedBox(),
          Center(child: GetBuilder<AddEmojiVm>(builder: (logic) {
            List<Widget> list = logic.listSticker.map((e) {
              return DRSWidget(
                isEdit: true,
                isGrid: false,
                id: e.idLocal,
                nameImage: e.image,
                isSelect: e.idLocal == logic.sticker.idLocal,
                stickers: e,
                onSelect: (id) {
                  vm.selectEmoji(id);
                },
                onUpdate: (offset, scaleFactor, rotation, isFlip) {
                  vm.updatePosition(
                    offset: offset,
                    scaleFactor: scaleFactor,
                    rotation: rotation,
                    isFlip: isFlip,
                  );
                },
                onDelete: () {
                  vm.removeEmoji();
                },
              );
            }).toList();
            return Stack(fit: StackFit.expand, children: list);
          })),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        buildImage(),
        SizedBox(height: 25),
        Spacer(),
        Container(
          width: Get.width,
          height: 0.3,
          color: AppColors.buttonColorGrey,
        ),
        SizedBox(height: 5),
        buildOptionLayout(height: 50, isMenu: true, listEmoji: listEmojiMenu),
        SizedBox(height: 8),
        GetBuilder<AddEmojiVm>(
          builder: (logic) {
            return SafeArea(
              child: buildOptionLayout(
                height: 82,
                isMenu: false,
                listEmoji: logic.listEmojiContent,
              ),
            );
          },
        ),
        SizedBox(height: 5),
      ],
    );
  }

  CustomAppBar buildAppBar() {
    return CustomAppBar(
      title: '',
      isBack: true,
      isDone: true,
      leadingWidth: 100,
      onPressDone: () {
        vm.saveSticker();
      },
      backBtn: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 5, top: 8, bottom: 8),
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.ios_share,
              size: 25,
              color: AppColors.colorButtonGreen,
            ),
          ),
          GestureDetector(
            onTap: () {
              vm.deleteAllEmoji();
            },
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 14, top: 8, bottom: 6),
              color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.delete_outline_rounded,
                size: 25,
                color: AppColors.colorButtonGreen,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOptionLayout(
      {required double height, required bool isMenu, required List<String> listEmoji}) {
    return Container(
      color: isMenu ? Colors.transparent : AppColors.colorItemOder,
      height: height + (isMenu ? 0 : 16),
      margin: EdgeInsets.only(top: isMenu ? 0 : 5),
      padding: EdgeInsets.symmetric(vertical: isMenu ? 0 : 16),
      child: GetBuilder<AddEmojiVm>(builder: (logic) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: listEmoji.length,
          padding: EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (isMenu) {
                  vm.updateIndexLayout(index);
                } else {
                  vm.addEmoji(listEmoji[index]);
                }
              },
              child: Container(
                width: height,
                height: height,
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: isMenu
                      ? Border(
                          bottom: BorderSide(
                            color: logic.indexLayout == index
                                ? AppColors.colorButtonGreen
                                : Colors.transparent,
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Image.asset(listEmoji[index]),
              ),
            );
          },
        );
      }),
    );
  }
}

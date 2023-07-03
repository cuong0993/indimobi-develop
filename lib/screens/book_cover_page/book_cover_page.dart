import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_list_path.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/book_cover_page/book_cover_vm.dart';
import 'package:indimobi/widgets/app_buttons/app_button.dart';

class BookCoverPage extends StatefulWidget {
  final List<XFile> images;
  final String type;
  final String name;

  BookCoverPage({
    required this.images,
    required this.type,
    required this.name,
  });

  @override
  BookCoverPageState createState() => BookCoverPageState();
}

class BookCoverPageState extends State<BookCoverPage> with AutomaticKeepAliveClientMixin {
  BookCoverVm vm = Get.put<BookCoverVm>(BookCoverVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    Get.delete<BookCoverVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: CustomAppBar(title: 'Chọn kiểu bìa'),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: buildListCover(),
                ),
                GetBuilder<BookCoverVm>(builder: (logic) {
                  return logic.loadStatus == LoadStatus.loading ? LoadWidget() : SizedBox();
                }),
              ],
            ),
          ),
          buildBuy(),
        ],
      ),
    );
  }

  Widget buildListCover() {
    return GetBuilder<BookCoverVm>(builder: (logic) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Get.width * 0.5,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 15,
        ),
        itemCount: imageCovers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              vm.updateSelect(coverLayouts[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: logic.type == coverLayouts[index]
                      ? AppColors.colorGreen
                      : AppColors.textWhite,
                  width: 2,
                ),
              ),
              child: FadeInImage(
                image: AssetImage(imageCovers[index]),
                fit: BoxFit.cover,
                height: Get.width,
                width: Get.width,
                fadeInDuration: Duration(milliseconds: 150),
                fadeOutDuration: Duration(milliseconds: 150),
                placeholder: AssetImage(AppImages.imgSplash),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildBuy() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      width: Get.width,
      color: AppColors.colorBottomBar,
      child: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<BookCoverVm>(
              builder: (logic) {
                return AppButton(
                  height: 35,
                  radius: 3,
                  onPress: () async {
                    if (logic.loadStatus != LoadStatus.loading) {
                      List<List<int>> list = [];
                      for (int i = 0; i < widget.images.length; i++) {
                        list.add(await widget.images[i].readAsBytes());
                      }
                      await vm.createAlbum(
                        context: context,
                        names: widget.name,
                        listFile: widget.images,
                        listInt: list,
                        typeAlbum: widget.type,
                      );
                    }
                  },
                  title: 'Tạo album',
                  bgrColor: AppColors.colorButtonGreen,
                  textColor: AppColors.textWhite,
                  textSize: 14,
                  width: 130,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

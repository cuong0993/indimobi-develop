import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/load_widget_white.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/photo_books_page/photo_books_vm.dart';

class PhotoBooksPage extends StatefulWidget {
  final String name;

  const PhotoBooksPage({required this.name, Key? key}) : super(key: key);

  @override
  PhotoBooksPageState createState() => PhotoBooksPageState();
}

class PhotoBooksPageState extends State<PhotoBooksPage>
    with AutomaticKeepAliveClientMixin {
  PhotoBooksVm vm = Get.put<PhotoBooksVm>(PhotoBooksVm());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PhotoBooksVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(
        title: 'Photo Books'.toUpperCase(),
        colorTitle: AppColors.black,
      ),
      body: Stack(
        children: [
          buildAlbum(),
          GetBuilder<PhotoBooksVm>(
            builder: (logic) {
              return logic.loadStatus == LoadStatus.loading
                  ? Container(
                      width: Get.width,
                      height: Get.height,
                      color: AppColors.black.withOpacity(0.2),
                      child: Center(child: LoadWidget()),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget buildAlbum() {
    List<String> nameImg = [
      AppImages.imgDimensPhoto15,
      AppImages.imgDimensPhoto20,
      AppImages.imgDimensPhoto25,
      AppImages.imgDimensPhoto30,
    ];
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: GestureDetector(
            onTap: () async {
              vm.getImages(index, widget.name);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.colorBlue,
              ),
              child: Column(
                children: [
                  Image.asset(
                    nameImg[index],
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 205,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Photo Book',
                              style: AppTextStyle.textSize_16.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${(index + 3) * 5}x${(index + 3) * 5}cm',
                              style: AppTextStyle.textSize_14,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.textWhite,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              'Chọn'.toUpperCase(),
                              style: AppTextStyle.textSize_14,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              width: 12,
                              child:
                                  Icon(Icons.navigate_next_outlined, size: 22),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_images.dart';
import 'package:indimobi/commons/app_shadows.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/components/item_project_home.dart';
import 'package:indimobi/generated/l10n.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/screens/account_detail_page/account_detail_page.dart';
import 'package:indimobi/screens/current_project_page/current_project_page.dart';
import 'package:indimobi/screens/main_home_page/main_home_vm.dart';
import 'package:indimobi/screens/product_option_page/product_option_page.dart';
import 'package:indimobi/widgets/app_buttons/app_button_next.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  MainHomeVm vm = Get.put<MainHomeVm>(MainHomeVm());

  @override
  void initState() {
    super.initState();
    vm.initData();
    vm.login();
  }

  @override
  void dispose() {
    Get.delete<MainHomeVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBrg,
      appBar: buildAppBar(),
      body: GetBuilder<MainHomeVm>(builder: (logic) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: buildBody(),
        );
      }),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          const SizedBox(height: 5),
          AppButtonNext(
            onPress: () {
              Get.to(
                () => const AccountDetailPage(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 250),
              );
            },
            bgrColor: Colors.blue,
            radius: 30,
            height: 38,
            title: 'Quản lý tài sản',
            subTitle: '\$0.00',
          ),
          const SizedBox(height: 15),
          buildItemProject(),
          const SizedBox(height: 5),
          buildListPhoto(),
          buildHelp(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget buildHelp() {
    List<String> nameImg = [
      AppImages.icHelp,
      AppImages.icVideo,
      AppImages.icContact,
    ];
    List<String> titles = [
      S.of(context).txt_help,
      S.of(context).txt_video,
      S.of(context).txt_contact,
    ];
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.boxShadowAllProject,
      ),
      child: ListView.separated(
        itemCount: 3,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Image.asset(
                  nameImg[index],
                  color: Colors.black54,
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  titles[index],
                  style: AppTextStyle.textSize_16,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  Widget buildListPhoto() {
    List<String> nameImg = [
      AppImages.imgPhotoBook,
      AppImages.imgMagnets,
      AppImages.imgCalendars,
    ];
    List<String> title = [
      'Photo Books',
      'Ảnh in',
      'Lịch',
    ];
    return ListView.builder(
      itemCount: nameImg.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            switch (index) {
              case 0:
                final res = await Get.to(
                  () => const ProductOptionPage(),
                  transition: Transition.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 250),
                );
                if (res == null) {
                  vm.initData();
                }
                break;
              case 1:
                //Get.to(() => const AccountDetailPage());
                break;
              case 2:
                //Get.to(() => const AccountDetailPage());
                break;
            }
          },
          child: Container(
            width: Get.width,
            height: 210,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadows.boxShadowAllProject,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    nameImg[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    margin: const EdgeInsets.only(bottom: 15),
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: AppShadows.boxShadow,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            title[index].toUpperCase(),
                            style: AppTextStyle.textSizeBold_12.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.navigate_next,
                          size: 16,
                          color: AppColors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItemProject() {
    return GetBuilder<MainHomeVm>(builder: (logic) {
      if (logic.currentAlbum.cover != null) {
        PagesEntity? cover = logic.currentAlbum.cover;
        return GestureDetector(
          onTap: () async {
            final res = await Get.to(() => const CurrentProjectPage());
            if (res == null) {
              vm.initData();
            }
          },
          child: ItemProjectHome(
            totalProject: logic.listProject.length,
            imageLayout: cover?.layout ?? '',
            image: (cover?.photos?.length == 0) ? '' : (cover?.photos?[0].path ?? ''),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

  Widget buildAlbum() {
    return Container(
      height: 140,
      color: AppColors.textWhite,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: AppShadows.boxShadow,
                  ),
                  margin: const EdgeInsets.only(right: 25),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Album',
                style: AppTextStyle.textSize_14.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.navigate_next,
                size: 16,
                color: AppColors.mainTextColor,
              ),
            ],
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Image.asset(
        AppImages.imgSplash,
        height: 40,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            AppDialog.question();
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 13, bottom: 8, left: 10, right: 16),
            margin: EdgeInsets.only(right: 5),
            child: Image.asset(
              AppImages.icQuestion,
              width: 25,
              height: 25,
              color: AppColors.colorButtonGreen,
            ),
          ),
        ),
      ],
      elevation: 1.0,
    );
  }
}

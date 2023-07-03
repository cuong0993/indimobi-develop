import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/components/app_bar_custom.dart';
import 'package:indimobi/components/item_current_project.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/screens/current_project_page/current_project_vm.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_page.dart';

class CurrentProjectPage extends StatefulWidget {
  const CurrentProjectPage({Key? key}) : super(key: key);

  @override
  CurrentProjectPageState createState() => CurrentProjectPageState();
}

class CurrentProjectPageState extends State<CurrentProjectPage> {
  CurrentProjectVm vm = Get.put<CurrentProjectVm>(CurrentProjectVm());

  @override
  void initState() {
    super.initState();
    vm.initData();
  }

  @override
  void dispose() {
    Get.delete<CurrentProjectVm>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: CustomAppBar(
        title: 'Dự án hiện tại',
        colorTitle: AppColors.black,
      ),
      body: buildAlbum(),
    );
  }

  Widget buildAlbum() {
    return GetBuilder<CurrentProjectVm>(builder: (logic) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.listProject.length,
        padding: EdgeInsets.only(top: 16, bottom: 25),
        itemBuilder: (context, index) {
          PagesEntity cover = logic.listProject[index].cover ?? PagesEntity();
          return GestureDetector(
            onTap: () async {
              final res = await Get.to(
                () => DetailProjectPage(id: logic.listProject[index].id ?? ''),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 250),
              );
              if (res == null) {
                vm.initData();
              }
            },
            child: ItemCurrentProject(
              name: logic.listProject[index].name ?? '',
              image: cover.photos?.length == 0 ? '' : (cover.photos?[0].path ?? ''),
              imageLayout: cover.layout ?? '',
              type: logic.listProject[index].type ?? '',
            ),
          );
        },
        separatorBuilder: (context, index) => Container(
          height: 0.3,
          width: Get.width,
          color: Colors.black54,
        ),
      );
    });
  }
}

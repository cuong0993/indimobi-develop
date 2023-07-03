import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:indimobi/commons/app_style.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';

class ItemMenuWidget extends StatefulWidget {
  const ItemMenuWidget({Key? key}) : super(key: key);

  @override
  State<ItemMenuWidget> createState() => _ItemMenuWidgetState();
}

class _ItemMenuWidgetState extends State<ItemMenuWidget> {
  DetailProjectVm vm = Get.find<DetailProjectVm>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProjectVm>(builder: (logic) {
      List<String> list =
          (logic.actionSelect == 2) ? logic.listSort : logic.listOption;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: () {
            vm.updateActionSelect(-1);
          },
          child: Container(
            color: Colors.black.withOpacity(0.2),
            width: Get.width,
            height: Get.height,
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 200),
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 5,
                      curve: Curves.easeIn,
                      child: FadeInAnimation(
                        duration: const Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: () {
                            vm.updateIndexSelect(
                              index,
                              list[index],
                            );
                          },
                          child: Container(
                            height: 40,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.25),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                list[index],
                                style: AppTextStyle.textSize_14.copyWith(
                                  color: list[index] == 'Xóa dự án'
                                      ? Colors.red
                                      : Colors.black87,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

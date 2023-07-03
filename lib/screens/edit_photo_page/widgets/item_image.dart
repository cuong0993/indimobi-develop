import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/screens/edit_photo_page/edit_photo_vm.dart';

class ItemImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditPhotoVm vm = Get.find();

    return SizedBox(
      height: 72,
      child: GetBuilder<EditPhotoVm>(
          id: 'img_list',
          builder: (logic) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: logic.listPathImage.length,
              padding: EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (context, index) {
                return LongPressDraggable(
                  data: logic.listPathImage[index],
                  feedback: buildImageItem(
                    index,
                    logic.listPathImage[index],
                    sizeItem: 80,
                  ),
                  child: buildImageItem(index, logic.listPathImage[index]),
                  onDragEnd: (details) {
                    vm.dragAndUpdateImage(
                      details.offset,
                      logic.listPathImage[index],
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 5),
            );
          }),
    );
  }

  Widget buildImageItem(int index, String imagePath, {double? sizeItem}) {
    return Stack(
      children: [
        Image.file(
          File(imagePath),
          errorBuilder: (c, e, s) {
            return SizedBox();
          },
          width: sizeItem ?? 72,
          height: sizeItem ?? 72,
          fit: BoxFit.cover,
        ),
        // Container(
        //   width: sizeItem ?? 72,
        //   height: sizeItem ?? 72,
        //   color:
        //       index == 0 ? Colors.transparent : Colors.black.withOpacity(0.2),
        // ),
        // index != 0
        //     ? Positioned(
        //         right: 5,
        //         top: 5,
        //         child: Container(
        //           height: 16,
        //           width: 16,
        //           decoration:
        //               BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        //           child: Center(
        //             child: Icon(
        //               Icons.check,
        //               color: Colors.white,
        //               size: 10,
        //             ),
        //           ),
        //         ),
        //       )
        //     : SizedBox(),
      ],
    );
  }
}

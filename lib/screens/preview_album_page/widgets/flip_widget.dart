// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indimobi/commons/app_images.dart';
// import 'package:indimobi/commons/app_list_path.dart';
// import 'package:indimobi/commons/app_shadows.dart';
// import 'package:indimobi/components/image_file_cpn.dart';
// import 'package:indimobi/components/layout_cpn.dart';
// import 'package:indimobi/models/entity/page_entity.dart';
// import 'package:indimobi/models/entity/photo_entity.dart';
// import 'package:indimobi/models/entity/stiker_entity.dart';
// import 'package:indimobi/packages/drs_widget/drs_widget.dart';
// import 'package:indimobi/screens/preview_album_page/preview_album_vm.dart';
// import 'package:indimobi/screens/preview_album_page/widgets/app_bar_widget.dart';
//
// class PreviewAlbumPage extends StatefulWidget {
//   final List<PagesEntity> listPage;
//
//   PreviewAlbumPage({required this.listPage});
//
//   @override
//   State<PreviewAlbumPage> createState() => PreviewAlbumPageState();
// }
//
// class PreviewAlbumPageState extends State<PreviewAlbumPage>
//     with TickerProviderStateMixin {
//   PreviewAlbumVm vm = Get.put<PreviewAlbumVm>(PreviewAlbumVm());
//
//   int index = 0;
//   bool isLeft = true;
//
//   late AnimationController ctrlSlide;
//   late AnimationController ctrlFlipLeft;
//   late AnimationController ctrlFlipRight;
//   late Animation aniSlide;
//   late Animation aniFlip;
//   late Animation aniFlipLeft;
//   late Animation aniFlipRight;
//
//   @override
//   void initState() {
//     super.initState();
//     vm.initListPage(widget.listPage);
//
//     ctrlSlide = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 600),
//     );
//     ctrlFlipLeft = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 600),
//     );
//     ctrlFlipRight = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 600),
//     );
//     aniSlide = Tween<Offset>(
//       begin: Offset(0, 0),
//       end: Offset(Get.width * 0.25 - 6, 0),
//     ).animate(
//       CurvedAnimation(parent: ctrlSlide, curve: Curves.linear),
//     )..addListener(() {
//         setState(() {});
//       });
//
//     aniFlip = Tween(begin: 0.0, end: 1.0).animate(ctrlSlide)
//       ..addListener(() {
//         setState(() {});
//       });
//     aniFlipLeft = Tween(begin: 0.0, end: 1.0).animate(ctrlFlipLeft)
//       ..addListener(() {
//         setState(() {});
//         if (aniFlipLeft.value == 1) {
//           print('aniFlipLeft finish');
//         }
//         if (aniFlipLeft.value == 0) {
//           print('aniFlipLeft start');
//         }
//       });
//     aniFlipRight = Tween(begin: 1.0, end: 0.0).animate(ctrlFlipRight)
//       ..addListener(() {
//         setState(() {});
//         if (aniFlipRight.value == 1) {
//           print('aniFlipRight finish');
//         }
//         if (aniFlipRight.value == 0) {
//           print('aniFlipRight start');
//         }
//       });
//   }
//
//   @override
//   void dispose() {
//     Get.delete<PreviewAlbumVm>();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Image.asset(
//               AppImages.imgBgr,
//               width: Get.width,
//               height: Get.height,
//               fit: BoxFit.fill,
//             ),
//             Center(
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Transform.translate(
//                       offset: aniSlide.value,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           buildContainer(
//                             child: GestureDetector(
//                               onTap: () {
//                                 ctrlSlide.reverse();
//                               },
//                               child: aniFlip.value > 0
//                                   ? GetBuilder<PreviewAlbumVm>(
//                                       builder: (logic) {
//                                       return buildItemGrid(
//                                         index: logic.index + 1,
//                                         page: logic.listPage[logic.index + 1],
//                                       );
//                                     })
//                                   : SizedBox(),
//                             ),
//                           ),
//                           buildPageCover(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: aniFlip.value == 1
//                         ? Container(
//                             height: Get.width * 0.5 - 24,
//                             width: Get.width,
//                             margin: EdgeInsets.symmetric(horizontal: 12),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: GetBuilder<PreviewAlbumVm>(
//                                       builder: (logic) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         if (logic.index == 0) {
//                                           ctrlSlide.reverse();
//                                         } else {
//                                           vm.updateIndex(logic.index - 1);
//                                           ctrlFlipRight.reset();
//                                           ctrlFlipRight.forward();
//                                         }
//                                       },
//                                       child: buildItemGrid(
//                                         index: logic.index,
//                                         page: logic.listPage[logic.index],
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                                 Expanded(
//                                   child: GetBuilder<PreviewAlbumVm>(
//                                       builder: (logic) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         vm.updateLeft(  1);
//                                         ctrlFlipLeft.reset();
//                                         ctrlFlipLeft.forward();
//                                       },
//                                       child: buildItemGrid(
//                                         index: logic.index + 2,
//                                         page: vm.listPage[logic.index + 2],
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : SizedBox(),
//                   ),
//                   (aniFlipLeft.value != 1 && aniFlipLeft.value != 0)
//                       ? GetBuilder<PreviewAlbumVm>(builder: (logic) {
//                           return Align(
//                             alignment: Alignment.centerRight,
//                             child: Transform(
//                               transform: Matrix4.identity()
//                                 ..setEntry(3, 2, 0.001)
//                                 ..rotateY(pi * aniFlipLeft.value),
//                               child: aniFlipLeft.value > 0.5
//                                   ? buildFlip(
//                                       child: buildItemGrid(
//                                       index: logic.index + 1,
//                                       page: logic.listPage[logic.index + 1],
//                                     ))
//                                   : buildFlip(
//                                       child: buildItemGrid(
//                                       index: logic.index + 2,
//                                       page: logic.listPage[logic.index + 2],
//                                     )),
//                             ),
//                           );
//                         })
//                       : SizedBox(),
//                   (aniFlipRight.value != 1 && aniFlipRight.value != 0)
//                       ? GetBuilder<PreviewAlbumVm>(builder: (logic) {
//                           return Align(
//                             alignment: Alignment.centerRight,
//                             child: Transform(
//                               transform: Matrix4.identity()
//                                 ..setEntry(3, 2, 0.001)
//                                 ..rotateY(pi * aniFlipRight.value),
//                               child: aniFlipRight.value > 0.5
//                                   ? buildFlip(
//                                       child: buildItemGrid(
//                                       index: logic.index + 1,
//                                       page: logic.listPage[logic.index + 1],
//                                     ))
//                                   : buildFlip(
//                                       child: buildItemGrid(
//                                       index: logic.index + 2,
//                                       page: logic.listPage[logic.index + 2],
//                                     )),
//                             ),
//                           );
//                         })
//                       : SizedBox(),
//                 ],
//               ),
//             ),
//             AppBarWidget(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildPageCover() {
//     return buildContainer(
//       child: Transform(
//         transform: Matrix4.identity()
//           ..setEntry(3, 2, 0.001)
//           ..rotateY(pi * aniFlip.value),
//         child: GestureDetector(
//           onTap: () {
//             ctrlSlide.forward();
//           },
//           child: aniFlip.value > 0.5
//               ? Transform(
//                   alignment: Alignment.center,
//                   transform: Matrix4.rotationY(pi),
//                   child: GetBuilder<PreviewAlbumVm>(builder: (logic) {
//                     return buildItemGrid(
//                       index: logic.index,
//                       page: logic.listPage[logic.index],
//                     );
//                   }),
//                 )
//               : GetBuilder<PreviewAlbumVm>(builder: (logic) {
//                   if (logic.appCtrl.currentAlbum.cover != null) {
//                     Photos? photos =
//                         logic.appCtrl.currentAlbum.cover?.photos?[0];
//                     String? text = logic.appCtrl.currentAlbum.cover?.layout;
//                     int index =
//                         typeCovers.indexWhere((element) => element == text);
//                     return Stack(
//                       children: [
//                         ImageFileCpn(image: photos?.path ?? ''),
//                         Image.asset(namePngCover[index], fit: BoxFit.cover),
//                       ],
//                     );
//                   } else {
//                     return SizedBox();
//                   }
//                 }),
//         ),
//       ),
//     );
//   }
//
//   Widget buildContainer({required Widget child}) {
//     return Container(
//       height: Get.width * 0.5 - 24,
//       width: Get.width * 0.5 - 12,
//       margin: EdgeInsets.symmetric(horizontal: 12),
//       child: child,
//     );
//   }
//
//   Widget buildFlip({required Widget child}) {
//     return Container(
//       height: Get.width * 0.5 - 24,
//       width: Get.width * 0.5,
//       child: child,
//     );
//   }
//
//   Widget buildItemGrid({
//     required int index,
//     PagesEntity? page,
//     List<PagesEntity>? listPage,
//   }) {
//     String? image1;
//     String? image2;
//     String? image3;
//     String? image4;
//     int length = page?.photos?.length ?? 0;
//     List<Photos> photos = page?.photos ?? [];
//
//     for (int i = 0; i < length; i++) {
//       if (photos[i].index == 0) {
//         image1 = photos[i].path;
//       }
//       if (photos[i].index == 1) {
//         image2 = photos[i].path;
//       }
//       if (photos[i].index == 2) {
//         image3 = photos[i].path;
//       }
//       if (photos[i].index == 3) {
//         image4 = photos[i].path;
//       }
//     }
//     List<StickersEntity> listSticker = [];
//     listSticker = page?.stickers ?? [];
//
//     List<DRSWidget>? listIcon = [];
//     listIcon = listSticker.map((e) {
//       return DRSWidget(
//         id: '',
//         isGrid: true,
//         nameImage: e.image,
//         stickers: e,
//       );
//     }).toList();
//
//     return Container(
//       width: Get.width,
//       height: Get.height,
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey, width: 0.4),
//         color: Colors.white,
//         boxShadow: AppShadows.boxShadowInfo,
//       ),
//       child: (index == 0 || index == (listPage?.length ?? 0 - 1))
//           ? SizedBox()
//           : Stack(
//               children: [
//                 LayoutCpn(
//                   image1: image1,
//                   image2: image2,
//                   image3: image3,
//                   image4: image4,
//                   pagesEntity: page ?? PagesEntity(),
//                 ),
//                 Stack(
//                   children: listIcon.toList(),
//                 ),
//               ],
//             ),
//     );
//   }
// }

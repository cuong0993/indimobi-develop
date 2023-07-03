import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/models/enums/load_status.dart';
import 'package:indimobi/screens/book_cover_page/book_cover_page.dart';
import 'package:indimobi/utils/function_utils.dart';
import 'package:indimobi/widgets/app_dialog/app_dialog.dart';

class PhotoBooksVm extends GetxController {
  AppCtrl appCtrl = Get.find<AppCtrl>();

  LoadStatus loadStatus = LoadStatus.initial;
  List<String> type = [
    '15X15',
    '20X20',
    '25X25',
    '30X30',
  ];

  void getImages(int index, String name) async {
    loadStatus = LoadStatus.loading;
    update();
    List<XFile> images = await FunctionUtil.getMultiPhoto();
    loadStatus = LoadStatus.success;
    update();
    if (images.length > 11) {
      Get.to(
        () => BookCoverPage(
          images: images,
          type: type[index],
          name: name,
        ),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 250),
      );
    } else {
      print(images.length);
      if (images.length != 0) {
        AppDialog.messages(
          message: 'Chọn tối thiểu 12 ảnh!',
          onTapOk: () {
            Get.back();
          },
        );
      }
    }
  }
}

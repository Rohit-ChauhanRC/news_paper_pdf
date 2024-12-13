import 'package:get/get.dart';

import '../controllers/downloaded_folder_controller.dart';

class DownloadedFolderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadedFolderController>(
      () => DownloadedFolderController(),
    );
  }
}

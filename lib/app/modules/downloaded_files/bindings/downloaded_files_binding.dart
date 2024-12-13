import 'package:get/get.dart';

import '../controllers/downloaded_files_controller.dart';

class DownloadedFilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadedFilesController>(
      () => DownloadedFilesController(),
    );
  }
}

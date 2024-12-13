import 'package:get/get.dart';

import '../controllers/show_pdf_controller.dart';

class ShowPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowPdfController>(
      () => ShowPdfController(),
    );
  }
}

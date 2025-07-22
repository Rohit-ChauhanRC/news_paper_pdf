import 'package:get/get.dart';

class ShowPdfController extends GetxController {
  //
  final RxString _pdfPath = "".obs;
  String get pdfPath => _pdfPath.value;
  set pdfPath(String str) => _pdfPath.value = str;

  final RxString _pageCount = "".obs;
  String get pageCount => _pageCount.value;
  set pageCount(String str) => _pageCount.value = str;

  @override
  void onInit() {
    super.onInit();
    pdfPath = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

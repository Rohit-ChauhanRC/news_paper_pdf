import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/folder_creation.dart';
import 'package:news_paper_pdf/app/utils/connectivity_service.dart';

init() async {
  Get.lazyPut(() => FolderCreation());
  Get.lazyPut(() => ConnectivityService());
}

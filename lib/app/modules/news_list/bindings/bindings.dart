import 'package:get/get.dart';

import '../controllers/controller.dart';

class NewsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsListController>(() => NewsListController());
  }
}

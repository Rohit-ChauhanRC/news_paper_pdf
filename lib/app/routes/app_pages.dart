import 'package:get/get.dart';
import 'package:news_paper_pdf/app/modules/news_list/bindings/bindings.dart';
import 'package:news_paper_pdf/app/modules/news_list/views/view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const CHECK = Routes.NEWSLIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NEWSLIST,
      page: () => const NewsListPage(),
      binding: NewsListBinding(),
    ),
  ];
}

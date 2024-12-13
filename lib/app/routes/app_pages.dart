import 'package:get/get.dart';

import '../modules/downloaded_files/bindings/downloaded_files_binding.dart';
import '../modules/downloaded_files/views/downloaded_files_view.dart';
import '../modules/downloaded_folder/bindings/downloaded_folder_binding.dart';
import '../modules/downloaded_folder/views/downloaded_folder_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/news_list/bindings/bindings.dart';
import '../modules/news_list/views/view.dart';
import '../modules/show_pdf/bindings/show_pdf_binding.dart';
import '../modules/show_pdf/views/show_pdf_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const CHECK = Routes.HOME;

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
    GetPage(
      name: _Paths.DOWNLOADED_FILES,
      page: () => const DownloadedFilesView(),
      binding: DownloadedFilesBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOADED_FOLDER,
      page: () => const DownloadedFolderView(),
      binding: DownloadedFolderBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_PDF,
      page: () => const ShowPdfView(),
      binding: ShowPdfBinding(),
    ),
  ];
}

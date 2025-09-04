import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_paper_pdf/app/data/folder_creation.dart';
import 'package:news_paper_pdf/app/data/models/news_list_model.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:news_paper_pdf/app/utils/connectivity_service.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

  final folder = Get.find<FolderCreation>();

  final connectivityService = Get.find<ConnectivityService>();

  static final box = GetStorage();

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  final RxList<NewsListModel> _newsList = <NewsListModel>[].obs;
  List<NewsListModel> get newsList => _newsList;
  set newsList(List<NewsListModel> lst) => _newsList.assignAll(lst);

  final RxInt _currentPageIndex = 0.obs;
  int get currentPageIndex => _currentPageIndex.value;
  set currentPageIndex(int currentPageIndex) =>
      _currentPageIndex.value = currentPageIndex;

  final List<String> folderNames = [
    'Hindu Analysis',
    'Times of India',
    'Economic Times',
    'Financial Express',
    'The Telegraph',
    'Deccan Chronicle',
    'The Statesman',
    'The Tribune',
    'The Asian Age',
    'The Pioneer',
    'Free Press Journal',
    'दैनिक जागरण',
    'जनसत्ता',
    'राजस्थान पत्रिका',
    'नवभारत टाइम्स',
    'प्रभात खबर',
    'अमर उजाला',
    'हरी भूमि',
    'राष्ट्रीय सहारा',
    'दैनिक नवज्योति',
    'दैनिक भास्कर',
    'लोकसत्ता',
    'पंजाब केसरी',
  ];

  @override
  void onInit() async {
    // downloadedFolderController.onInit();

    await folder.createAppFolderStructure();

    await loadNews();
    super.onInit();
  }

  gotoDailyNewsPaper({required String id, required String name}) {
    Get.toNamed(Routes.NEWSLIST, arguments: [id, name]);
  }

  Future<void> loadNews() async {
    final String response =
        await rootBundle.loadString('assets/json/news.json');
    final List<dynamic> data = json.decode(response);

    newsList
        .assignAll(data.map((json) => NewsListModel.fromMap(json)).toList());
  }
}

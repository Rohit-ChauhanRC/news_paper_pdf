import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_paper_pdf/app/data/models/news_list_model.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

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

  @override
  void onInit() async {
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

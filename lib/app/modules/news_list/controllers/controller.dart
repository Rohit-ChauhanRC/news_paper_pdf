import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:news_paper_pdf/app/data/dio_client.dart';
import 'package:news_paper_pdf/app/data/folder_creation.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';
import 'package:news_paper_pdf/app/utils/connectivity_service.dart';
import 'package:news_paper_pdf/app/utils/database_helper.dart';

class NewsListController extends GetxController {
  final FolderCreation folderCreation = Get.find<FolderCreation>();
  final connectivityService = Get.find<ConnectivityService>();
  final dbHelper = DatabaseHelper();

  final RxList<NewsArticle> _article = <NewsArticle>[].obs;
  List<NewsArticle> get article => _article;

  final RxString _title = "".obs;
  String get title => _title.value;

  final RxBool _isDownloading = false.obs;
  bool get isDownloading => _isDownloading.value;
  set isDownloading(bool b) => _isDownloading.value = b;

  String progress = "";
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final RxBool _isFetching = false.obs;
  bool get isFetching => _isFetching.value;
  set isFetching(bool b) => _isFetching.value = b;

  @override
  void onInit() async {
    super.onInit();
    _title.value = Get.arguments[1];
    await getArticleFromDb();
    // Load from DB first
  }

  Future<void> getArticleFromDb() async {
    isFetching = true;
    final cached =
        await dbHelper.getArticlesByDateAndTitle(date: today, title: title);
    if (cached.isNotEmpty) {
      _article.assignAll(cached);
    } else {
      await parseHtmlAndSave();
    }
    isFetching = false;
  }

  Future<void> parseHtmlAndSave() async {
    _article.assignAll([]);

    await DioClient()
        .getEconomicNews(endPointApi: Get.arguments[0])
        .then((onValue) async {
      final document = html_parser.parseFragment(onValue.content.rendered);
      final pTags = document.querySelectorAll("p");

      List<NewsArticle> temp = [];

      for (var p in pTags) {
        final anchors = p.querySelectorAll("a");
        for (var a in anchors) {
          final href = a.attributes['href'];
          if (href != null && href.startsWith("https://drive.google.com")) {
            final article = NewsArticle(
              link: href,
              title: p.text.replaceAll("Download Now", ""),
            );
            temp.add(article);
            await dbHelper.insertArticle(article, today);
          }
        }
      }

      // await dbHelper.clearOldArticles(today);
      _article.assignAll(temp);
    });
  }

  // keep your downloadFile() and convertToDirectDownloadLink() here

  Future<void> downloadFile(fileUrl, String title, folder) async {
    try {
      title = title.replaceAll(":", "").replaceAll("/", "");
      isDownloading = true;
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(fileUrl));
      final response = await request.close();
      final profilePicBytes =
          await consolidateHttpClientResponseBytes(response);

      final apth = await folderCreation.saveFile(
        fileBytes: profilePicBytes,
        fileName: "$title.pdf",
        subFolder: folder,
      );
      isDownloading = false;
      Get.toNamed(Routes.SHOW_PDF, arguments: apth);
      print(apth);
    } catch (e) {
      isDownloading = false;

      progress = "Error: $e";
    } finally {
      isDownloading = false;

      isDownloading = false;
    }
  }

  String convertToDirectDownloadLink(String viewLink) {
    final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(viewLink);

    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return "https://drive.google.com/uc?export=download&id=$fileId";
    } else {
      throw ArgumentError("Invalid Google Drive link");
    }
  }
}

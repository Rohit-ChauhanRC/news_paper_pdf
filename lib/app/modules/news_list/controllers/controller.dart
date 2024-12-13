import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:news_paper_pdf/app/data/dio_client.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NewsListController extends GetxController {
  final RxList<NewsArticle> _article = <NewsArticle>[].obs;
  List<NewsArticle> get article => _article;
  set article(List<NewsArticle> lst) => _article.assignAll(lst);

  final RxString _title = "".obs;
  String get title => _title.value;
  set title(String str) => _title.value = str;

  bool isDownloading = false;
  String progress = "";

  @override
  void onInit() async {
    super.onInit();
    title = Get.arguments[1];
    await pareHtml();
  }

  @override
  void dispose() {
    super.dispose();
    _article.close();
    _title.close();
  }

  Future<void> pareHtml() async {
    article.assignAll([]);

    await DioClient()
        .getEconomicNews(endPointApi: Get.arguments[0])
        .then((onValue) {
      final document = html_parser.parseFragment(onValue.content!.rendered);

      final aancP = document.querySelectorAll("p");

      for (var eq in aancP) {
        final anc = eq.querySelectorAll("a");
        for (var qq in anc) {
          final href = qq.attributes['href'];
          if (href!.startsWith("https://drive.google.com")) {
            article.add(NewsArticle(
                link: href, title: eq.text.replaceAll("Download Now", "")));
            if (kDebugMode) {
              print("${eq.text.replaceAll("Download Now", "")} -- $href");
            }
          }
        }
      }
    });
  }

  Future<void> downloadFile(fileUrl, title) async {
    try {
      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          "${directory.path}/$title.pdf"; // Replace with correct extension

      // Download the file
      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      } else {
        progress =
            "Failed to download file. Status code: ${response.statusCode}";
      }
    } catch (e) {
      progress = "Error: $e";
    } finally {
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

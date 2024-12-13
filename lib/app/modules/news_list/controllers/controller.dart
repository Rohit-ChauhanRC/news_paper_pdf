import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:news_paper_pdf/app/data/dio_client.dart';
import 'package:news_paper_pdf/app/data/folder_creation.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:html/parser.dart' as html_parser;
// import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NewsListController extends GetxController {
  //

  final FolderCreation folderCreation = Get.find<FolderCreation>();

  final RxList<NewsArticle> _article = <NewsArticle>[].obs;
  List<NewsArticle> get article => _article;
  set article(List<NewsArticle> lst) => _article.assignAll(lst);

  final RxString _title = "".obs;
  String get title => _title.value;
  set title(String str) => _title.value = str;

  final RxBool _isDownloading = false.obs;
  bool get isDownloading => _isDownloading.value;
  set isDownloading(bool b) => _isDownloading.value = b;

  String progress = "";

  @override
  void onInit() async {
    super.onInit();
    title = Get.arguments[1];
    await pareHtml();
    // folderCreation.createAppFolderStructure();
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
      final document = html_parser.parseFragment(onValue.content.rendered);

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

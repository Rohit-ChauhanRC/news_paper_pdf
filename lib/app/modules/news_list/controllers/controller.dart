import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:news_paper_pdf/app/data/dio_client.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:news_paper_pdf/app/data/models/news_model.dart';
import 'package:html/parser.dart' as html_parser;

class NewsListController extends GetxController {
  final RxList<NewsArticle> _article = <NewsArticle>[].obs;
  List<NewsArticle> get article => _article;
  set article(List<NewsArticle> lst) => _article.assignAll(lst);

  final RxString _title = "".obs;
  String get title => _title.value;
  set title(String str) => _title.value = str;

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
}

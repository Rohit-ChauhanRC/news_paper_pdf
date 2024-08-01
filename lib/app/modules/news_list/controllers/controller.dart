import 'package:get/get.dart';
import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:news_paper_pdf/app/data/dio_client.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:news_paper_pdf/app/data/models/news_model.dart';
import 'package:html/parser.dart' as html_parser;

class NewsListController extends GetxController {
  final RxList<NewsArticle> _article = <NewsArticle>[].obs;
  List<NewsArticle> get article => _article;
  set article(List<NewsArticle> lst) => _article.assignAll(lst);

  @override
  void onInit() async {
    super.onInit();
    await pareHtml();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    _article.close();
  }

  Future<void> pareHtml() async {
    article.assignAll([]);
    NewsModel newsModel = await DioClient()
        .getEconomicNews(endPointApi: Constants.economicsTimesCode);

    final document = html_parser.parseFragment(newsModel.content!.rendered);

    final aancP = document.querySelectorAll("p");

    for (var eq in aancP) {
      final anc = eq.querySelectorAll("a");
      for (var qq in anc) {
        final href = qq.attributes['href'];
        if (href!.startsWith("https://drive.google.com")) {
          article.add(NewsArticle(
              link: href, title: eq.text.replaceAll("Download Now", "")));
          print("${eq.text.replaceAll("Download Now", "")} -- $href");
        }
      }
    }
  }
}

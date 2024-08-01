import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:news_paper_pdf/app/modules/news_list/controllers/controller.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListPage extends GetView<NewsListController> {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Paper")),
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
              controller.pareHtml();
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              height: Get.height * 0.8,
              child: Obx(() => controller.article.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.article.length,
                      itemBuilder: (ctx, i) {
                        NewsArticle data = controller.article[i];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black)),
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                child: Text(data.title)),
                            InkWell(
                              onTap: () async {
                                final Uri _url = Uri.parse(data.link);
                                await launchUrl(_url);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  child: Text("GO")),
                            ),
                          ],
                        );
                      })
                  : const SizedBox()),
            ),
          ),
        ),
      ),
    );
  }
}

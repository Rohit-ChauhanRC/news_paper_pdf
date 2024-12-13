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
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/images/daily.png",
                  height: 40,
                )),
            Center(
              child: InkWell(
                onTap: () {
                  controller.pareHtml();
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: Get.height * 0.70,
                  child: Obx(() => controller.article.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.article.length,
                          itemBuilder: (ctx, i) {
                            NewsArticle data = controller.article[i];
                            return controller.isDownloading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(),
                                      const SizedBox(height: 20),
                                      Text(controller.progress),
                                    ],
                                  )
                                : ListTile(
                                    title: Text(data.title),
                                    onTap: () async {
                                      // final Uri url = Uri.parse(data.link);
                                      // await launchUrl(url);
                                      controller.downloadFile(
                                          controller
                                              .convertToDirectDownloadLink(
                                                  data.link),
                                          data.title);
                                    },
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                        // border: Border.all(color: Colors.black),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(5),
                                      child: const Text(
                                        "Click Here",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    subtitle: Text(controller.title),
                                  );
                          })
                      : const Center(child: CircularProgressIndicator())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

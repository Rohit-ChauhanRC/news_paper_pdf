import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';
import 'package:news_paper_pdf/app/modules/news_list/controllers/controller.dart';

class NewsListPage extends GetView<NewsListController> {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            "assets/images/daily.png",
            height: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Logo

            Obx(
              () => Text(
                controller.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationColor: Colors.amber,
                  decorationThickness: 2,
                ),
              ),
            ),

            // Article list
            Expanded(
              child: Obx(() {
                if (controller.article.isEmpty && !controller.isFetching) {
                  return const Center(
                    child: Text(
                      "No articles available today",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                if (controller.article.isEmpty && controller.isFetching) {
                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.parseHtmlAndSave,
                  child: ListView.builder(
                    itemCount: controller.article.length,
                    itemBuilder: (ctx, i) {
                      NewsArticle data = controller.article[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          title: Text(
                            data.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(controller.title),
                          trailing: Obx(() {
                            return controller.isDownloading
                                ? const SizedBox.shrink()
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: const Text(
                                      "Download",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                          }),
                          onTap: !controller.isDownloading
                              ? () async {
                                  await controller.downloadFile(
                                    controller
                                        .convertToDirectDownloadLink(data.link),
                                    data.title,
                                    controller.title,
                                  );
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            // Bottom progress indicator
            Obx(
              () => controller.isDownloading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

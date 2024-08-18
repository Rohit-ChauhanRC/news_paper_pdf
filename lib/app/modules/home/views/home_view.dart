import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/models/news_list_model.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        showIgnore: false,
        showLater: false,
        canDismissDialog: false,
        showReleaseNotes: true,
        upgrader: Upgrader(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/images/daily.png",
                    height: 60,
                  )),
              Container(
                margin: const EdgeInsets.all(10),
                height: Get.height * 0.75,
                child: GridView(
                  // itemCount: controller.newsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 1,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: List.generate(controller.newsList.length, (i) {
                    NewsListModel data = controller.newsList[i];
                    return ListTile(
                      onTap: () {
                        controller.gotoDailyNewsPaper(
                          id: data.code,
                          name: data.title,
                        );
                      },
                      title: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                            Text(data.title),
                            Image.asset(
                              "assets/images/${data.imagePath}",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      // child: Text(data.title),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                child: GridView.builder(
                    itemCount: controller.newsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (ctx, i) {
                      NewsListModel data = controller.newsList[i];
                      return GridTile(
                        header: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: InkWell(
                              onTap: () {
                                controller.gotoDailyNewsPaper(
                                  id: data.code,
                                  name: data.title,
                                );
                              },
                              child: Image.asset(
                                "assets/images/${data.imagePath}",
                                fit: BoxFit.cover,
                              ),
                            )),
                        child: Text(data.title),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                    height: 40,
                    fit: BoxFit.cover,
                  )),
              Obx(() => controller.newsList.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      height: Get.height - 200,
                      child: ListView.separated(
                          separatorBuilder: (context, i) {
                            return const Divider(
                              color: Colors.grey,
                              height: 2,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: controller.newsList.length,
                          itemBuilder: (ctx, i) {
                            NewsListModel data = controller.newsList[i];
                            return InkWell(
                              onTap: () {
                                controller.gotoDailyNewsPaper(
                                  id: data.code,
                                  name: data.title,
                                );
                              },
                              child: Container(
                                // height: 200,
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                      backgroundImage: Image.asset(
                                        data.imagePath,
                                        fit: BoxFit.contain,
                                        color: Colors.black,
                                      ).image,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      data.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Text(data.title),
                            );
                          }),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

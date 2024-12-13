import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/models/news_list_model.dart';
import 'package:news_paper_pdf/app/modules/downloaded_folder/views/downloaded_folder_view.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/images/daily.png",
                  height: 40,
                  fit: BoxFit.cover,
                )),
            centerTitle: true,
          ),
          body: [
            UpgradeAlert(
              dialogStyle: UpgradeDialogStyle.cupertino,
              showIgnore: false,
              showLater: false,
              canDismissDialog: false,
              showReleaseNotes: true,
              upgrader: Upgrader(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed(Routes.DOWNLOADED_FOLDER);
                  //   },
                  //   child: const Text("Downloaded"),
                  // ),
                  Obx(() => controller.newsList.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          height: Get.height * 0.69,
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
            const DownloadedFolderView(),
          ][controller.currentPageIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Colors.grey,
                indicatorColor: Colors.yellow.withOpacity(0.50),
                labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white, // Label color
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            child: NavigationBar(
              onDestinationSelected: (int index) {
                controller.currentPageIndex = index;
              },
              selectedIndex: controller.currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.newspaper),
                  icon: Icon(Icons.newspaper_outlined),
                  label: 'News Paper',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.download_done),
                  icon: Icon(Icons.download),
                  label: 'Download Folders',
                ),
              ],
            ),
          ),
        ));
  }
}

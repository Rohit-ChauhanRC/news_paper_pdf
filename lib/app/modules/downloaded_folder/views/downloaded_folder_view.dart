import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';

import '../controllers/downloaded_folder_controller.dart';

class DownloadedFolderView extends GetView<DownloadedFolderController> {
  const DownloadedFolderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
            itemCount: controller.folderNames.length,
            itemBuilder: (ctx, i) {
              return ListTile(
                onTap: () {
                  Get.toNamed(Routes.DOWNLOADED_FILES,
                      arguments: controller.folderNames[i]);
                },
                title: Text(controller.folderNames[i]),
                leading: const Icon(
                  Icons.folder,
                  color: Colors.grey,
                ),
              );
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_paper_pdf/app/modules/home/controllers/home_controller.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';

class DownloadedFolders extends StatelessWidget {
  const DownloadedFolders({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
        },
      ),
    );
  }
}

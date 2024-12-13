import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';

import '../controllers/downloaded_files_controller.dart';

class DownloadedFilesView extends GetView<DownloadedFilesController> {
  const DownloadedFilesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Downloaded Files'),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.pdfFiles.isEmpty
              ? const Center(child: Text("No PDF files found in the directory"))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Base Path: ${controller.folderPath}"),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.pdfFiles.length,
                        itemBuilder: (context, index) {
                          final pdf = controller.pdfFiles[index];
                          return ListTile(
                            leading: const Icon(Icons.picture_as_pdf,
                                color: Colors.red),
                            title: Text(pdf['name'] ?? 'Unknown'),
                            onTap: () {
                              Get.toNamed(Routes.SHOW_PDF,
                                  arguments:
                                      "${controller.baseFold}/${pdf['name']!}");
                              // Open the PDF file
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         PdfViewerPage(pdfPath: pdf['path']!),
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }
}

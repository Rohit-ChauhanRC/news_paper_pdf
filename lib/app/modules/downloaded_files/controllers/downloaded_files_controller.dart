import 'package:get/get.dart';
import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class DownloadedFilesController extends GetxController {
  //
  List<FileSystemEntity> files = [];
  final RxString _folderPath = "".obs;
  String get folderPath => _folderPath.value;
  set folderPath(String str) => _folderPath.value = str;

  final RxList<Map<String, String>> _pdfFiles = <Map<String, String>>[].obs;
  List<Map<String, String>> get pdfFiles => _pdfFiles;
  set pdfFiles(List<Map<String, String>> lst) => _pdfFiles.assignAll(lst);

  String baseFold = '';

  @override
  void onInit() async {
    super.onInit();
    folderPath = Get.arguments;
    await listPdfFiles();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> listPdfFiles() async {
    try {
      // Get the base directory
      final Directory appDir = await getApplicationDocumentsDirectory();

      // Define the root folder
      final String rootFolderPath =
          '${appDir.path}/${Constants.appbarTitle}/$folderPath';
      final baseFolder = Directory(rootFolderPath);

      // final baseFolder = Directory(directory.path);

      // List all files and filter for PDFs
      baseFold = baseFolder.path;
      final entities = baseFolder.listSync(recursive: true);
      final pdfFilesList = entities
          .where((entity) =>
              FileSystemEntity.isFileSync(entity.path) &&
              entity.path.endsWith('.pdf'))
          .map((file) => {
                'name': file.path.split('/').last,
                'path': file.path,
              })
          .toList();

      pdfFiles = pdfFilesList;
    } catch (e) {
      print("Error reading PDF files: $e");
    }
  }
}

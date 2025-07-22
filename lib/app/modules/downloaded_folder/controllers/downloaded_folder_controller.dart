import 'dart:io';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedFolderController extends GetxController {
  //
  final RxList<String> _folderNames = <String>[].obs;
  List<String> get folderNames => _folderNames;
  set folderNames(List<String> lst) => _folderNames.assignAll(lst);

  String folderPath = "";

  @override
  void onInit() async {
    super.onInit();
    await listFolders();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> listFolders() async {
    try {
      // Get the base directory
      final Directory appDir = await getApplicationDocumentsDirectory();

      // Define the root folder
      final String rootFolderPath = '${appDir.path}/${Constants.appbarTitle}';
      final folder = Directory(rootFolderPath);

      // List only directories
      final entities = folder.listSync();
      final folders = entities
          .where((entity) => FileSystemEntity.isDirectorySync(entity.path))
          .toList();
      folderNames = folders
          .map((folder) => folder.path.split('/').last)
          .toList()
        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

      // pdfFiles

      // folderNames =
      //     folders.map((folder) => folder.path.split('/').last).toList();
      folderPath = rootFolderPath;
    } catch (e) {
      print("Error reading folders: $e");
    }
  }
}

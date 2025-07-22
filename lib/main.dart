import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_paper_pdf/app/data/folder_creation.dart';
import './app/constants/constants.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Upgrader.clearSavedSettings();
  Get.put<FolderCreation>(FolderCreation());
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  App({super.key});
  final box = GetStorage();
  final FolderCreation folderCreation = Get.find();

  @override
  Widget build(BuildContext context) {
    folderCreation.createAppFolderStructure();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appbarTitle,
      initialRoute: AppPages.CHECK,
      getPages: AppPages.routes,
    );
  }
}

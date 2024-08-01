import 'package:flutter/material.dart';

import 'package:get/get.dart';
import './app/constants/constants.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  await Upgrader.clearSavedSettings();

  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  App({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appbarTitle,
      initialRoute: AppPages.CHECK,
      getPages: AppPages.routes,
    );
  }
}

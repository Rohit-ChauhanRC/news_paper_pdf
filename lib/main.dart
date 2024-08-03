import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import './app/constants/constants.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Upgrader.clearSavedSettings();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD2PKaXnyxn3gVFcYK_DViXogAEJmE7IyU",
          authDomain: "dailynews-bbcb0.firebaseapp.com",
          projectId: "dailynews-bbcb0",
          storageBucket: "dailynews-bbcb0.appspot.com",
          messagingSenderId: "334579430217",
          appId: "1:334579430217:web:565378f63f3283bac1a098",
          measurementId: "G-5N8LL15TH6"),
    );
  }

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

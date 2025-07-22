import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:news_paper_pdf/app/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class FolderCreation {
  Future<void> createAppFolderStructure() async {
    try {
      final status = await Permission.storage.request();
      // final statusAndroid = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final Directory appDir = await getApplicationDocumentsDirectory();

        // Define the root folder
        final String rootFolderPath = '${appDir.path}/${Constants.appbarTitle}';

        // Define subfolders
        final List<String> subFolders = [
          '$rootFolderPath/Hindu Analysis',
          '$rootFolderPath/Times of India',
          '$rootFolderPath/Economic Times',
          '$rootFolderPath/Financial Express',
          '$rootFolderPath/The Telegraph',
          '$rootFolderPath/Deccan Chronicle',
          '$rootFolderPath/The Statesman',
          '$rootFolderPath/The Tribune',
          '$rootFolderPath/The Asian Age',
          '$rootFolderPath/The Pioneer',
          '$rootFolderPath/Free Press Journal',
          '$rootFolderPath/दैनिक जागरण',
          '$rootFolderPath/जनसत्ता',
          '$rootFolderPath/राजस्थान पत्रिका',
          '$rootFolderPath/नवभारत टाइम्स',
          '$rootFolderPath/प्रभात खबर',
          '$rootFolderPath/अमर उजाला',
          '$rootFolderPath/हरी भूमि',
          '$rootFolderPath/राष्ट्रीय सहारा',
          '$rootFolderPath/दैनिक नवज्योति',
          '$rootFolderPath/दैनिक भास्कर',
          '$rootFolderPath/लोकसत्ता',
          '$rootFolderPath/पंजाब केसरी',
        ];

        // Create the root and subfolders
        for (final folder in subFolders) {
          final Directory dir = Directory(folder);
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          } else {
            if (kDebugMode) {
              print(dir.path);
            }
          }
        }
      } else {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
      }
      // print("App folder structure created successfully.");
    } catch (e) {
      print("Error creating folder structure: $e");
    }
  }

  Future<String> saveFile({
    required String subFolder,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();

      final String subFolderPath =
          '${appDir.path}/${Constants.appbarTitle}/$subFolder';

      final Directory dir = Directory(subFolderPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final File file = File('$subFolderPath/$fileName');
      await file.writeAsBytes(fileBytes);
      // return file.path;
      return "$subFolderPath/$fileName";
    } catch (e) {
      print("Error saving file: $e");
      return "error!";
    }
  }

  String getImageName(String imagePath) {
    // Get the image file name with extension from the path
    return path.basename(imagePath); // e.g., "image.jpg"
  }

  String getImageExtension(String imagePath) {
    // Get the file extension
    return path.extension(imagePath); // e.g., ".jpg"
  }

  //  Future<void> listFiles() async {
  //   try {
  //     // Get the folder path
  //     final Directory appDir = await getApplicationDocumentsDirectory();

  //     final String subFolderPath = '${appDir.path}/DailyNewsPaper/$subFolder';
  //     final folder = Directory(subFolderPath.path);

  //     // List files and directories
  //     final folderFiles = folder.listSync();

  //     setState(() {
  //       files = folderFiles;
  //       folderPath = directory.path;
  //     });
  //   } catch (e) {
  //     print("Error reading folder: $e");
  //   }
  // }
}

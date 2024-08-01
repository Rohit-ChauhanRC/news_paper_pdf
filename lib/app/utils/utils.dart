import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/constants/constants.dart';

class Utils {
  //
  const Utils._();

  static void closeKeyboard() {
    final currentFocus = Get.focusScope;
    // if (!currentFocus.hasPrimaryFocus) {
    currentFocus!.unfocus();
    // }
  }

  static void showDialog(
    String message, {
    String? title,
    bool success = false,
    Function()? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();
          return true;
        },
        title: title ?? Constants.success,
        content: Text(
          message ?? Constants.error,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: TextStyle(
            color: Colors.purple[90],
            fontSize: 16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Get.back();

              onTap?.call();
            },
            child: Text(
              "ok",
              textAlign: TextAlign.center,
              maxLines: 6,
              style: TextStyle(
                color: Colors.purple[90],
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
}

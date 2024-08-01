import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        showIgnore: false,
        showLater: false,
        canDismissDialog: false,
        showReleaseNotes: true,
        upgrader: Upgrader(),
        child: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                pullToRefreshController: controller.pullToRefreshController,
                key: controller.webViewKey,
                initialUrlRequest: URLRequest(
                    url: WebUri(
                        "http://app.maklife.in:8016/index.php/Login/${"Check_Login/${controller.mobileNumber}"}")),
                initialSettings: controller.settings,
                onWebViewCreated: (cx) {
                  controller.webViewController = cx;
                  if (kDebugMode) {
                    print("login: $cx");
                  }
                  controller.loadCookies();
                },
                onLoadStop: (cx, url) async {
                  controller.circularProgress = false;
                  // await controller.saveCookies(url!);
                  if (kDebugMode) {
                    print("Pulkit: $url");
                  }
                  // if ("http://app.maklife.in:8016/index.php/Login/after_login" ==
                  //     url.toString()) {
                  //   await launchUrl(
                  //     Uri.parse(
                  //         "http://app.maklife.in:8016/index.php/Home/after_login"),
                  //     mode: LaunchMode.inAppWebView,
                  //   );
                  // }
                },
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onProgressChanged: (cx, progress) {
                  controller.progress = progress / 100;
                  controller.circularProgress = false;
                },
                onConsoleMessage: (cx, consoleMessage) {
                  if (kDebugMode) {
                    print(consoleMessage);
                  }
                },
                shouldOverrideUrlLoading: (cx, navigationAction) async {
                  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
                  final shouldPerformDownload =
                      navigationAction.shouldPerformDownload ?? false;
                  final url = navigationAction.request.url;
                  if (shouldPerformDownload && url != null) {
                    controller.circularProgress = true;
                    await controller.downloadFile(url.toString());
                    return NavigationActionPolicy.DOWNLOAD;
                  }
                  // }
                  return NavigationActionPolicy.ALLOW;
                },
                onDownloadStartRequest: (cx, request) async {
                  if (kDebugMode) {
                    print('onDownloadStart ${request.url.toString()}');
                  }

                  await controller.downloadFile(
                      request.url.toString(), request.suggestedFilename);
                },
              ),
              Positioned(
                  top: Get.height * 0.5,
                  child: Obx(() => controller.circularProgress == true
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.blue,
                        ))
                      : Container())),
              // Obx(() => Container(
              //     padding: const EdgeInsets.all(10.0),
              //     child: controller.progress < 1.0
              //         ? LinearProgressIndicator(value: controller.progress)
              //         : Container())),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:isolate';
import 'dart:ui';
import 'package:open_filex/open_filex.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '/app/constants/constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

  static final box = GetStorage();

  final cookieManager = CookieManager();

  // var no = box.read(Constants.cred);

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  // WebViewController webViewController = WebViewController();

  InAppWebViewController? webViewController;

  final ReceivePort _port = ReceivePort();

  InAppWebViewSettings settings = InAppWebViewSettings(
      useShouldOverrideUrlLoading: true,
      clearCache: false,
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow:
          "camera; microphone;storage;mediaLibrary;photosAddOnly;Photos",
      iframeAllowFullscreen: true,
      allowFileAccessFromFileURLs: true,
      allowContentAccess: true,
      allowFileAccess: true,
      allowsBackForwardNavigationGestures: true,
      useOnDownloadStart: true,
      allowUniversalAccessFromFileURLs: true,
      javaScriptEnabled: true,
      useOnLoadResource: true);

  PullToRefreshController? pullToRefreshController;

  Future<void> permisions() async {
    await Permission.storage.request();
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
    await Permission.microphone.request();
    await Permission.photos.request();
    await Permission.notification.request();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    mobileNumber = box.read(Constants.cred) ?? Get.arguments;
    await permisions();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );

    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data;

    //   if (status == DownloadTaskStatus.complete) {
    //     ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    //       content: Text("Download $id completed!"),
    //     ));
    //   }
    // });
    // FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onReady() {
    super.onReady();
    print("cookies : ${box.read('cookies')}");
  }

  @override
  void onClose() {
    super.onClose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  saveCookies(WebUri url) async {
    final cookies = await cookieManager.getCookies(url: url);
    final cookieStrings =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').toList();

    await box.write('cookies', cookieStrings);
  }

  loadCookies() async {
    final cookies = box.read('cookies') ?? [];
    for (var cookie in cookies) {
      final parts = cookie.split(';');
      final nameValue = parts[0].split('=');
      final name = nameValue[0];
      final value = nameValue[1];
      await cookieManager.setCookie(
        url: WebUri.uri(Uri.parse("http://app.maklife.in:8016/index.php")),
        name: name,
        value: value,
        domain: 'app.maklife',
        path: '/',
        // isSecure: true,
        sameSite: HTTPCookieSameSitePolicy.NONE,
      );
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void handleClick(WebUri url) async {
    await webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(url.toString())));
  }

  Future<void> downloadFile(String url, [String? filename]) async {
    circularProgress = true;
    var hasStoragePermission = await Permission.storage.isGranted;
    if (!hasStoragePermission) {
      final status = await Permission.storage.request();
      hasStoragePermission = status.isGranted;
    }
    // if (hasStoragePermission) {

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      // optional: header send with url (auth token etc)
      savedDir: (await getApplicationDocumentsDirectory()).path,
      saveInPublicStorage: true,
      showNotification: true,
      openFileFromNotification: true,
      fileName: filename,
      allowCellular: true,
    ).then((value) async {
      circularProgress = false;
      OpenFilex.open(
          "${(await getApplicationDocumentsDirectory()).path}/$filename");
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("Download $filename completed!"),
      ));
    });

    // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    //   content: Text("Download $filename completed!"),
    // ));
    // }
  }
}

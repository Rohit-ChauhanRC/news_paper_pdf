import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_paper_pdf/app/modules/news_list/views/htmlP.dart';
import '/app/constants/constants.dart';

import 'models/news_model.dart';

class DioClient {
  // const Services._();

  final dio = Dio();
  final _baseUrl = Constants.baseUrl;

  Future<NewsModel> getEconomicNews({required String endPointApi}) async {
    try {
      Response response = await dio.get(
        _baseUrl + endPointApi,
      );
      // debugPrint(
      //   _baseUrl + Constants.sendOtp,
      // );

      // debugPrint(
      //   response.toString(),
      // );
      return NewsModel.fromMap(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return NewsModel(
        content: Content(rendered: htmlP),
        id: 836,
      );
    }
  }

  // final options = BaseOptions(
  //   baseUrl: 'https://api.pub.dev',
  //   connectTimeout: Duration(seconds: 5),
  //   receiveTimeout: Duration(seconds: 3),
  // );

  // final anotherDio = Dio(options);
}

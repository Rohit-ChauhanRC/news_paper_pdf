import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      return NewsModel();
    }
  }

  // final options = BaseOptions(
  //   baseUrl: 'https://api.pub.dev',
  //   connectTimeout: Duration(seconds: 5),
  //   receiveTimeout: Duration(seconds: 3),
  // );

  // final anotherDio = Dio(options);
}

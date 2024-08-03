import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_paper_pdf/app/data/models/news_list_model.dart';
import 'package:news_paper_pdf/app/routes/app_pages.dart';
import '/app/constants/constants.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

  static final box = GetStorage();

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  List<NewsListModel> newsList = [
    NewsListModel(
      code: Constants.hinduCode,
      title: Constants.hinduAnalysis,
      imagePath: "the_hindu.png",
    ),
    NewsListModel(
      code: Constants.timesOfIndiaCode,
      title: Constants.timesofIndia,
      imagePath: "times_of_india.png",
    ),
    NewsListModel(
      code: Constants.economicsTimesCode,
      title: Constants.economicTimes,
      imagePath: "et.png",
    ),
    NewsListModel(
      code: Constants.financialExpressCode,
      title: Constants.financialExpress,
      imagePath: "financial_express.jpeg",
    ),
    NewsListModel(
      code: Constants.telegrapghCode,
      title: Constants.theTelegraph,
      imagePath: "the_telegraph.png",
    ),
    NewsListModel(
      code: Constants.deccanChronicleCode,
      title: Constants.deccanChronicle,
      imagePath: "deccan_chronical.jpeg",
    ),
    NewsListModel(
      code: Constants.tribuneCode,
      title: Constants.theTribune,
      imagePath: "the_tribune.jpeg",
    ),
    NewsListModel(
      code: Constants.pioneerCode,
      title: Constants.thePioneer,
      imagePath: "pioneer.jpeg",
    ),
    NewsListModel(
      code: Constants.statesmanCode,
      title: Constants.theStatesman,
      imagePath: "the_stateman.png",
    ),
    NewsListModel(
      code: Constants.asiannAgeCode,
      title: Constants.theAsianAge,
      imagePath: "the_asian_age.jpeg",
    ),
    NewsListModel(
      code: Constants.freePressJournalCode,
      title: Constants.freePressJournal,
      imagePath: "fress_press.png",
    ),
    NewsListModel(
      code: Constants.danikJagranCode,
      title: Constants.danikJagran,
      imagePath: "danik_jagran.png",
    ),
    NewsListModel(
      code: Constants.danikBhaskarCode,
      title: Constants.danikBhaskar,
      imagePath: "danik_bhaskar.jpeg",
    ),
    NewsListModel(
      code: Constants.danikNavjyotiCode,
      title: Constants.danikNavjyoti,
      imagePath: "danik_navjyoti.png",
    ),
    NewsListModel(
      code: Constants.jansattaCode,
      title: Constants.jansatta,
      imagePath: "jansatta.png",
    ),
    NewsListModel(
      code: Constants.rajasthanCode,
      title: Constants.rajasthanPatrika,
      imagePath: "rajasthan.png",
    ),
    NewsListModel(
      code: Constants.navbharatCode,
      title: Constants.naavbharatTimes,
      imagePath: "navbharat.png",
    ),
    NewsListModel(
      code: Constants.paarbhatCode,
      title: Constants.parbhatKhabar,
      imagePath: "parbhat.png",
    ),
    NewsListModel(
      code: Constants.rastriyaCode,
      title: Constants.rastriyaSahara,
      imagePath: "rastriya.jpeg",
    ),
    NewsListModel(
      code: Constants.amarCode,
      title: Constants.amarUjalaa,
      imagePath: "amar.jpeg",
    ),
    NewsListModel(
      code: Constants.hariBhumiCode,
      title: Constants.hariBhumi,
      imagePath: "hari.png",
    ),
    NewsListModel(
      code: Constants.loksattaCode,
      title: Constants.loksatta,
      imagePath: "loksatta.png",
    ),
    NewsListModel(
      code: Constants.punjabCode,
      title: Constants.punjabKeshri,
      imagePath: "punjab.png",
    ),
  ];

  gotoDailyNewsPaper({required String id, required String name}) {
    Get.toNamed(Routes.NEWSLIST, arguments: [id, name]);
  }
}

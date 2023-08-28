import 'dart:developer';

import 'package:get/get.dart';
import 'package:tech_application/Models/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/Models/podcast_model.dart';
import 'package:tech_application/Models/poster_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster;
  RxList<ArticleModel> topArticlesList = RxList();
  RxList<PodcastModel> topPodcastsList = RxList();
  RxList<HashtagModel> tagsList = RxList();

  @override
  void onInit() {
    super.onInit();
    getHomeItems();
  }

  Future getHomeItems() async {
    var response = await DioService().getMethod(ApiConstant.getHomeItems);

    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        topArticlesList.add(ArticleModel.fromJson(element));
      });
      response.data['top_podcasts'].forEach((element) {
        topPodcastsList.add(PodcastModel.fromJson(element));
      });
      topPodcastsList.removeRange(0, 3);
    }
  }
}

import 'package:get/get.dart';
import 'package:tech_application/Models/article/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/Models/podcast/podcast_home_model.dart';
import 'package:tech_application/Models/poster_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<ArticleModel> topArticlesList = RxList();
  RxList<PodcastHomeModel> topPodcastsList = RxList();
  RxList<HashtagModel> tagsList = RxList();
  RxList<HashtagModel> selectedTags = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getHomeItems();
  }

  Future getHomeItems() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiConstant.getHomeItems);

    if (response.statusCode == 200) {
      poster.value = PosterModel.fromJson(response.data['poster']);

      response.data['tags'].forEach((element) {
        tagsList.add(HashtagModel.fromJson(element));
      });
      tagsList.removeWhere((element) => element.title == "اخبار");
      tagsList.removeWhere((element) => element.title == "اخبار فیلم و سریال");

      response.data['top_visited'].forEach((element) {
        topArticlesList.add(ArticleModel.fromJson(element));
      });

      response.data['top_podcasts'].forEach((element) {
        topPodcastsList.add(PodcastHomeModel.fromJson(element));
      });
      topPodcastsList.removeRange(0, 5);

      loading.value = false;
    }
  }
}

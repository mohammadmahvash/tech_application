import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/article/article_info_model.dart';
import 'package:tech_application/Models/article/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleInfoController extends GetxController {
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<ArticleModel> relatedArticle = RxList();
  RxList<HashtagModel> relatedTags = RxList();
  RxBool loading = false.obs;

  Future getArticleInfo(String id) async {
    articleInfoModel = ArticleInfoModel().obs;
    loading.value = true;

    String? userId = GetStorage().read(MyStorage.userId);

    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}article/get.php?command=info&id=$id&user_id=$userId");

    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

      relatedArticle.clear();
      response.data["related"].forEach((element) {
        relatedArticle.add(ArticleModel.fromJson(element));
      });
      relatedArticle.removeWhere((element) => element.author == null);
      relatedArticle.removeWhere((element) => element.author == "");
      relatedArticle.removeWhere((element) => element.author == "''");
      relatedArticle.removeWhere((element) => element.title == "تست");

      relatedTags.clear();
      response.data["tags"].forEach((element) {
        relatedTags.add(HashtagModel.fromJson(element));
      });
      relatedTags.removeWhere((element) => element.title == "اخبار");
      relatedTags
          .removeWhere((element) => element.title == "اخبار فیلم و سریال");

      loading.value = false;
      Get.toNamed(MyRoute.routeArticleSinglePageInfo);
    }
  }
}

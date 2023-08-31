import 'dart:developer';

import 'package:get/get.dart';
import 'package:tech_application/Models/article_info_model.dart';
import 'package:tech_application/Models/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleInfoController extends GetxController {
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<ArticleModel> relatedArticle = RxList();
  RxList<HashtagModel> relatedTags = RxList();
  RxBool loading = false.obs;

  Future getArticleInfo() async {
    loading.value = true;
    // TODO userId is hardCode
    var userId = "";

    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}article/get.php?command=info&id=$id&user_id=$userId");
    // var response = await DioService().getMethod(
    //     "https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=$id&user_id=1");

    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

      response.data["related"].forEach((element) {

        relatedArticle.add(ArticleModel.fromJson(element));
      });
      relatedArticle.removeWhere((element) => element.author == null);
      relatedArticle.removeWhere((element) => element.author == "");
      relatedArticle.removeWhere((element) => element.author == "''");
      relatedArticle.removeWhere((element) => element.title == "تست");

      response.data["tags"].forEach((element) {
        relatedTags.add(HashtagModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}

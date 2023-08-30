import 'package:get/get.dart';
import 'package:tech_application/Models/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleInfoController extends GetxController {
  RxInt id = RxInt(-1);
  RxList<ArticleModel> relatedArticle = RxList();
  RxList<HashtagModel> relatedTags = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getArticleInfo();
  }

  Future getArticleInfo() async {
    loading.value = true;
    // TODO remember to add userId
    var response = await DioService().getMethod(ApiConstant.getArticleList);

    if (response.statusCode == 200) {
      // response.data.forEach((element) {
      //   articleList.add(ArticleModel.fromJson(element));
      // });
      loading.value = false;
    }
  }
}

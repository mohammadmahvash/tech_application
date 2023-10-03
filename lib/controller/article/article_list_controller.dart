import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/article/article_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/component/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleListController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getArticleList();
  }

  Future getArticleList() async {
    loading.value = true;
    String? userId = GetStorage().read(MyStorage.userId);
    var response =
        await DioService().getMethod(ApiConstant.getArticleList+userId.toString());
        

    if (response.statusCode == 200) {
      articleList.clear();
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  Future getArticleListByTagId(String id) async {
    loading.value = true;
    String? userId = GetStorage().read(MyStorage.userId);
    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=$userId");
    if (response.statusCode == 200) {
      articleList.clear();
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}

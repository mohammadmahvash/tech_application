import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/article_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/component/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleManagementController extends GetxController {
  RxList articleList = RxList.empty();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getArticleManagementList();
  }

  getArticleManagementList() async {
    String userId = GetStorage().read(MyStorage.userId);
    loading.value = true;

    var response = await DioService().getMethod(
        // "${ApiConstant.baseURL}article/get.php?command=published_by_me&user_id=$userId");
        "${ApiConstant.baseURL}article/get.php?command=published_by_me&user_id=1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}

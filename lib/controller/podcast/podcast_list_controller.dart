import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/podcast/podcast_list_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/component/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';

class PodcastListController extends GetxController {
  RxList<PodcastListModel> podcastList = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPodcastList();
  }

  Future getPodcastList() async {
    loading.value = true;
    // String userId = GetStorage().read(MyStorage.userId);
    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}podcast/get.php?command=new&user_id=");


    if (response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastListModel.fromJson(element));
      });
      podcastList.removeRange(0, 5);
      loading.value = false;
    }
  }
}

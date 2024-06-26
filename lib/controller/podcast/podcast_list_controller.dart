import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/podcast/podcast_list_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/constant/my_storage.dart';
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
    String? userId = GetStorage().read(MyStorage.userId);
    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}podcast/get.php?command=new&user_id=$userId");


    if (response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastListModel.fromJson(element));
      });
      podcastList.removeRange(0, 2);
      loading.value = false;
    }
  }
}

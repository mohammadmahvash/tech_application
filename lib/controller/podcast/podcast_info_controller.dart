import 'package:get/get.dart';
import 'package:tech_application/Models/podcast/podcast_info_model.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class PodcastInfoController extends GetxController {
  RxList<PodcastInfoModel> podcastEpisodesList = RxList();
  RxBool loading = false.obs;
  

  getPodcastEpisodesList(String id) async {
    loading.value = true;
    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}podcast/get.php?command=get_files&podcats_id=$id");

    if (response.statusCode == 200) {
      podcastEpisodesList.clear();
      response.data["files"].forEach((element) {
        podcastEpisodesList.add(PodcastInfoModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/podcast/podcast_home_model.dart';
import 'package:tech_application/Models/podcast/podcast_info_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';

class PodcastManagementController extends GetxController {
  RxList podcastList = RxList.empty();
  Rx<PodcastInfoModel> podcastInfoModel = PodcastInfoModel().obs;
  
  // ArticleInfoModel(
  //         MyStrings.titltArticleManagementSinglePageInfoDefault,
  //         MyStrings
  //             .editOrginalContentTextArticleManagementSinglePageInfoDefault,
  //         Assets.images.singlePlaceHolder.path)
  //     .obs;
  TextEditingController textEditingController = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // articleInfoModel.value.image = "";
    getPodcastManagementList();
  }

  getPodcastManagementList() async {
    String? userId = GetStorage().read(MyStorage.userId);
    loading.value = true;

    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}podcast/get.php?command=published_by_me&user_id=$userId");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastHomeModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  // storeArticle() async {
  //   FilePickerController filePickerController =
  //       Get.find<FilePickerController>();
  //   loading.value = true;

  //   Map<String, dynamic> map = {
  //     'title': articleInfoModel.value.title,
  //     'content': articleInfoModel.value.content,
  //     'cat_id': articleInfoModel.value.categoryId,
  //     'tag_list': "$selectedTagsId",
  //     'user_id': GetStorage().read(MyStorage.userId),
  //     'image': await dio.MultipartFile.fromFile(
  //         filePickerController.file.value.path!),
  //     'command': "store",
  //   };
  //   var response = await DioService().postMethod(map, ApiConstant.postArticle);
  //   log(response.data.toString());

  //   var statusCode = response.data["status_code"];
  //   loading.value = false;

  //   switch (statusCode) {
  //     case 201:
  //       Get.snackbar(MyStrings.success, MyStrings.articleStoreSuccesful,
  //           backgroundColor: Colors.greenAccent);
  //       break;
  //     case 401:
  //       Get.snackbar(MyStrings.error, MyStrings.notAuthorizedError,
  //           backgroundColor: Colors.redAccent);
  //       break;
  //     case 403:
  //       Get.snackbar(
  //         MyStrings.error,
  //         MyStrings.invalidTokenError,
  //         backgroundColor: Colors.redAccent,
  //       );
  //       break;
  //     case 500:
  //       Get.snackbar(
  //         MyStrings.error,
  //         MyStrings.serverError,
  //         backgroundColor: Colors.redAccent,
  //       );
  //       break;
  //   }
  //   Get.offNamed(MyRoute.routeArticleManagementList);
  // }

  updatePodcastTitle() {
    podcastInfoModel.update((val) {
      val!.title = textEditingController.text;
    });
  }

  // updateMainTextArticle(String content) {
  //   podcastInfoModel.update((val) {
  //     val!.content = content;
  //   });
  // }
}

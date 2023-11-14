import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/podcast/podcast_home_model.dart';
import 'package:tech_application/Models/podcast/podcast_info_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/controller/file_picker_controller.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/services/dio_service.dart';

class PodcastManagementController extends GetxController {
  RxList podcastList = RxList.empty();
  Rx<PodcastInfoModel> podcastInfoModel = PodcastInfoModel(
    MyStrings.titltArticleManagementSinglePageInfoDefault,
  ).obs;

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

  storePodcast() async {
    FilePickerController filePickerController =
        Get.find<FilePickerController>();
    loading.value = true;

    Map<String, dynamic> map = {
      'podcast_id': podcastInfoModel.value.podcastId,
      'title': podcastInfoModel.value.title,
      'length': podcastInfoModel.value.length,
      'file': await dio.MultipartFile.fromFile(filePickerController.file.value.path!),
      'command': "store_file",
    };
    var response = await DioService().postMethod(map, ApiConstant.postPodcast);
    log(response.data.toString());

    var success = response.data["success"];
    loading.value = false;

    if (success == "true") {
      Get.snackbar(MyStrings.success, MyStrings.articleStoreSuccesful,
          backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar(MyStrings.error, MyStrings.errorText,
          backgroundColor: Colors.redAccent);
    }
    Get.offNamed(MyRoute.routeArticleManagementList);
  }

  updatePodcastTitle() {
    podcastInfoModel.update((val) {
      val!.title = textEditingController.text;
    });
  }
}

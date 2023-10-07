import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/Models/article/article_info_model.dart';
import 'package:tech_application/Models/article/article_model.dart';
import 'package:tech_application/Models/hashtag_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/controller/file_picker_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/services/dio_service.dart';

class ArticleManagementController extends GetxController {
  RxList articleList = RxList.empty();
  RxList<HashtagModel> relatedTags = RxList.empty();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
          MyStrings.titltArticleManagementSinglePageInfoDefault,
          MyStrings
              .editOrginalContentTextArticleManagementSinglePageInfoDefault,
          Assets.images.singlePlaceHolder.path)
      .obs;
  RxList<HashtagModel> selectedTags = RxList();
  RxList<int> selectedTagsId = RxList();
  TextEditingController textEditingController = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    articleInfoModel.value.image = "";
    getArticleManagementList();
  }

  getArticleManagementList() async {
    String? userId = GetStorage().read(MyStorage.userId);
    loading.value = true;

    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}article/get.php?command=published_by_me&user_id=$userId");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  storeArticle() async {
    FilePickerController filePickerController =
        Get.find<FilePickerController>();
    loading.value = true;

    Map<String, dynamic> map = {
      'title': articleInfoModel.value.title,
      'content': articleInfoModel.value.content,
      'cat_id': articleInfoModel.value.categoryId,
      'tag_list': "$selectedTagsId",
      'user_id': GetStorage().read(MyStorage.userId),
      'image': await dio.MultipartFile.fromFile(
          filePickerController.file.value.path!),
      'command': "store",
    };
    var response = await DioService().postMethod(map, ApiConstant.postArticle);
    log(response.data.toString());

    var statusCode = response.data["status_code"];
    loading.value = false;

    switch (statusCode) {
      case 201:
        Get.snackbar(MyStrings.success, MyStrings.articleStoreSuccesful,
            backgroundColor: Colors.greenAccent);
        break;
      case 401:
        Get.snackbar(MyStrings.error, MyStrings.notAuthorizedError,
            backgroundColor: Colors.redAccent);
        break;
      case 403:
        Get.snackbar(
          MyStrings.error,
          MyStrings.invalidTokenError,
          backgroundColor: Colors.redAccent,
        );
        break;
      case 500:
        Get.snackbar(
          MyStrings.error,
          MyStrings.serverError,
          backgroundColor: Colors.redAccent,
        );
        break;
    }
    Get.offNamed(MyRoute.routeArticleManagementList);
  }

  updateArticleTitle() {
    articleInfoModel.update((val) {
      val!.title = textEditingController.text;
    });
  }

  updateMainTextArticle(String content) {
    articleInfoModel.update((val) {
      val!.content = content;
    });
  }
}

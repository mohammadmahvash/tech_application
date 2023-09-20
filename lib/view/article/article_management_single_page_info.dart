import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/dimensions.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_route.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';
import 'package:tech_application/controller/article/article_management_controller.dart';
import 'package:tech_application/controller/file_picker_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/services/file_picker.dart';
import 'package:tech_application/view/article/article_content_html_editor.dart';

class ArticleManagementSinglePageInfo extends StatelessWidget {
  ArticleManagementSinglePageInfo({super.key});

  final ArticleManagementController articleManagementInfoController =
      Get.find<ArticleManagementController>();

  final FilePickerController filePickerController =
      Get.put(FilePickerController());

  showEditTitleDialog() {
    Get.defaultDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.images.techbot.path, width: 30),
              const SizedBox(width: 8),
              Column(
                children: [
                  const SizedBox(height: 15),
                  Text(MyStrings.selectShortTitle,
                      style: Get.textTheme.headlineMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: articleManagementInfoController.textEditingController,
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
                hintText: MyStrings.writeYourTitle,
                hintStyle: Get.theme.textTheme.labelMedium,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                )),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              //ConfirmBTN
              TextButton(
                onPressed: () {
                  articleManagementInfoController.updateArticleTitle();
                  Get.back();
                },
                child: Text(MyStrings.verification,
                    style: Get.textTheme.headlineMedium),
              ),
              //CancelBTN
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child:
                    Text(MyStrings.later, style: Get.textTheme.headlineMedium),
              ),
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(right: 10, left: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() => articleManagementInfoController.loading.value == false
            ? Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          width: Get.width,
                          height: Get.height / 3,
                          child: filePickerController.file.value.size == 0
                              ? CachedNetworkImage(
                                  imageUrl: articleManagementInfoController
                                      .articleInfoModel.value.image!,
                                  imageBuilder: (context, imageProvider) =>
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: Get.height / 3.5,
                                          child: Image(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),
                                  placeholder: (context, url) => Column(
                                        children: [
                                          const SizedBox(height: 80),
                                          circularLoading(),
                                        ],
                                      ),
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
                                        width: double.maxFinite,
                                        height: Get.height / 3.5,
                                        child: Image.asset(
                                          Assets.images.singlePlaceHolder.path,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                              : Image.file(
                                  File(filePickerController.file.value.path
                                      .toString()),
                                  fit: BoxFit.cover,
                                )),
                      Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.singleAppbarGradient,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: InkWell(
                              onTap: () => pickFile(),
                              child: Container(
                                height: Get.height / 20,
                                width: Get.width / 3,
                                decoration: const BoxDecoration(
                                    color: SolidColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      MyStrings.selectImage,
                                      style: Get.theme.textTheme.labelMedium,
                                    ),
                                    const Icon(Icons.add,
                                        color: Colors.white, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.bodyMargin / 3),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //EditTitleArticle
                        InkWell(
                          onTap: () => showEditTitleDialog(),
                          child: BluePenTitle(
                              title: MyStrings.editTitleArticle, bodyMargin: 0),
                        ),
                        Row(
                          children: [
                            Text(
                              articleManagementInfoController
                                  .articleInfoModel.value.title!,
                              style: Get.theme.textTheme.headlineLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        //EditMainTextArticle
                        InkWell(
                          onTap: () => Get.to(()=>ArticleContentHtmlEditor()),
                          child: BluePenTitle(
                              title: MyStrings.editMainTextArticle,
                              bodyMargin: 0),
                        ),
                        HtmlWidget(
                          articleManagementInfoController
                              .articleInfoModel.value.content!,
                          enableCaching: true,
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  circularLoading(),
                        ),
                        const SizedBox(height: 30),
                        //SelectCategory
                        BluePenTitle(
                            title: MyStrings.selectCategory, bodyMargin: 0),
                        //hashtagList(),
                        const SizedBox(height: 70),
                        //hashtag list
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: Get.width / 2.5,
                        height: Get.height / 13,
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(
                              MyRoute.routeArticleManagementSinglePageInfo),
                          child: Text(MyStrings.done),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : SizedBox(height: Get.height, child: circularLoading())),
      )),
    );
  }

  Widget hashtagList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: articleManagementInfoController.relatedTags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId =
                  articleManagementInfoController.relatedTags[index].id!;
              await Get.find<ArticleListController>()
                  .getArticleListByTagId(tagId);

              var tagName =
                  "${MyStrings.byTagName} ${articleManagementInfoController.relatedTags[index].title!}";

              Get.toNamed(MyRoute.routeArticleListScreen,
                  arguments: {'title': tagName});
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Text(
                      articleManagementInfoController.relatedTags[index].title!,
                      style: Get.theme.textTheme.titleSmall,
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}

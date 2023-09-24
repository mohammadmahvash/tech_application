import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/dimensions.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_management_controller.dart';
import 'package:tech_application/controller/file_picker_controller.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/services/file_picker.dart';
import 'package:tech_application/view/article/article_content_html_editor.dart';

class ArticleManagementSinglePageInfo extends StatelessWidget {
  ArticleManagementSinglePageInfo({super.key});

  final ArticleManagementController articleManagementInfoController =
      Get.find<ArticleManagementController>();

  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();

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
                        Text(
                          articleManagementInfoController
                              .articleInfoModel.value.title!,
                          style: Get.theme.textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        //EditMainTextArticle
                        InkWell(
                          onTap: () => Get.to(() => ArticleContentHtmlEditor()),
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
                        InkWell(
                          onTap: () => chooseCategoryBottomSheet(),
                          child: BluePenTitle(
                              title: MyStrings.selectCategory, bodyMargin: 0),
                        ),
                        //hashtag list
                        articleManagementInfoController.selectedTags.isEmpty
                            ? Text(
                                MyStrings.youHaveNotChoosenCategoryYet,
                                style: Get.theme.textTheme.headlineLarge,
                              )
                            : hashtagList(),
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
                          onPressed: () async{
                            // debugger();
                            await articleManagementInfoController
                                  .storeArticle();
                                  },
                              
                          child:
                              articleManagementInfoController.loading.value ==
                                      true
                                  ? circularLoading()
                                  : Text(MyStrings.done),
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
        itemCount: articleManagementInfoController.selectedTags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        const LinearGradient(colors: GradientColors.tags)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Text(
                    articleManagementInfoController.selectedTags[index].title!,
                    style: Get.theme.textTheme.titleSmall,
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget categories() {
    return SizedBox(
      height: Get.height / 4,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: homeScreenController.tagsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 4),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                articleManagementInfoController.articleInfoModel.value
                    .categoryId = homeScreenController.tagsList[index].id;

                articleManagementInfoController.selectedTagsId
                    .add(int.parse(homeScreenController.tagsList[index].id!));

                articleManagementInfoController.articleInfoModel.update((val) {
                  val!.id = homeScreenController.tagsList[index].id;
                  val.categoryName = homeScreenController.tagsList[index].title;
                });

                if (articleManagementInfoController.selectedTags
                    .contains(homeScreenController.tagsList[index])) {
                  Get.snackbar(
                    MyStrings.error,
                    MyStrings.cannotChooseDuplicateTag,
                    backgroundColor: Colors.redAccent,
                  );
                } else {
                  articleManagementInfoController.selectedTags
                      .add(homeScreenController.tagsList[index]);
                }
              },
              child: HashtagComponent(index: index));
        },
      ),
    );
  }

  chooseCategoryBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        persistent: true,
        Container(
          height: Get.height / 1.2,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.images.techbot.path,
                        height: Get.height / 18,
                        alignment: Alignment.topCenter),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(MyStrings.clickonCategoryToAddIntoArticle,
                            style: Get.theme.textTheme.headlineMedium),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                categories(),
                Image.asset(Assets.images.arrowdown.path, scale: 3),
                const SizedBox(height: 30),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height / 6,
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount:
                            articleManagementInfoController.selectedTags.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 5,
                                childAspectRatio: 3.5),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: GradientColors.tags)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    articleManagementInfoController
                                        .selectedTags[index].title!,
                                    style: Get.theme.textTheme.titleSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      articleManagementInfoController
                                          .selectedTags
                                          .removeAt(index);

                                      articleManagementInfoController
                                          .selectedTagsId
                                          .removeAt(index);

                                      articleManagementInfoController
                                              .articleInfoModel
                                              .value
                                              .categoryId =
                                          articleManagementInfoController
                                              .selectedTagsId.last
                                              .toString();
                                    },
                                    child: const Icon(CupertinoIcons.xmark,
                                        size: 20, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          width: Get.width / 2.25,
                          height: Get.height / 13,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(MyStrings.verification),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

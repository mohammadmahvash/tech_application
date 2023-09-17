import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_route.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';
import 'package:tech_application/controller/article/article_management_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class ArticleManagementSinglePageInfo extends StatelessWidget {
  ArticleManagementSinglePageInfo({super.key});

  final ArticleManagementController articleManagementInfoController =
      Get.find<ArticleManagementController>();

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
                      CachedNetworkImage(
                          imageUrl: articleManagementInfoController
                              .articleInfoModel.value.image!,
                          imageBuilder: (context, imageProvider) => SizedBox(
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
                          errorWidget: (context, url, error) => SizedBox(
                                width: double.maxFinite,
                                height: Get.height / 3.5,
                                child: Image.asset(
                                  Assets.images.singlePlaceHolder.path,
                                  fit: BoxFit.cover,
                                ),
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
                            child: Container(
                              height: Get.height / 20,
                              width: Get.width / 3,
                              color: SolidColors.primaryColor,
                              child: Center(
                                child: Text(
                                  "${MyStrings.selectImage} +",
                                  style: Get.theme.textTheme.labelMedium,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        editTitleArticle(),
                        const SizedBox(height: 10),
                        Text(
                          articleManagementInfoController
                              .articleInfoModel.value.title!,
                          style: Get.theme.textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        editMainTextArticle(),
                        const SizedBox(height: 10),
                        HtmlWidget(
                          articleManagementInfoController
                              .articleInfoModel.value.content!,
                          enableCaching: true,
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  circularLoading(),
                        ),
                        const SizedBox(height: 30),
                        selectCategoryTitle(),
                        const SizedBox(height: 70),
                        //hashtag list
                        //hashtagList(),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 20),
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: SizedBox(
                  //         width: Get.width / 2.5,
                  //         height: Get.height / 13,
                  //         child: ElevatedButton(
                  //           onPressed: () {},
                  //           child: Text(MyStrings.done),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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

  Row selectCategoryTitle() {
    return Row(
      children: [
        ImageIcon(
          Assets.icons.bluepen.provider(),
          color: SolidColors.seeMore,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          MyStrings.selectCategory,
          style: Get.theme.textTheme.titleMedium,
        )
      ],
    );
  }

  Row editMainTextArticle() {
    return Row(
      children: [
        ImageIcon(
          Assets.icons.bluepen.provider(),
          color: SolidColors.seeMore,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          MyStrings.editMainTextArticle,
          style: Get.theme.textTheme.titleMedium,
        )
      ],
    );
  }

  Widget editTitleArticle() {
    return Row(
      children: [
        ImageIcon(
          Assets.icons.bluepen.provider(),
          color: SolidColors.seeMore,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          MyStrings.editTitleArticle,
          style: Get.theme.textTheme.titleMedium,
        )
      ],
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

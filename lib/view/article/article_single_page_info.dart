import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_route.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_info_controller.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class ArticleSinglePageInfo extends StatelessWidget {
  ArticleSinglePageInfo({super.key});

  final ArticleInfoController articleInfoController =
      Get.find<ArticleInfoController>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() => articleInfoController.loading.value == false
            ? Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: articleInfoController
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
                                const Expanded(child: SizedBox()),
                                const Icon(
                                  Icons.bookmark_border_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () async {
                                    await Share.share(
                                        "${articleInfoController.articleInfoModel.value.title!}\n ${MyStrings.shareText}");
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          articleInfoController.articleInfoModel.value.title!,
                          style: Get.theme.textTheme.headlineLarge,
                        ),
                        Row(
                          children: [
                            Image.asset(Assets.images.profileavatar.path,
                                scale: 8),
                            const SizedBox(width: 10),
                            Text(
                                articleInfoController
                                    .articleInfoModel.value.author!,
                                style: Get.theme.textTheme.headlineMedium),
                            const SizedBox(width: 10),
                            Text(articleInfoController
                                .articleInfoModel.value.view!),
                            const SizedBox(width: 3),
                            Text(
                              MyStrings.visit,
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        HtmlWidget(
                          articleInfoController.articleInfoModel.value.content!,
                          enableCaching: true,
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  circularLoading(),
                        ),
                        const SizedBox(height: 70),
                        //hashtag list
                        hashtagList(),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            MyStrings.relatedArticle,
                            style: Get.theme.textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        //related Article
                        relatedArticles(),
                      ],
                    ),
                  )
                ],
              )
            : SizedBox(height: Get.height, child: circularLoading())),
      )),
    );
  }

  Widget relatedArticles() {
    return SizedBox(
      height: Get.height / 3.6,
      child: ListView.builder(
        itemCount: articleInfoController.relatedArticle.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              articleInfoController.getArticleInfo(
                  articleInfoController.relatedArticle[index].id!);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 5.3,
                    width: Get.width / 2.4,
                    child: CachedNetworkImage(
                      imageUrl:
                          articleInfoController.relatedArticle[index].image!,
                      imageBuilder: (context, imageProvider) => Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: GradientColors.blogPost,
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 0,
                            left: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    articleInfoController
                                        .relatedArticle[index].author!,
                                    style: Get.theme.textTheme.titleSmall),
                                Row(
                                  children: [
                                    Text(
                                      articleInfoController
                                          .relatedArticle[index].view!,
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      placeholder: (context, url) => circularLoading(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        articleInfoController.relatedArticle[index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget hashtagList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: articleInfoController.relatedTags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = articleInfoController.relatedTags[index].id!;
              await Get.find<ArticleListController>()
                  .getArticleListByTagId(tagId);

              var tagName =
                  "${MyStrings.byTagName} ${articleInfoController.relatedTags[index].title!}";

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
                      articleInfoController.relatedTags[index].title!,
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

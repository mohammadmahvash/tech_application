import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/component/constant/dimensions.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_info_controller.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final String title = Get.arguments['title'];

  final ArticleListController articleListController =
      Get.find<ArticleListController>();
  final ArticleInfoController articleInfoController =
      Get.find<ArticleInfoController>();
  @override
  Widget build(BuildContext context) {
    double bodyMargin = Dimensions.bodyMargin;

    return SafeArea(
        child: Scaffold(
      backgroundColor: SolidColors.scaffoldBackground,
      appBar: appBar(title),
      body: Obx(
        () => Padding(
          padding:
              EdgeInsets.only(left: bodyMargin / 1.9, right: bodyMargin / 1.9),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: articleListController.articleList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    articleInfoController.getArticleInfo(
                        articleListController.articleList[index].id!);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width / 4,
                        height: Get.height / 7,
                        child: CachedNetworkImage(
                          imageUrl:
                              articleListController.articleList[index].image!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          placeholder: (context, url) => circularLoading(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                                articleListController.articleList[index].title!,
                                style: Get.theme.textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    articleListController
                                        .articleList[index].author!,
                                    style: Get.theme.textTheme.labelSmall),
                                Text(
                                    "${articleListController.articleList[index].view!} ${MyStrings.visit}",
                                    style: Get.theme.textTheme.labelSmall),
                                Text(
                                    articleListController
                                        .articleList[index].categoryName!,
                                    style: Get.theme.textTheme.bodySmall),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}

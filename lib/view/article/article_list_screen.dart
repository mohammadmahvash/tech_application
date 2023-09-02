import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article_info_controller.dart';
import 'package:tech_application/controller/article_list_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key, required this.title});

  final String title;

  final ArticleListController articleListController =
      Get.put(ArticleListController());
  final ArticleInfoController articleInfoController =
      Get.put(ArticleInfoController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
      backgroundColor: SolidColors.scaffoldBackground,
      appBar: appBar(bodyMargin, textTheme, title),
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
                        width: size.width / 4,
                        height: size.height / 7,
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
                                style: textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    articleListController
                                        .articleList[index].author!,
                                    style: textTheme.labelSmall),
                                Text(
                                    "${articleListController.articleList[index].view!} ${MyStrings.visit}",
                                    style: textTheme.labelSmall),
                                Text(
                                    articleListController
                                        .articleList[index].categoryName!,
                                    style: textTheme.bodySmall),
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

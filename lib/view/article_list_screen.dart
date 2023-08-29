import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final ArticleController articleController = Get.put(ArticleController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
      backgroundColor: SolidColors.scaffoldBackground,
      appBar: appBar(bodyMargin, textTheme, MyStrings.titleAppBarArticlesList),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(left: bodyMargin/1.5, right: bodyMargin / 1.5),
          child: SizedBox(
            child: ListView.builder(
              itemCount: articleController.articleList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width / 4.2,
                        height: size.height / 8,
                        child: CachedNetworkImage(
                          imageUrl: articleController.articleList[index].image!,
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Text(articleController.articleList[index].title!,
                                style: textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3),
                                const SizedBox(height: 10),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(articleController.articleList[index].author!,
                                style: textTheme.labelSmall),
                                Text("${articleController.articleList[index].view!} ${MyStrings.visit}",
                                style: textTheme.labelSmall),
                                const SizedBox(width: 20),
                                Text(articleController.articleList[index].categoryName!,
                                style: textTheme.bodySmall),
                                  ],
                                )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}

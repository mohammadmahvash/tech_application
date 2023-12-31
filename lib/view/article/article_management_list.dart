import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article/article_info_controller.dart';
import 'package:tech_application/controller/article/article_management_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

import '../../constant/dimensions.dart';

class ArticleManagementList extends StatelessWidget {
  ArticleManagementList({super.key});

  final ArticleManagementController articleManagementController =
      Get.find<ArticleManagementController>();

  final ArticleInfoController articleInfoController =
      Get.put(ArticleInfoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBackground,
        appBar: appBar(MyStrings.titleAppBarManageArticle),
        body: Obx(() => articleManagementController.loading.value == true
            ? Column(
                children: [
                  SizedBox(height: Get.height / 2.8),
                  circularLoading(),
                ],
              )
            : articleManagementController.articleList.isNotEmpty
                ? articleManagementArticleListState()
                : articleManagementEmptyState()),
      ),
    );
  }

  Widget articleManagementArticleListState() {
    double bodyMargin = Dimensions.bodyMargin;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: bodyMargin / 1.9, right: bodyMargin / 1.9),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: articleManagementController.articleList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      articleInfoController.getArticleInfo(
                          articleManagementController.articleList[index].id!);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 4,
                          height: Get.height / 7,
                          child: CachedNetworkImage(
                            imageUrl: articleManagementController
                                .articleList[index].image!,
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
                                  articleManagementController
                                      .articleList[index].title!,
                                  style: Get.theme.textTheme.headlineMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      GetStorage().read(MyStorage.userName) ?? "",
                                      style: Get.theme.textTheme.labelSmall),
                                  Text(
                                      "${articleManagementController.articleList[index].view!} ${MyStrings.visit}",
                                      style: Get.theme.textTheme.labelSmall),
                                  Text(
                                      articleManagementController
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
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: Get.width / 1.25,
              height: Get.height / 13,
              child: ElevatedButton(
                onPressed: () =>
                    Get.toNamed(MyRoute.routeArticleManagementSinglePageInfo),
                child: Text(MyStrings.textManageArticle),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget articleManagementEmptyState() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 150),
        SvgPicture.asset(Assets.images.sadTechbot.path, height: Get.height / 6),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: MyStrings.articleEmpty,
              style: Get.theme.textTheme.headlineLarge),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: Get.width / 1.25,
                height: Get.height / 13,
                child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(MyRoute.routeArticleManagementSinglePageInfo),
                  child: Text(MyStrings.textManageArticle),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

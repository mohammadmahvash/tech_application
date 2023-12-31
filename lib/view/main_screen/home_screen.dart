import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/controller/article/article_info_controller.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tech_application/controller/podcast/podcast_info_controller.dart';

import '../../constant/dimensions.dart';
import '../../component/my_components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final ArticleInfoController articleInfoController =
      Get.put(ArticleInfoController());

  final PodcastInfoController podcastInfoController =
      Get.put(PodcastInfoController());

  final ArticleListController articleListController =
      Get.put(ArticleListController());

  final double bodyMargin = Dimensions.bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() => homeScreenController.loading.value == false
          ? Column(
              children: [
                homePagePoster(),
                const SizedBox(height: 30),
                homePageHashtagList(),
                const SizedBox(height: 30),
                //articleTitle
                GestureDetector(
                    onTap: () {
                      articleListController.getArticleList();
                      Get.toNamed(MyRoute.routeArticleListScreen, arguments: {
                        'title': MyStrings.titleAppBarArticlesList
                      });
                    },
                    child: BluePenTitle(
                      title: MyStrings.viewHotestBlog,
                      bodyMargin: Get.width / 10,
                    )),
                homePageBlogListItem(),
                const SizedBox(height: 30),
                //podcastTitle
                GestureDetector(
                    onTap: () => Get.toNamed(MyRoute.routePodcastListScreen,
                            arguments: {
                              'title': MyStrings.titleAppBarPodcastsList
                            }),
                    child: const BlueMicrophoneTitle(
                        title: MyStrings.viewHotestPodCasts)),
                //podcastListItem
                homePagePodcastListItem(),
                const SizedBox(height: 50),
              ],
            )
          : Column(
              children: [
                SizedBox(height: Get.height / 2.8),
                circularLoading(),
              ],
            )),
    );
  }

  Widget homePageBlogListItem() {
    return SizedBox(
      height: Get.height / 3.6,
      child: ListView.builder(
        itemCount: homeScreenController.topArticlesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              articleInfoController.getArticleInfo(
                  homeScreenController.topArticlesList[index].id!);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  index == homeScreenController.topArticlesList.length - 1
                      ? bodyMargin
                      : 0,
                  0,
                  index == 0 ? bodyMargin : 10,
                  0),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 5.3,
                    width: Get.width / 2.4,
                    child: CachedNetworkImage(
                      imageUrl:
                          homeScreenController.topArticlesList[index].image!,
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
                                    homeScreenController
                                        .topArticlesList[index].author!,
                                    style: Get.theme.textTheme.titleSmall),
                                Row(
                                  children: [
                                    Text(
                                      homeScreenController
                                          .topArticlesList[index].view!,
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
                        homeScreenController.topArticlesList[index].title!,
                        style: Get.theme.textTheme.bodyMedium,
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

  Widget homePagePodcastListItem() {
    return SizedBox(
      height: Get.height / 3.6,
      child: ListView.builder(
        itemCount: homeScreenController.topPodcastsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await podcastInfoController.getPodcastEpisodesList(
                  homeScreenController.topPodcastsList[index].id.toString());

              Get.toNamed(MyRoute.routePodcastSinglePageInfo, arguments: {
                'homeScreenPodcast': homeScreenController.topPodcastsList[index]
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  index == homeScreenController.topPodcastsList.length - 1
                      ? bodyMargin
                      : 0,
                  0,
                  index == 0 ? bodyMargin : 10,
                  0),
              child: Column(
                children: [
                  SizedBox(
                      height: Get.height / 5.3,
                      width: Get.width / 2.4,
                      child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcastsList[index].poster!,
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
                      )),
                  SizedBox(
                    width: Get.width / 2.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          homeScreenController.topPodcastsList[index].title!,
                          style: Get.theme.textTheme.headlineLarge,
                        ),
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

  Widget homePagePoster() {
    return InkWell(
      onTap: () {
        articleInfoController
            .getArticleInfo(homeScreenController.poster.value.id!);
      },
      child: SizedBox(
        width: Get.width / 1.28,
        height: Get.height / 4.2,
        child: CachedNetworkImage(
          imageUrl: homeScreenController.poster.value.image!,
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fill)),
                foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: GradientColors.homePosterCoverGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              Positioned(
                bottom: 8,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Text(
                        textAlign: TextAlign.center,
                        homeScreenController.poster.value.title!,
                        style: Get.theme.textTheme.titleLarge,
                      ),
                    )
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
    );
  }

  Widget homePageHashtagList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: homeScreenController.tagsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                index == homeScreenController.tagsList.length - 1
                    ? bodyMargin
                    : 0,
                0,
                index == 0 ? bodyMargin : 6,
                0),
            child: InkWell(
              onTap: () {
                articleListController.getArticleListByTagId(
                    homeScreenController.tagsList[index].id!);
                var tagName =
                    "${MyStrings.byTagName} ${homeScreenController.tagsList[index].title}";

                Get.toNamed(MyRoute.routeArticleListScreen,
                    arguments: {'title': tagName});
              },
              child: HashtagComponent(
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}

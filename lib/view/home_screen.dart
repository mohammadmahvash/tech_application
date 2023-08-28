import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/Models/fake_data.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

import '../component/my_components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          HomePagePoster(size: size, textTheme: textTheme),
          const SizedBox(height: 30),
          HomePageHashtagList(bodyMargin: bodyMargin, textTheme: textTheme),
          const SizedBox(height: 30),
          HomePageBlogListTitle(bodyMargin: bodyMargin, textTheme: textTheme),
          homePageBlogListItem(),
          const SizedBox(height: 30),
          HomePagePodcastListTitle(
              bodyMargin: bodyMargin, textTheme: textTheme),
          //podcastListItem
          homePagePodcastListItem(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  SizedBox homePageBlogListItem() {
    return SizedBox(
      height: size.height / 3.6,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topArticlesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  index == homeScreenController.topArticlesList.length - 1
                      ? bodyMargin
                      : 0,
                  0,
                  index == 0 ? bodyMargin : 10,
                  0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(homeScreenController
                                    .topArticlesList[index].image!),
                                fit: BoxFit.cover)),
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
                                style: textTheme.titleSmall),
                            Row(
                              children: [
                                Text(
                                  homeScreenController
                                      .topArticlesList[index].view!,
                                  style: textTheme.titleSmall,
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
                  SizedBox(
                    width: size.width / 2.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        homeScreenController.topArticlesList[index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox homePagePodcastListItem() {
    return SizedBox(
      height: size.height / 3.6,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topPodcastsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  index == homeScreenController.topPodcastsList.length - 1
                      ? bodyMargin
                      : 0,
                  0,
                  index == 0 ? bodyMargin : 10,
                  0),
              child: Column(
                children: [
                  Container(
                    height: size.height / 5.3,
                    width: size.width / 2.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(homeScreenController
                                .topPodcastsList[index].poster!),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: size.width / 2.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          homeScreenController.topPodcastsList[index].title!,
                          style: textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePagePodcastListTitle extends StatelessWidget {
  const HomePagePodcastListTitle({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 10),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluemicrophone.provider(),
            color: SolidColors.seeMore,
          ),
          const SizedBox(width: 8),
          Text(
            MyStrings.viewHotestPodCasts,
            style: textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class HomePageBlogListTitle extends StatelessWidget {
  const HomePageBlogListTitle({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 10),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluepen.provider(),
            color: SolidColors.seeMore,
          ),
          const SizedBox(width: 8),
          Text(
            MyStrings.viewHotestBlog,
            style: textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class HomePageHashtagList extends StatelessWidget {
  const HomePageHashtagList({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                index == tagList.length - 1 ? bodyMargin : 0,
                0,
                index == 0 ? bodyMargin : 10,
                0),
            child: HashtagComponent(
              textTheme: textTheme,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

class HomePagePoster extends StatelessWidget {
  const HomePagePoster({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width / 1.28,
          height: size.height / 4.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(homePagePosterMap["assetImage"]),
                  fit: BoxFit.fill)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    homePagePosterMap["writer"] +
                        " - " +
                        homePagePosterMap["date"],
                    style: textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      Text(
                        homePagePosterMap["views"],
                        style: textTheme.titleSmall,
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
              Text(
                homePagePosterMap["title"],
                style: textTheme.titleLarge,
              )
            ],
          ),
        )
      ],
    );
  }
}

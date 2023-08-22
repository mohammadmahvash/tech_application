import 'package:flutter/material.dart';
import 'package:tech_application/Models/fake_data.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';

import '../my_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

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
          HomePageBlogListItem(
              size: size, bodyMargin: bodyMargin, textTheme: textTheme),
          const SizedBox(height: 30),
          HomePagePodcastListTitle(
              bodyMargin: bodyMargin, textTheme: textTheme),
          //podcastListItem
          HomePagePodcastListItem(
              size: size, bodyMargin: bodyMargin, textTheme: textTheme),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class HomePagePodcastListItem extends StatelessWidget {
  const HomePagePodcastListItem({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.6,
      child: ListView.builder(
        itemCount: blogList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                index == blogList.length - 1 ? bodyMargin : 0,
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
                          image: NetworkImage(blogList[index].imageUrl),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: size.width / 2.7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Center(
                      child: Text(
                        "test",
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

class HomePageBlogListItem extends StatelessWidget {
  const HomePageBlogListItem({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.6,
      child: ListView.builder(
        itemCount: blogList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                index == blogList.length - 1 ? bodyMargin : 0,
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
                              image: NetworkImage(blogList[index].imageUrl),
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
                          Text(blogList[index].writer,
                              style: textTheme.titleSmall),
                          Row(
                            children: [
                              Text(
                                blogList[index].views,
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
                      blogList[index].title,
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

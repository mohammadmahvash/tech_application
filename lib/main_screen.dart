import 'package:flutter/material.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';

import 'Models/fake_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: SolidColors.scaffoldBackground,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.menu, size: 30, color: Colors.black),
            Image(
              image: Assets.images.logo.provider(),
              height: size.height / 13.6,
            ),
            const Icon(Icons.search, size: 30, color: Colors.black),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //Poster
                Stack(
                  children: [
                    Container(
                      width: size.width / 1.28,
                      height: size.height / 4.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image:
                                  AssetImage(homePagePosterMap["assetImage"]),
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
                ),
                const SizedBox(height: 40),
                //HashtagList
                SizedBox(
                  height: 50,
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
                        child: Container(
                          // height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: GradientColors.tags,
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              children: [
                                ImageIcon(
                                  Assets.icons.hashtag.provider(),
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  tagList[index].title!,
                                  style: textTheme.titleLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                //blogListTitle
                Padding(
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
                ),
                //blogListItem
                SizedBox(
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
                                          image: NetworkImage(
                                              blogList[index].imageUrl),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                ),
                const SizedBox(height: 40),
                //podcastListTitle
                Padding(
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
                ),
                //podcastListItem
                SizedBox(
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
                                      image: NetworkImage(
                                          blogList[index].imageUrl),
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
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size.height / 8,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: GradientColors.bottomNavBackground,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Container(
                height: size.height / 10,
                width: size.width / 1.4,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(colors: GradientColors.bottomNav)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          Assets.icons.home.provider(),
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          Assets.icons.write.provider(),
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          Assets.icons.user.provider(),
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:tech_application/Models/data_models.dart';
import 'package:tech_application/constant/my_colors.dart';
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
      body: Column(
        children: [
          //AppBar
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.menu, size: 30),
                Image(
                  image: Assets.images.logo.provider(),
                  height: size.height / 13.6,
                ),
                const Icon(
                  Icons.search,
                  size: 30,
                ),
              ],
            ),
          ),
          //Poster
          Stack(
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
                      style: textTheme.titleMedium,
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
                      index == 0 ? bodyMargin : 15,
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
                      padding: const EdgeInsets.fromLTRB(16,0,16,0),
                      child: Row(
                        children: [
                          ImageIcon(
                            Assets.icons.hashtag.provider(),
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(tagList[index].title!,style: textTheme.titleMedium,)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}

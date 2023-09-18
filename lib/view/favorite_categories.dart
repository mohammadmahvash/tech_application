import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/dimensions.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/component/my_components.dart';

class FavoriteCategories extends StatefulWidget {
  const FavoriteCategories({super.key});

  @override
  State<FavoriteCategories> createState() => _FavoriteCategoriesState();
}

class _FavoriteCategoriesState extends State<FavoriteCategories> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    double bodyMargin = Dimensions.bodyMargin;

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              SvgPicture.asset(
                Assets.images.techbot.path,
                height: Get.height / 7,
              ),
              const SizedBox(height: 20),
              Text(
                MyStrings.successfulRegistration,
                style: Get.theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: MyStrings.nameAndFamilyName,
                    hintStyle: Get.theme.textTheme.labelMedium,
                    contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                MyStrings.chooseFavoriteCategories,
                style: Get.theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // tagList
              Obx(
                () => SizedBox(
                  height: 95,
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: homeScreenController.tagsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 180,
                            childAspectRatio: 0.22),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            index == homeScreenController.tagsList.length - 1
                                ? bodyMargin
                                : 0,
                            0,
                            index == 0 || index == 1 ? bodyMargin : 5,
                            0),
                        child: InkWell(
                            onTap: () {
                              if (homeScreenController.selectedTags.contains(
                                  homeScreenController.tagsList[index])) {
                                showErrorSnackBar(context,
                                    "نمیتوانید تگ تکراری انتخاب کنید!");
                              } else {
                                homeScreenController.selectedTags
                                    .add(homeScreenController.tagsList[index]);
                              }
                            },
                            child: HashtagComponent(index: index)),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(Assets.images.arrowdown.path, scale: 1.8),
              const SizedBox(height: 30),
              //SelectedTags
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    width: Get.width,
                    height: 100,
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: homeScreenController.selectedTags.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 3.5),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: SolidColors.surface),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  homeScreenController
                                      .selectedTags[index].title!,
                                  style: Get.theme.textTheme.labelSmall,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      homeScreenController.selectedTags
                                          .removeAt(index);
                                    });
                                  },
                                  child: const Icon(CupertinoIcons.xmark,
                                      size: 20, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              //continuationButton
              SizedBox(
                width: Get.width / 2.5,
                height: Get.height / 13,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      MyStrings.continuation,
                    )),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    ));
  }
}

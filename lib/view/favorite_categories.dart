import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_application/Models/fake_data.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/my_components.dart';

class FavoriteCategories extends StatefulWidget {
  const FavoriteCategories({super.key});

  @override
  State<FavoriteCategories> createState() => _FavoriteCategoriesState();
}

class _FavoriteCategoriesState extends State<FavoriteCategories> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

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
                height: size.height / 7,
              ),
              const SizedBox(height: 20),
              Text(
                MyStrings.successfulRegistration,
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: MyStrings.nameAndFamilyName,
                    hintStyle: textTheme.labelMedium,
                    contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                MyStrings.chooseFavoriteCategories,
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // tagList
              SizedBox(
                height: 95,
                child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: tagList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          index == tagList.length - 1 ||
                                  index == tagList.length - 2
                              ? bodyMargin
                              : 0,
                          0,
                          index == 0 || index == 1 ? bodyMargin : 5,
                          0),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedTags.contains(tagList[index])) {
                                _showSnackBar(context,
                                    "نمیتوانید تگ تکراری انتخاب کنید!");
                              } else {
                                selectedTags.add(tagList[index]);
                              }
                            });
                          },
                          child: HashtagComponent(
                              textTheme: textTheme, index: index)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(Assets.images.arrowdown.path, scale: 1.8),
              const SizedBox(height: 30),
              //SelectedTags
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: size.width,
                  height: 100,
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: selectedTags.length,
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
                                selectedTags[index].title!,
                                style: textTheme.labelSmall,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTags.removeAt(index);
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
              const SizedBox(height: 50),
              //continuationButton
              SizedBox(
                width: size.width / 2.5,
                height: size.height / 13,
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

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.redAccent,
    content: SizedBox(
      height: 25,
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
    ),
  ));
}

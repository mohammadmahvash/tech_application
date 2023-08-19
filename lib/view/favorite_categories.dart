import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';

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
                padding: EdgeInsets.only(left: bodyMargin,right: bodyMargin),
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
              
            ],
          ),
        ),
      ),
    ));
  }
}

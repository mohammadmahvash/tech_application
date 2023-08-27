import 'package:flutter/material.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/component/my_components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
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
    return Column(
      children: [
        const SizedBox(height: 30),
        Image(
          image: Assets.images.profileavatar.provider(),
          height: 100,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              Assets.icons.bluepen.provider(),
              color: SolidColors.seeMore,
            ),
            const SizedBox(width: 8),
            Text(
              MyStrings.imageProfileEdit,
              style: textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: 40),
        Text(
          MyStrings.nameFatemeAmiri,
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          MyStrings.gmailFatemeAmiri,
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 25),
        DividerTech(size: size),
        InkWell(
          onTap: () {},
          splashColor: SolidColors.primaryColor,
          child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  MyStrings.myFavBlog,
                  style: textTheme.headlineLarge,
                ),
              )),
        ),
        DividerTech(size: size),
        InkWell(
          onTap: () {},
          splashColor: SolidColors.primaryColor,
          child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  MyStrings.myFavPodcast,
                  style: textTheme.headlineLarge,
                ),
              )),
        ),
        DividerTech(size: size),
        InkWell(
          onTap: () {},
          splashColor: SolidColors.primaryColor,
          child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  MyStrings.logOut,
                  style: textTheme.headlineLarge,
                ),
              )),
        ),
        // const SizedBox(height: 150),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/gen/assets.gen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
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
          Stack(
            children: [
              Container(
                width: size.width / 1.28,
                height: size.height / 4.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: Assets.images.programming.provider(),
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
                          "ملیکا عزیزی - یک روز پیش",
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          "Like 253",
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Text("دوازده قدم برنامه نویسی یک دوره ی...س",style: textTheme.titleMedium,)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

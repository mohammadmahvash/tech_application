import 'package:flutter/material.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/view/home_page.dart';

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
          HomePage(size: size, textTheme: textTheme, bodyMargin: bodyMargin),
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

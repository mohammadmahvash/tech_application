import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/register_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

import 'home_screen.dart';
import 'profile_page.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  final RxInt selectedMainScreenPageIndex = 0.obs;

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double bodyMargin = Get.width / 10;

    return SafeArea(
        child: Scaffold(
      backgroundColor: SolidColors.scaffoldBackground,
      key: _key,
      drawer: Drawer(
        backgroundColor: SolidColors.scaffoldBackground,
        child: Padding(
          padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image.asset(
                Assets.images.drawerimage.path,
                scale: 3,
              )),
              //userProfile
              ListTile(
                title: Text(
                  MyStrings.userProfile,
                  style: Get.theme.textTheme.headlineMedium,
                ),
                onTap: () {},
              ),
              const Divider(
                color: SolidColors.dividerColor,
              ),
              //aboutTec
              ListTile(
                title: Text(
                  MyStrings.aboutTec,
                  style: Get.theme.textTheme.headlineMedium,
                ),
                onTap: () {},
              ),
              const Divider(
                color: SolidColors.dividerColor,
              ),
              //shareTec
              ListTile(
                title: Text(
                  MyStrings.shareTec,
                  style: Get.theme.textTheme.headlineMedium,
                ),
                onTap: () async {
                  await Share.share(MyStrings.shareText);
                },
              ),
              const Divider(
                color: SolidColors.dividerColor,
              ),
              //tecIngithub
              ListTile(
                title: Text(
                  MyStrings.tecIngithub,
                  style: Get.theme.textTheme.headlineMedium,
                ),
                onTap: () {
                  if (browserLauncherURL(MyStrings.techBlogGithubUrl) ==
                      false) {
                    showErrorSnackBar(context,
                        "can't open this ${MyStrings.techBlogGithubUrl}");
                  } else {
                    browserLauncherURL(MyStrings.techBlogGithubUrl);
                  }
                },
              ),
              const Divider(
                color: SolidColors.dividerColor,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: SolidColors.scaffoldBackground,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: const Icon(Icons.menu, size: 30, color: Colors.black)),
            Image(
              image: Assets.images.logo.provider(),
              height: Get.height / 13.6,
            ),
            const Icon(Icons.search, size: 30, color: Colors.black),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Obx(
            () {
              return IndexedStack(
                index: selectedMainScreenPageIndex.value,
                children: [
                  HomeScreen(bodyMargin: bodyMargin),
                  ProfilePage(bodyMargin: bodyMargin),
                ],
              );
            },
          )),
          BottomNavigation(
            changeMainScreenIndex: (int value) {
              selectedMainScreenPageIndex.value = value;
            },
          )
        ],
      ),
    ));
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.changeMainScreenIndex,
  });

  final Function(int) changeMainScreenIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: Get.height / 8,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: GradientColors.bottomNavBackground,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Container(
          height: Get.height / 10,
          width: Get.width / 1.4,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(colors: GradientColors.bottomNav)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => changeMainScreenIndex(0),
                  icon: ImageIcon(
                    Assets.icons.home.provider(),
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Get.find<RegisterController>().checkLogIn();
                  },
                  icon: ImageIcon(
                    Assets.icons.write.provider(),
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () => changeMainScreenIndex(1),
                  icon: ImageIcon(
                    Assets.icons.user.provider(),
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

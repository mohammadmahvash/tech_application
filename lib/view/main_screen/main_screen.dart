import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_application/constant/dimensions.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
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
    double bodyMargin = Dimensions.bodyMargin;

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
                onTap: () {
                  _key.currentState!.closeDrawer();
                  if (Get.find<RegisterController>()
                      .checkLogInForProfilePage()) {
                    selectedMainScreenPageIndex.value = 1;
                  }
                },
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
                  HomeScreen(),
                  ProfilePage(),
                ],
              );
            },
          )),
          BottomNavigation(
            changeMainScreenIndex: (int value) {
              selectedMainScreenPageIndex.value = value;
            },
            selectedScreenIndex: selectedMainScreenPageIndex,
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
    required this.selectedScreenIndex,
  });

  final Function(int) changeMainScreenIndex;
  final RxInt selectedScreenIndex;

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
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () => changeMainScreenIndex(0),
                    icon: ImageIcon(
                      Assets.icons.home.provider(),
                      size: selectedScreenIndex.value == 0 ? 32 : 23,
                      color: selectedScreenIndex.value == 0
                          ? SolidColors.lightIcon
                          : SolidColors.greyColor,
                    )),
                IconButton(
                    onPressed: () {
                      Get.find<RegisterController>().checkLogInForWrite();
                    },
                    icon: ImageIcon(
                      Assets.icons.write.provider(),
                      size: 30,
                      color: SolidColors.lightIcon,
                    )),
                IconButton(
                    onPressed: () {
                      if (Get.find<RegisterController>()
                          .checkLogInForProfilePage()) {
                        changeMainScreenIndex(1);
                      }
                    },
                    icon: ImageIcon(
                      Assets.icons.user.provider(),
                      size: selectedScreenIndex.value == 1 ? 32 : 23,
                      color: selectedScreenIndex.value == 1
                          ? SolidColors.lightIcon
                          : SolidColors.greyColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/view/home_page.dart';
import 'package:tech_application/view/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _MainScreenState extends State<MainScreen> {
  var selectedMainScreenPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
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
                  style: textTheme.headlineMedium,
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
                  style: textTheme.headlineMedium,
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
                  style: textTheme.headlineMedium,
                ),
                onTap: () {},
              ),
              const Divider(
                color: SolidColors.dividerColor,
              ),
              //tecIngithub
              ListTile(
                title: Text(
                  MyStrings.tecIngithub,
                  style: textTheme.headlineMedium,
                ),
                onTap: () {},
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
              height: size.height / 13.6,
            ),
            const Icon(Icons.search, size: 30, color: Colors.black),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: IndexedStack(
            index: selectedMainScreenPageIndex,
            children: [
              HomePage(
                  size: size, textTheme: textTheme, bodyMargin: bodyMargin),
              ProfilePage(
                  size: size, textTheme: textTheme, bodyMargin: bodyMargin),
            ],
          )),
          BottomNavigation(
            size: size,
            changeMainScreenIndex: (int value) {
              setState(() {
                selectedMainScreenPageIndex = value;
              });
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
    required this.size,
    required this.changeMainScreenIndex,
  });

  final Size size;
  final Function(int) changeMainScreenIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                  onPressed: () => changeMainScreenIndex(0),
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

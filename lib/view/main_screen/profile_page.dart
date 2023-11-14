import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/view/splash_screen.dart';

import '../../constant/dimensions.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
  });

  final double bodyMargin = Dimensions.bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: Get.height/4),
          Text(
            GetStorage().read(MyStorage.userName) ?? "",
            style: Get.theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Text(
            GetStorage().read(MyStorage.email) ?? "",
            style: Get.theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 25),
          const DividerTech(),
          InkWell(
            onTap: () {
              logOut();
            },
            splashColor: SolidColors.primaryColor,
            child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    MyStrings.logOut,
                    style: Get.theme.textTheme.headlineLarge,
                  ),
                )),
          ),
          // const SizedBox(height: 150),
        ],
      ),
    );
  }
}

logOut() {
  Get.defaultDialog(
    title: GetStorage().read(MyStorage.userName) ?? "",
    titleStyle: const TextStyle(color: SolidColors.scaffoldBackground),
    backgroundColor: SolidColors.primaryColor,
    content: Text(
      MyStrings.areYouSureExit,
      style: const TextStyle(color: SolidColors.scaffoldBackground),
    ),
    radius: 10,
    cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text(MyStrings.cancel)),
    confirm: ElevatedButton(
        onPressed: () {
          if (GetStorage().read(MyStorage.token) == null) {
            Get.back();
            Get.snackbar(MyStrings.error, MyStrings.youAlreadyLeft,
                backgroundColor: Colors.redAccent);
          } else {
            GetStorage().erase();
            Get.snackbar(MyStrings.success, MyStrings.youSuccessfullyLogOut,
                backgroundColor: Colors.greenAccent);
            Future.delayed(
                const Duration(seconds: 3), () => Get.offAll(const SplashScreen()));
          }
        },
        child: Text(MyStrings.exit)),
  );
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/component/constant/my_route.dart';
import 'package:tech_application/component/constant/my_storage.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/services/dio_service.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activatedCodeTextEditingController =
      TextEditingController();

  RxBool loading = false.obs;

  var email = "";
  var userId = "";

  registerEmail() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    log(response.data.toString());
  }

  verifyCode() async {
    loading.value = true;

    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activatedCodeTextEditingController.text,
      'command': 'verify',
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    if (response.statusCode == 200) {
      log(response.data.toString());
      var responseStatus = response.data["response"];

      loading.value = false;

      switch (responseStatus) {
        case 'verified':
          var box = GetStorage();
          box.write(MyStorage.token, response.data["token"]);
          box.write(MyStorage.userId, response.data["user_id"]);

          log(name: "userId", GetStorage().read(MyStorage.userId));
          log(name: "token", GetStorage().read(MyStorage.token));

          Get.snackbar(MyStrings.logIn, MyStrings.yourRegistrationWasSuccesful,
              backgroundColor: Colors.greenAccent);

          Get.offAllNamed(MyRoute.routeMainScreen);
          break;
        case 'incorrect_code':
          Get.snackbar(MyStrings.error, MyStrings.activateCodeIsNotCorrect,
              backgroundColor: Colors.redAccent);
          break;
        case 'expired':
          Get.snackbar(
            MyStrings.error,
            MyStrings.activateCodeIsExpired,
            backgroundColor: Colors.redAccent,
          );
          break;
      }
    }
  }

  checkLogIn() {
    if (GetStorage().read(MyStorage.token) == null) {
      Get.toNamed(MyRoute.routeRegisterIntro);
    } else {
      mainScreenManagementBottomSheet();
    }
  }

  mainScreenManagementBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height / 2.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(Assets.images.techbot.path,
                    height: Get.height / 16, alignment: Alignment.topCenter),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(MyStrings.shareKnowledge,
                        style: Get.theme.textTheme.headlineMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(MyStrings.gigTech, style: Get.theme.textTheme.bodyMedium),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //ArticleManagementBTN
                InkWell(
                  onTap: () {
                    Get.offNamed(MyRoute.routeArticleManagementList);
                  },
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.articlemanagement.path,
                          height: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(MyStrings.manageArticle,
                            style: Get.theme.textTheme.headlineMedium),
                      ],
                    ),
                  ),
                ),
                //PodcastManagementBTN
                InkWell(
                  onTap: () => debugPrint("podcast management"),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.podcastmanagement.path,
                          height: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(MyStrings.managePodcast,
                            style: Get.theme.textTheme.headlineMedium),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

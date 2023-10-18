import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_storage.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/controller/register_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(Assets.images.techbot.path,
                height: Get.height / 6),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: MyStrings.welcome,
                  style: Get.theme.textTheme.headlineLarge),
            ),
            const SizedBox(height: 90),
            SizedBox(
              width: Get.width / 2.5,
              height: Get.height / 13,
              child: ElevatedButton(
                onPressed: () {
                  _showUserNameBottomSheet(context);
                },
                child: Text(MyStrings.letsGo),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _showUserNameBottomSheet(BuildContext context) {
    RxBool userNameValidator = false.obs;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height / 2.5,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.insertYourUserName,
                  style: Get.theme.textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller:
                        registerController.userNameTextEditingController,
                    onChanged: (value) {
                      if (registerController
                          .userNameTextEditingController.text.isEmpty) {
                        userNameValidator.value = false;
                      } else {
                        userNameValidator.value = true;
                      }
                    },
                    style: Get.theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "محمد محمدی",
                        hintStyle: Get.theme.textTheme.labelMedium),
                  ),
                ),
                //continuationButton
                SizedBox(
                  width: Get.width / 2.5,
                  height: Get.height / 13,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: userNameValidator.value == false
                            ? null
                            : () {
                                var box = GetStorage();
                                box.write(
                                    MyStorage.userName,
                                    registerController
                                        .userNameTextEditingController.text);

                                Navigator.of(context).pop();

                                _showEmailBottomSheet(context);
                              },
                        style: ButtonStyle(
                            backgroundColor: userNameValidator.value == false
                                ? MaterialStateProperty.all<Color>(
                                    SolidColors.disableButtonprimaryColor)
                                : MaterialStateProperty.all<Color>(
                                    SolidColors.primaryColor)),
                        child: Text(
                          MyStrings.continuation,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showEmailBottomSheet(BuildContext context) {
    RxBool emailValidator = false.obs;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height / 2.5,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.insertYourEmail,
                  style: Get.theme.textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      if (isEmail(value)) {
                        emailValidator.value = true;
                      } else {
                        emailValidator.value = false;
                      }
                    },
                    style: Get.theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "techblog@gmail.com",
                        hintStyle: Get.theme.textTheme.labelMedium),
                  ),
                ),
                //continuationButton
                SizedBox(
                  width: Get.width / 2.5,
                  height: Get.height / 13,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: emailValidator.value == false
                            ? null
                            : () {
                                registerController.registerEmail();
                                Navigator.of(context).pop();
                                _activatedCodeBottomSheet(context);
                              },
                        style: ButtonStyle(
                            backgroundColor: emailValidator.value == false
                                ? MaterialStateProperty.all<Color>(
                                    SolidColors.disableButtonprimaryColor)
                                : MaterialStateProperty.all<Color>(
                                    SolidColors.primaryColor)),
                        child: Text(
                          MyStrings.continuation,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _activatedCodeBottomSheet(BuildContext context) {
    RxBool activatedCodeValidator = false.obs;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height / 2.5,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.activateCode,
                  style: Get.theme.textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        registerController.activatedCodeTextEditingController,
                    onChanged: (value) {
                      if (value.length == 6) {
                        activatedCodeValidator.value = true;
                      } else {
                        activatedCodeValidator.value = false;
                      }
                    },
                    style: Get.theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "******",
                        hintStyle: Get.theme.textTheme.labelMedium),
                  ),
                ),
                //continuationButton
                SizedBox(
                  width: Get.width / 2.5,
                  height: Get.height / 13,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: activatedCodeValidator.value == false
                          ? null
                          : () {
                              registerController.verifyCode();
                            },
                      style: ButtonStyle(
                          backgroundColor: activatedCodeValidator.value == false
                              ? MaterialStateProperty.all<Color>(
                                  SolidColors.disableButtonprimaryColor)
                              : MaterialStateProperty.all<Color>(
                                  SolidColors.primaryColor)),
                      child: registerController.loading.value == false
                          ? Text(
                              MyStrings.continuation,
                              style: const TextStyle(color: Colors.white),
                            )
                          : const SpinKitFadingCircle(
                              color: Colors.white,
                              size: 30.0,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

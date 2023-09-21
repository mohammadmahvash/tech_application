import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/controller/register_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

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
                  _showEmailBottomSheet(context);
                },
                child: Text(MyStrings.letsGo),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(BuildContext context) {
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
                      // print("$value is email ${isEmail(value)}");
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
                  child: ElevatedButton(
                      onPressed: () {
                        registerController.registerEmail();
                        Navigator.of(context).pop();
                        _activatedCodeBottomSheet(context);
                      },
                      child: Text(
                        MyStrings.continuation,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _activatedCodeBottomSheet(BuildContext context) {
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
                      // print("$value is email ${isEmail(value)}");
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
                  child: ElevatedButton(
                      onPressed: () {
                        registerController.verifyCode();
                      },
                      child: Obx(
                        () => registerController.loading.value == false
                            ? Text(
                                MyStrings.continuation,
                              )
                            : const SpinKitFadingCircle(
                                color: Colors.white,
                                size: 30.0,
                              ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

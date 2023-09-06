import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/register_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(Assets.images.techbot.path,
                height: size.height / 6),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: MyStrings.welcome, style: textTheme.headlineLarge),
            ),
            const SizedBox(height: 90),
            SizedBox(
              width: size.width / 2.5,
              height: size.height / 13,
              child: ElevatedButton(
                onPressed: () {
                  _showEmailBottomSheet(context, size, textTheme);
                },
                child: Text(MyStrings.letsGo),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: size.height / 2.5,
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
                  style: textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: TextField(
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      // print("$value is email ${isEmail(value)}");
                    },
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "techblog@gmail.com",
                        hintStyle: textTheme.labelMedium),
                  ),
                ),
                //continuationButton
                SizedBox(
                  width: size.width / 2.5,
                  height: size.height / 13,
                  child: ElevatedButton(
                      onPressed: () {
                        registerController.registerEmail();
                        Navigator.of(context).pop();
                        _activatedCodeBottomSheet(context, size, textTheme);
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

  Future<dynamic> _activatedCodeBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: size.height / 2.5,
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
                  style: textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: TextField(
                    controller:
                        registerController.activatedCodeTextEditingController,
                    onChanged: (value) {
                      // print("$value is email ${isEmail(value)}");
                    },
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "******", hintStyle: textTheme.labelMedium),
                  ),
                ),
                //continuationButton
                SizedBox(
                  width: size.width / 2.5,
                  height: size.height / 13,
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

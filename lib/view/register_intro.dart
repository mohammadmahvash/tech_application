import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:tech_application/view/favorite_categories.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

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
                SizedBox(
                  width: size.width / 2.5,
                  height: size.height / 13,
                  child: ElevatedButton(
                      onPressed: () {
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
                    onChanged: (value) {
                      // print("$value is email ${isEmail(value)}");
                    },
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "******",
                        hintStyle: textTheme.labelMedium),
                  ),
                ),
                SizedBox(
                  width: size.width / 2.5,
                  height: size.height / 13,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FavoriteCategories()));
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
}

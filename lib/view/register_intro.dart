import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/gen/assets.gen.dart';

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
                onPressed: () {},
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const TextStyle(fontSize: 25);
                      }
                      return const TextStyle(fontSize: 20);
                    }),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        SolidColors.primaryColor)),
                child: Text(MyStrings.letsGo),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

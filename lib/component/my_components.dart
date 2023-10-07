import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_application/constant/dimensions.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class BlueMicrophoneTitle extends StatelessWidget {
  const BlueMicrophoneTitle({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.bodyMargin, bottom: 10),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluemicrophone.provider(),
            color: SolidColors.blueColor,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Get.theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class BluePenTitle extends StatelessWidget {
  const BluePenTitle({
    super.key,
    required this.title,
    required this.bodyMargin,
  });

  final String title;
  final double bodyMargin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 10),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluepen.provider(),
            color: SolidColors.blueColor,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Get.theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class HashtagComponent extends StatelessWidget {
  const HashtagComponent({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: GradientColors.tags,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtag.provider(),
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 10),
            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: Get.theme.textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}

class DividerTech extends StatelessWidget {
  const DividerTech({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: Get.width / 6,
      endIndent: Get.width / 6,
      color: SolidColors.dividerColor,
      thickness: 0.8,
    );
  }
}

browserLauncherURL(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    return false;
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.redAccent,
    content: SizedBox(
      // height: 25,
      child: Text(
        message,
        style: Get.theme.textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
    ),
  ));
}

SpinKitFadingCircle circularLoading() {
  return const SpinKitFadingCircle(
    color: SolidColors.primaryColor,
    size: 30.0,
  );
}

SpinKitFadingCube cubeLoading() {
  return const SpinKitFadingCube(
    color: SolidColors.primaryColor,
    size: 30.0,
  );
}

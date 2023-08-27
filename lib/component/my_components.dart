import 'package:flutter/material.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/fake_data.dart';

class DividerTech extends StatelessWidget {
  const DividerTech({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: size.width / 6,
      endIndent: size.width / 6,
      color: SolidColors.dividerColor,
      thickness: 0.8,
    );
  }
}

browserLauncherURL(String url) async{
  var uri = Uri.parse(url);
  if(await canLaunchUrl(uri)){
    await launchUrl(uri);
  }
  else{
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
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
    ),
  ));
}

class HashtagComponent extends StatelessWidget {
  const HashtagComponent({
    super.key,
    required this.textTheme,
    required this.index,
  });

  final TextTheme textTheme;
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
            const SizedBox(width: 20),
            Text(
              tagList[index].title!,
              style: textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}

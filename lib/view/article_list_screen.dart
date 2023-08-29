import 'package:flutter/material.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/constant/my_colors.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
            backgroundColor: SolidColors.scaffoldBackground,
            appBar: appBar(
                bodyMargin, textTheme, MyStrings.titleAppBarArticlesList)));
  }
}

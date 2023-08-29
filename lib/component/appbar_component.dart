import 'package:flutter/material.dart';
import 'package:tech_application/component/constant/my_colors.dart';

PreferredSize appBar(double bodyMargin, TextTheme textTheme ,String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin / 1.5),
      child: AppBar(
        backgroundColor: SolidColors.scaffoldBackground,
        elevation: 0,
        actions: [
          Center(
            child: Text(title,
                style: textTheme.headlineSmall),
          )
        ],
        leading: Align(
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: SolidColors.primaryColor.withAlpha(140),
                shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
      ),
    ),
  );
}

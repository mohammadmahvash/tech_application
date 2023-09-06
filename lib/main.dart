import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/binding.dart';
import 'package:tech_application/component/constant/my_route.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/view/article/article_list_screen.dart';
import 'package:tech_application/view/article/single_article_info.dart';
import 'package:tech_application/view/main_screen/main_screen.dart';
import 'package:tech_application/view/register/register_intro.dart';
import 'package:tech_application/view/splash_screen.dart';

import 'component/constant/my_colors.dart';
import 'my_http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));

  await GetStorage.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: [
          GetPage(
            name: MyRoute.routeMainScreen,
            page: () => MainScreen(),
            binding: RegisterBinding()
          ),
          GetPage(
            name: MyRoute.routeRegisterIntro,
            page: () => RegisterIntro(),
            binding: RegisterBinding()
          ),
          GetPage(
            name: MyRoute.routeArticleListScreen,
            page: () => ArticleListScreen(),
            binding: ArticleBinding(),
            arguments: {'title': MyStrings.newArticles}
          ),
          GetPage(
            name: MyRoute.routeSingleArticleInfo,
            page: () => SingleArticleInfo(),
            binding: ArticleBinding()
          ),
        ],
        locale: const Locale('fa'),
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }

  ThemeData lightTheme() {
    return ThemeData(
        fontFamily: 'dana',
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                textStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const TextStyle(fontSize: 25);
                  }
                  return const TextStyle(fontSize: 20);
                }),
                backgroundColor: MaterialStateProperty.all<Color>(
                    SolidColors.primaryColor))),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SolidColors.posterTitle),
            titleMedium: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: SolidColors.seeMore),
            titleSmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: SolidColors.posterSubTitle),
            headlineLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: SolidColors.textTitle),
            headlineMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: SolidColors.textTitle),
            headlineSmall: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SolidColors.primaryColor),
            labelSmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: SolidColors.textTitle),
            labelMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: SolidColors.hintText),
            bodySmall: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: SolidColors.seeMore),
                bodyMedium: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: SolidColors.textTitle),
                ));
  }
}

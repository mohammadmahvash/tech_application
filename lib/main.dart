import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/route_manager/pages_route.dart';
import 'package:tech_application/themes/app_themes.dart';

import 'package:tech_application/view/splash_screen.dart';

import 'constant/my_colors.dart';
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
        getPages: PagesRoute.pagesList,
        locale: const Locale('fa'),
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}

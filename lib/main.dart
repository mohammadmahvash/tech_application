import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_application/view/register_intro.dart';
import 'package:tech_application/view/splash_screen.dart';

import 'constant/my_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa'), // persian
        ],
        theme: ThemeData(
            fontFamily: 'dana',
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                  fontSize: 16,
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
            )),
        debugShowCheckedModeBanner: false,
        // home: const SplashScreen());
        home: const RegisterIntro());
  }
}

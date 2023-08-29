import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_application/view/single_article_content.dart';

import 'component/constant/my_colors.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

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
              headlineSmall: TextStyle(
                  fontSize: 16,
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
                  color: SolidColors.seeMore)
            )),
        debugShowCheckedModeBanner: false,
        home: SingleArticleContent());
  }
}

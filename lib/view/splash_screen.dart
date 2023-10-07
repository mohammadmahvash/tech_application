import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAndToNamed(MyRoute.routeMainScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: Assets.images.splashLogo.provider(),
          ),
          cubeLoading()
        ],
      ),
    ));
  }
}

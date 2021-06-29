import 'package:animated_splash/animated_splash.dart'
    show AnimatedSplash, AnimatedSplashType;
import 'package:flutter/material.dart';
import 'package:nossosus_app/screens/home_page.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  duringSplash() {
    return 1;
  }

  Map<int, Widget> op = {1: HomePage()};

  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: AppImages.splash,
      home: HomePage(),
      customFunction: duringSplash,
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    );
  }
}

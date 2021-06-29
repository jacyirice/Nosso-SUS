import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.3,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(80.0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Seja bem-vindo",
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

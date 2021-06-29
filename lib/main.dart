import 'package:flutter/material.dart';
import 'package:nossosus_app/screens/home_page.dart';
import 'package:nossosus_app/screens/login_page.dart';
import 'package:nossosus_app/screens/search_page.dart';
import 'package:nossosus_app/screens/sus_atendimento_page.dart';
import 'package:nossosus_app/screens/sus_informations_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
// import 'package:nossosus_app/screens/splash_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nosso SUS',
            theme: ThemeData(primaryColor: AppColors.primary),
            initialRoute: '/',
            routes: {
              '/': (context) => HomePage(),
              '/map': (context) => SearchPage(),
              '/card-sus': (context) => CardSusPage(),
              '/sus-atendimento': (context) => SusAtendimentoPage(),
            },
          );
        }
        ;
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

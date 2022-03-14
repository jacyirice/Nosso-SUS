import 'package:flutter/material.dart';
import 'package:nossosus_app/screens/home_page.dart';
import 'package:nossosus_app/screens/search_page.dart';
import 'package:nossosus_app/screens/services_page.dart';
import 'package:nossosus_app/screens/splash_page.dart';
import 'package:nossosus_app/screens/sus_informacoes_page.dart';
import 'package:nossosus_app/screens/sus_cartao_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nossosus_app/widgets/centered_circular_progress_indicator.dart';

void main() => runApp(const AppWidget());

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

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
            initialRoute: '/splash',
            routes: _buildRouters(),
          );
        }
        return const CenteredCircularProgressIndicator();
      },
    );
  }

  _buildRouters() {
    return {
      '/': (context) => const HomePage(),
      '/services': (context) => const ServicesPage(),
      '/splash': (context) => SplashPage(),
      '/map': (context) => SearchPage(),
      '/card-sus': (context) => const CardSusPage(),
      '/sus-atendimento': (context) => const SusAtendimentoPage(),
    };
  }
}

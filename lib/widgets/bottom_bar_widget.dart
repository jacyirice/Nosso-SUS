import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class BottomBarWidget extends StatelessWidget {
  final ButtonSelected activeBotton;
  const BottomBarWidget(this.activeBotton, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              String? route = ModalRoute.of(context)?.settings.name;
              if (route != '/') {
                Navigator.pushNamed(context, '/');
              }
            },
            icon: const Icon(Icons.home_outlined),
            color: _getColorBotton(ButtonSelected.home),
          ),
          IconButton(
            onPressed: () {
              String? route = ModalRoute.of(context)?.settings.name;
              if (route != '/services') {
                Navigator.pushNamed(context, '/services');
              }
            },
            icon: const Icon(Icons.menu),
            color: _getColorBotton(ButtonSelected.services),
          ),
        ],
      ),
    );
  }

  Color _getColorBotton(ButtonSelected botton) {
    if (activeBotton == botton) {
      return AppColors.bottomSelect;
    } else {
      return AppColors.bottomNotSelect;
    }
  }
}

enum ButtonSelected {
  home,
  services,
}

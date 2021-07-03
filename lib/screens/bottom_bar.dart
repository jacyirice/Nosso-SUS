import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class BottomBar extends StatelessWidget {
  final activeBotton;
  const BottomBar({this.activeBotton, Key? key}) : super(key: key);

  Color _getColorBotton(int pos) {
    if (activeBotton == pos)
      return AppColors.bottomSelect;
    else
      return AppColors.bottomNotSelect;
  }

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
            icon: Icon(Icons.home_outlined),
            color: _getColorBotton(0),
          ),
          IconButton(
            onPressed: () {
              String? route = ModalRoute.of(context)?.settings.name;
              if (route != '/services') {
                Navigator.pushNamed(context, '/services');
              }
            },
            icon: Icon(Icons.menu),
            color: _getColorBotton(1),
          ),
        ],
      ),
    );
  }
}

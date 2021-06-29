import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class AppBottom extends StatelessWidget {
  final activeBottom;
  const AppBottom({this.activeBottom, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(Icons.home_outlined),
                color: activeBottom == 0
                    ? AppColors.bottomSelect
                    : AppColors.bottomNotSelect,
              ),
              // Text('Início', style: TextStyles.textAppBar)
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/services');
                },
                icon: Icon(Icons.menu),
                color: activeBottom == 1
                    ? AppColors.bottomSelect
                    : AppColors.bottomNotSelect,
              ),
              // Text('Serviços', style: TextStyles.textAppBarNS)
            ],
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(Icons.person),
          //       color: activeBottom == 2
          //           ? AppColors.bottomSelect
          //           : AppColors.bottomNotSelect,
          //     ),
          //     // Text('Perfil', style: TextStyles.textAppBarNS)
          //   ],
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class BottomBarWidget extends StatefulWidget {
  final ButtonSelected activeBotton;

  const BottomBarWidget(this.activeBotton, {Key? key}) : super(key: key);

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  Map optionsMenu = {
    'home': {
      'route': '/',
      'icon': Icons.home_outlined,
      'selected': ButtonSelected.home
    },
    'services': {
      'route': '/services',
      'icon': Icons.menu,
      'selected': ButtonSelected.services
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(context, 'home'),
          _buildIconButton(context, 'services'),
        ],
      ),
    );
  }

  Color _getColorBotton(ButtonSelected botton) {
    if (widget.activeBotton == botton) {
      return AppColors.bottomSelect;
    } else {
      return AppColors.bottomNotSelect;
    }
  }

  _buildIconButton(context, String key) {
    Map obj = optionsMenu[key];
    return IconButton(
      onPressed: () {
        String? route = ModalRoute.of(context)?.settings.name;
        if (route != obj['route']) Navigator.pushNamed(context, obj['route']);
      },
      icon: Icon(obj['icon']),
      color: _getColorBotton(obj['selected']),
    );
  }
}

enum ButtonSelected {
  home,
  services,
}

import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class TextStyles {
  static const titleHome = TextStyle(
    fontFamily: 'roboto',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static const titleRegular = TextStyle(
    fontFamily: 'roboto',
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.heading,
  );
  static const titleCategoryCard = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.cardCategory,
  );

  static const titleCardPrimary = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.cardTitle,
  );

  static const titleCardSecundary = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.cardTitle,
  );
  static const textAppBar = TextStyle(
    fontFamily: 'roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.bottomSelect,
  );

  static const textAppBarNS = TextStyle(
    fontFamily: 'roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.bottomNotSelect,
  );
}

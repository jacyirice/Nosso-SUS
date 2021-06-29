import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';

class TextStyles {
  static final titleHome = TextStyle(
    fontFamily: 'roboto',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleRegular = TextStyle(
    fontFamily: 'roboto',
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.heading,
  );
  static final titleCategoryCard = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.cardCategory,
  );

  static final titleCardPrimary = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.cardTitle,
  );

  static final titleCardSecundary = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.cardTitle,
  );
  static final textAppBar = TextStyle(
    fontFamily: 'roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.bottomSelect,
  );

  static final textAppBarNS = TextStyle(
    fontFamily: 'roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.bottomNotSelect,
  );
}

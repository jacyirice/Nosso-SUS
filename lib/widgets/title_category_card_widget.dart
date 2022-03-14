import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

class TitleCategoryCardWidget extends StatelessWidget {
  final String text;
  const TitleCategoryCardWidget(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyles.titleCategoryCard);
  }
}

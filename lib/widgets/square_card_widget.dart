import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

class SquareCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final dynamic icon;
  final String textCard;
  const SquareCardWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.textCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: 131,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                Text(
                  textCard,
                  style: TextStyles.titleCardPrimary,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 20.0,
            offset: const Offset(20.0, 10.0),
          ),
        ],
      ),
    );
  }
}

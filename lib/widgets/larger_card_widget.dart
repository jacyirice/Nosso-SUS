import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

class LargerCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final dynamic icon;
  final String textCard;
  final bool listTile;
  final double contentPaddingLeft;

  const LargerCardWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.textCard,
    this.listTile = false,
    this.contentPaddingLeft = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listTile ? null : 71,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: listTile ? _buildListTile() : _buildRow(),
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

  _buildRow() {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 225,
          child: Text(
            textCard,
            style: TextStyles.titleCardPrimary,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  _buildListTile() {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: contentPaddingLeft,
      ),
      leading: icon,
      title: Text(textCard, style: TextStyles.titleCardPrimary),
    );
  }
}

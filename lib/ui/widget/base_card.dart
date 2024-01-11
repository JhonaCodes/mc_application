import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final String leading;
  final String title;
  final Widget subTitle;
  final String priceInfo;
  final Icon? iconPriceInfo;
  final VoidCallback? sheetView;

  const BaseCard({super.key, required this.title,  required this.leading, required this.priceInfo, this.sheetView, required this.subTitle, this.iconPriceInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(leading),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Chip(
              label: Text(priceInfo),
            avatar: iconPriceInfo,
          )
        ],
      ),
      subtitle: subTitle,
      onTap: sheetView,
    );
  }
}

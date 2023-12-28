import 'package:flutter/material.dart';

import '../../../utility/ui_constants.dart';

class NavItem extends StatelessWidget {
  // final title;
  // final iconData;
  // final subTitle;
  // final onTap;

  final dynamic title;
  final dynamic iconData;
  final dynamic subTitle;
  final dynamic onTap;

  const NavItem({
    super.key,
    required this.title,
    required this.iconData,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      onTap: onTap,
      leading: Icon(
        iconData,
        color: kImperialOrange,
        size: 30,
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle,
              style: kLightLabelTextStyle.copyWith(color: kBlack),
            )
          : null,
    );
  }
}

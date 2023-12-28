import 'package:flutter/material.dart';

import '../../../utility/ui_constants.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    @required this.iconData,
    @required this.onPressed,
  });

  final iconData;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: MaterialButton(
        elevation: 10.0,
        onPressed: onPressed,
        child: Icon(
          iconData,
          size: 30,
          color: kBlack,
        ),
      ),
    );
  }
}

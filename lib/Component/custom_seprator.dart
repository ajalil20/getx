import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class MySeprator extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: responsive.setWidth(35),
          color: colors.hintColor,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: MyText(
            title: 'Or',
            size: 18,
            clr: colors.hintColor,
          ),
        ),
        Container(
          height: 1,
          width: responsive.setWidth(35),
          color: colors.hintColor,
        ),
      ],
    );
  }
}

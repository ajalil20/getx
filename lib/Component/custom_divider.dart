import 'package:flutter/material.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class MyDivider extends StatelessWidget {
  final double? width;
  final double? thickness;
  final Color? color;

  Responsive responsive = Responsive();
  MyDivider({this.width, this.thickness, this.color});
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      width: width ?? responsive.setWidth(100),
      child: Divider(
        thickness: thickness ?? 2,
        color: color ?? colors.primaryColor,
      ),
    );
  }
}

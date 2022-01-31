import 'package:flutter/material.dart';
import '../Component/custom_text.dart';
import '../Utils/color_config.dart';

class MultiText extends StatelessWidget {
  String text1,text2;
  Color? color1,color2;
  double? size1,size2;

  MultiText({this.color1,this.size1,this.color2,this.size2,required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      text: text1,
      style: textStyle.copyWith(fontSize: size1??14,color: color1??ColorConfig().textColor),
      children: [
        TextSpan(
            text: text2,
            style: textStyle.copyWith(fontSize: size2??14,color: color2??ColorConfig().secondaryColor),
        )
      ]
    ),);
  }
}

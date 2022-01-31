import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Component/custom_text.dart';
import '../Utils/color_config.dart';
import '../Utils/image_path.dart';

class MyButton extends StatelessWidget {
  double? height, width, fontSize, radius, horPadding;
  String? title, weight;
  Color? bgColor, borderColor, textColor;
  Function? onTap;
  bool? gradient, shadow;
  double? elevation;

  MyButton(
      {Key? key,
      this.elevation,
      this.height,
      this.borderColor,
      this.textColor,
      this.radius,
      this.horPadding,
      this.fontSize,
      this.gradient,
      this.weight,
      this.width,
      this.onTap,
      this.title,
      this.bgColor,
      this.shadow})
      : super(key: key);

  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Material(
        elevation: elevation??0,
        child: Container(
          
          height: height ?? 50,
          width: width ,
          padding: EdgeInsets.symmetric(horizontal: horPadding ?? 15),
          decoration: BoxDecoration(
              color: bgColor ?? colors.primaryColor,
              gradient: gradient == true
                  ? LinearGradient(
                      colors: [
                        colors.secondaryColor,
                        colors.primaryColor,
                        colors.secondaryColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.05, 0.5, 0.95])
                  : null,
              boxShadow: shadow == true
                  ? [
                      BoxShadow(
                        color: colors.primaryColor.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  : null,
              borderRadius: BorderRadius.circular(radius ?? 25),
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: Center(
              child: MyText(
            title: title!,
            clr: textColor ?? colors.textColor,
            weight: weight ?? "Semi Bold",
            size: fontSize ?? 14,
          )),
        ),
      ),
    );
  }
}

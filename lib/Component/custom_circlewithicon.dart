import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class CircleWithIcon extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Color? bgColor;
  final bool? withImg;
  final String? img;
  final double? imgSize;
  final FaIcon? faIcon;
  CircleWithIcon(
      {this.title,
      this.height,
      this.width,
      this.icon,
      this.withImg,
      this.borderColor,
      this.bgColor,
      this.img,
      this.imgSize,
      this.faIcon});
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      height: height ?? 50,
      width: width ?? 50,
      decoration: BoxDecoration(
          color: bgColor ?? null,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor ?? colors.textColor)),
      child: faIcon == null
          ? Center(
              child: icon == null
                  ? withImg != null
                      ? Container(
                          height: responsive.setHeight(imgSize ?? 3.5),
                          width: responsive.setHeight(imgSize ?? 3.5),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                            image: AssetImage(
                                '${img ?? 'assets/images/logo.png'}'),
                          )),
                        )
                      : MyText(title: '${title ?? ''}')
                  : icon ??
                      Icon(
                        Icons.check,
                        color: colors.textColor,
                      ),
            )
          : Center(child: faIcon ?? FaIcon(FontAwesomeIcons.home)),
    );
  }
}

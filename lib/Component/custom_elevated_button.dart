import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class MyElevatedButton extends StatelessWidget {
  double? height, width, fontSize, radius, horPadding;
  String? title, weight, image, image2;
  Color? bgColor, borderColor, textColor, imageColor, image2Color;
  Function? onTap;
  bool? isImage, isImage2, isIcon, isIconPerifix;
  Icon? icon, icon2;

  MyElevatedButton({
    Key? key,
    this.height,
    this.borderColor,
    this.textColor,
    this.radius,
    this.horPadding,
    this.fontSize,
    this.weight,
    this.width,
    this.onTap,
    this.title,
    this.bgColor,
    this.isImage,
    this.isImage2,
    this.imageColor,
    this.image2Color,
    this.isIcon,
    this.icon,
    this.image,
    this.image2,
    this.isIconPerifix,
  }) : super(key: key);

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          color: bgColor ?? null,
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horPadding ?? 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: isImage2 == true
                        ? Image.asset(
                            image2 ?? 'assets/icons/pawIcon.png',
                            color: image2Color ?? null,
                          )
                        : isIconPerifix == true
                            ? icon2 ?? Icon(Icons.add)
                            : SizedBox(
                                // width: 20,
                              )),
                MyText(
                  title: title!,
                  clr: textColor ?? colors.textColor,
                  weight: weight ?? "Semi Bold",
                  size: fontSize ?? responsive.setTextScale(12),
                ),
                Container(
                    child: isImage == true
                        ? Image.asset(
                            image ?? 'assets/icons/pawIcon.png',
                            color: imageColor ?? null,
                          )
                        : isIcon == true
                            ? icon ?? Icon(Icons.add_circle_outlined,color: colors.whiteColor,)
                            : null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

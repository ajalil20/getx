import 'package:flutter/material.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class MyCircleImage extends StatelessWidget {
  final double? size;
  final double? spreadRadius;
  final double? blurRadius;
  final bool? isNetworkImage;
  final String? imgPath;
  final bool? showBorder;
  final Color? borderColor;
  final Color? shadowColor;
  final bool? showSHadow;
  MyCircleImage(
      {required this.imgPath,
      this.size,
      this.spreadRadius,
      this.blurRadius,
      this.isNetworkImage,
      this.showBorder,
      this.borderColor,
      this.showSHadow,
      this.shadowColor});

  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      height: size != null ? responsive.setHeight(size) : 50,
      width: size != null ? responsive.setHeight(size) : 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: showBorder != null || showBorder != false
              ? Border.all(color: borderColor ?? colors.secondaryColor)
              : null,
          boxShadow: showSHadow == null || showSHadow == false
              ? []
              : [
                  BoxShadow(
                    color:
                        shadowColor ?? colors.secondaryColor.withOpacity(0.5),
                    spreadRadius: spreadRadius ?? 5,
                    blurRadius: blurRadius ?? 7,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                  // : BoxShadow(color: Colors.transparent),
                ],
          image: isNetworkImage != true
              ? DecorationImage(
                  image: AssetImage(imgPath ?? 'assets/users/userImage.png'),
                  fit: BoxFit.cover)
              : DecorationImage(
                  image: NetworkImage(
                      '${imgPath ?? 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'}'),
                  fit: BoxFit.cover)),
    );
  }
}

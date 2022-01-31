import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawndr/Utils/responsive.dart';
import '../Utils/color_config.dart';

TextStyle textStyle = GoogleFonts.sourceSansPro(
  fontSize: 14,
  color: ColorConfig().textColor.withOpacity(0.8),
);

class MyText extends StatefulWidget {
  final String title;
  final String? weight;
  final double? size, height;
  final clr;
  final toverflow;
  final bool? center;
  final int? line;
  final bool? under, cut;
  final List<FontFeature>? fontFeatures;

  MyText(
      {required this.title,
      this.size,
      this.clr,
      this.fontFeatures,
      this.weight,
      this.height,
      this.center,
      this.line,
      this.under,
      this.toverflow,
      this.cut});

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  Responsive responsive =Responsive();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Text(
      widget.title,
      overflow:
          widget.toverflow == null ? TextOverflow.visible : widget.toverflow,
      maxLines: widget.line,
      textScaleFactor: 1,
      style: GoogleFonts.poppins(
          fontFeatures: widget.fontFeatures,
          height: widget.height,
          decoration: widget.under == true
              ? TextDecoration.underline
              : widget.cut == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
          fontSize: responsive.setTextScale(widget.size??12),
          color: widget.clr ?? ColorConfig().blackColor,
          fontWeight: widget.weight == null
              ? FontWeight.normal
              : widget.weight == "Bold"
                  ? FontWeight.bold
                  : widget.weight == "Semi Bold"
                      ? FontWeight.w500
                      : FontWeight.w400),
      textAlign: widget.center == null
          ? TextAlign.left
          : widget.center!
              ? TextAlign.center
              : TextAlign.left,

    );
  }
}

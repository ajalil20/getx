import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/color_config.dart';

TextStyle textStyle = GoogleFonts.sourceSansPro(
  fontSize: 14,
  color: ColorConfig().textColor.withOpacity(0.8),
);

class MyMultiText extends StatefulWidget {
  final String tiltle1;
  final String title2;
  final String? weight1;
  final String? weight2;
  final Color? clr1;
  final Color? clr2;
  final double? size1;
  final double? size2;
  final double? height;
  final bool? under, cut;
  final List<FontFeature>? fontFeatures;

  MyMultiText(
      {required this.tiltle1,
      required this.title2,
      this.size1,
      this.size2,
      this.clr1,
      this.clr2,
      this.fontFeatures,
      this.height,
      this.under,
      this.cut,
      this.weight1,
      this.weight2});

  @override
  _MyMultiTextState createState() => _MyMultiTextState();
}

class _MyMultiTextState extends State<MyMultiText> {
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "${widget.tiltle1} : ",
            style: GoogleFonts.sourceSansPro(
                fontFeatures: widget.fontFeatures,
                height: widget.height,
                decoration: widget.under == true
                    ? TextDecoration.underline
                    : widget.cut == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                fontSize: widget.size1,
                color: widget.clr1 ?? ColorConfig().textColor,
                fontWeight: widget.weight1 == null
                    ? FontWeight.normal
                    : widget.weight1 == "Bold"
                        ? FontWeight.bold
                        : widget.weight1 == "Semi Bold"
                            ? FontWeight.w600
                            : FontWeight.normal),
          ),
          TextSpan(
            text: widget.title2,
            style: GoogleFonts.sourceSansPro(
                fontFeatures: widget.fontFeatures,
                height: widget.height,
                decoration: widget.under == true
                    ? TextDecoration.underline
                    : widget.cut == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                fontSize: widget.size2,
                color: widget.clr2 ?? ColorConfig().textColor,
                fontWeight: widget.weight2 == null
                    ? FontWeight.normal
                    : widget.weight2 == "Bold"
                        ? FontWeight.bold
                        : widget.weight2 == "Semi Bold"
                            ? FontWeight.w600
                            : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

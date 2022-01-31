import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pawndr/Utils/responsive.dart';
import '../Utils/color_config.dart';

import 'custom_text.dart';

class MyTextField extends StatefulWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final TextEditingController? controller;
  final String Function(String)? validator;
  final Function(String)? onFieldSubmit;
  final Function(String)? onChanged;
  final String? hintText;
  final Function? onTapSuffixIcon;
  final Function? onTapSuffixFaIcon;
  final Function? onTap;
  final Function? onTapPrefixIcon;
  final suffixIconData;
  final suffixFaIconData;
  final bool? multiIcon;
  final IconData? prefixIconData;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final Color? borderColor;
  final Widget? prefixWidget;
  final TextInputType? inputType;
  final bool? obscureText;
  final InputDecoration? inputDecoration;
  final Widget? suffixIcons;
  final bool? fullBorder;
  final TextInputAction? inputAction;
  final bool? validate;
  final bool? showLabel;
  final bool? readOnly;
  final bool? showBar;
  final bool? boxShadow;
  final int? maxLength,minLines,maxLines;
final MaskTextInputFormatter? inputFormate;
  static const Color _textFieldThemeColor = const Color(0xff707070);

  const MyTextField(
      {this.onChanged,
      this.inputFormate,
      this.maxLength,
      this.horizontalPadding,
      this.width,
      this.validate,
      this.inputAction,
      this.showLabel,
      this.height,
      this.fullBorder,
      this.borderColor,
      this.inputDecoration,
      this.multiIcon,
      this.title,
      this.onTap,
      this.controller,
      this.validator,
      this.onFieldSubmit,
      this.hintText,
      this.onTapSuffixIcon,
      this.suffixIconData,
      this.prefixIconData,
      this.onTapPrefixIcon,
      this.focusNode,
      this.backgroundColor = Colors.transparent,
      this.hintTextColor = _textFieldThemeColor,
      this.cursorColor = _textFieldThemeColor,
      this.textColor = _textFieldThemeColor,
      this.prefixIconColor = _textFieldThemeColor,
      this.sufixIconColor = _textFieldThemeColor,
      this.prefixWidget,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.suffixIcons,
      this.readOnly,
      this.showBar,
      this.onTapSuffixFaIcon,
      this.suffixFaIconData,this.boxShadow,this.minLines,this.maxLines});

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<MyTextField> {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      height: widget.height??responsive.setHeight(6),
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:widget.boxShadow == true ? [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
        ]:null,
      ),
      child: Center(
        child: TextFormField(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          textInputAction:widget.inputAction,
          readOnly: widget.readOnly ?? false,
            inputFormatters:widget.inputFormate!=null?[widget.inputFormate!]:null ,
          obscureText: widget.obscureText!,
          obscuringCharacter: "*",
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          keyboardType: widget.inputType,
          textCapitalization: TextCapitalization.sentences,
          focusNode: widget.focusNode,
          validator: (val) {
            if (widget.validate == true) {
              return "${widget.title} can not be empty";
            }
            widget.validator!(val!);
          },
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          cursorWidth: 1,
          cursorColor: widget.cursorColor,
          autofocus: false,
          controller: widget.controller,
          style: textStyle.copyWith(
              decoration: TextDecoration.none, color: widget.textColor),
          onFieldSubmitted: widget.onFieldSubmit,
          decoration: widget.inputDecoration ??
              InputDecoration(
                hoverColor: Colors.white,
                labelText: widget.showLabel == true ? widget.title : null,
                labelStyle: textStyle.copyWith(color: widget.hintTextColor),
                hintText: widget.hintText,
                hintStyle: textStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    color: widget.hintTextColor ?? colors.hintColor,
                    fontSize: 14),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding==null?
                  (widget.fullBorder == false
                      ? 0
                      : 20):widget.horizontalPadding!,
                    vertical: widget.fullBorder == false ? 10 : 2),
                suffixIcon: widget.suffixFaIconData != null
                    ? Container(
                        width: responsive.setWidth(10),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              widget.onTapSuffixFaIcon!();
                            },
                            child: widget.suffixFaIconData,
                          ),
                        ),
                      )
                    : widget.suffixIconData == null
                        ? null
                        : widget.multiIcon == null
                            ? GestureDetector(
                                onTap: () {
                                  widget.onTapSuffixIcon!();
                                },
                                child: Icon(
                                  widget.suffixIconData,
                                  color: widget.sufixIconColor,
                                ),
                              )
                            : widget.suffixIconData,
                prefixIcon: widget.prefixWidget != null
                    ? widget.prefixWidget
                    : widget.prefixIconData == null
                        ? null
                        : GestureDetector(
                            onTap: () {
                              widget.onTapPrefixIcon!();
                            },
                            child: Container(
                              width: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      widget.prefixIconData,
                                      color: widget.prefixIconColor,
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        widget.showBar == false ? false : true,
                                    child: Container(
                                      width: 1,
                                      height: 30,
                                      color: ColorConfig().hintColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                focusedBorder:
                    (widget.fullBorder == true || widget.fullBorder == null)
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : widget.textColor!,
                                width: 1),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : widget.textColor!,
                                width: 1),
                          ),
                suffix: widget.suffixIcons,
                enabledBorder:
                    (widget.fullBorder == true || widget.fullBorder == null)
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : ColorConfig().hintColor,
                                width: 1),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : ColorConfig().hintColor,
                                width: 1.5),
                          ),
                disabledBorder:
                    (widget.fullBorder == true || widget.fullBorder == null)
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : ColorConfig().hintColor,
                                width: 1),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.borderColor != null
                                    ? widget.borderColor!
                                    : ColorConfig().hintColor,
                                width: 1),
                          ),
                border: (widget.fullBorder == true || widget.fullBorder == null)
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : ColorConfig().hintColor,
                            width: 1),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : ColorConfig().hintColor,
                            width: 1),
                      ),
              ),
        ),
      ),
    );
  }
}

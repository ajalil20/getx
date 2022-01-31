import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ConfirmPaymentController extends GetxController{
  var confirmCode = new MaskTextInputFormatter(
      mask: '#', filter: {"#": RegExp(r'[0-9]')});
final focusNode1 = FocusNode();
final focusNode2 = FocusNode();

final focusNode3 = FocusNode();

final focusNode4 = FocusNode();

      bool checkConfirmCode(){
        return true;
      }
}
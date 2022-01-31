import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
class PaymentController extends GetxController{
  var cardMaskFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
      var csv = new MaskTextInputFormatter(
      mask: '###', filter: {"#": RegExp(r'[0-9]')});
        var monthYear = new MaskTextInputFormatter(
      mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
TextEditingController cardHolderName=TextEditingController();
TextEditingController cardNumber=TextEditingController();

TextEditingController cardExpiryDate=TextEditingController();
TextEditingController cardCSV=TextEditingController();

      RxInt payementMethodeSelected=1.obs;
}
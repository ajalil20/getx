import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';

import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/paymentController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
class CustomPaymentDetail extends StatelessWidget {
  
Responsive _responsive = Responsive();
  ColorConfig colors = ColorConfig();
  PaymentController _paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    _responsive.setContext(context);
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: EdgeInsets.only(
                  left: _responsive.setWidth(4),
                  right: _responsive.setWidth(4),
                  top: _responsive.setHeight(3)),
              child: MyText(
                title: "Payment Details",
                clr: colors.blackColor,
                size: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: _responsive.setWidth(4),
                  right: _responsive.setWidth(4),
                  top: _responsive.setHeight(3)),
              child: MyText(
                title: "Cardholder Name:",
                clr: colors.gray,
                size: 16,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: _responsive.setWidth(4),
                    right: _responsive.setWidth(4),
                    top: _responsive.setHeight(3)),
                child: MyTextField(
                  fullBorder: false,
                  hintText: "Johon Sena",
                  controller: _paymentController.cardHolderName,
                
                  horizontalPadding: 1,
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: _responsive.setWidth(4),
                    right: _responsive.setWidth(4),
                    top: _responsive.setHeight(3)),
                child: MyTextField(
                  fullBorder: false,
                  inputType: TextInputType.number,
                  prefixIconData: Icons.credit_card,
                  prefixIconColor: colors.hintColor,
                  hintText: "1248 1248 1248",
                  inputFormate: _paymentController.cardMaskFormatter,
                   controller: _paymentController.cardNumber,
                 
                  horizontalPadding: 0,
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: _responsive.setWidth(4),
                    right: _responsive.setWidth(4),
                    top: _responsive.setHeight(3)),
                child: Row(
                  children: [
                    Flexible(
                      child: MyTextField(
                        fullBorder: false,

                        hintText: "07/23",
                        inputFormate: _paymentController.monthYear,
                        inputType: TextInputType.datetime,
                        controller: _paymentController.cardExpiryDate,
                        
                        horizontalPadding: 1,
                      ),
                    ),
                    SizedBox(
                      width: _responsive.setWidth(5),
                    ),
                    Flexible(
                      child: MyTextField(
                        fullBorder: false,
                        hintText: "022",
                        inputType: TextInputType.number,
                        inputFormate: _paymentController.csv,
                        controller: _paymentController.cardCSV,
                      
                        horizontalPadding: 1,
                        obscureText: true,
                      ),
                    )
                  ],
                )),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/paymentController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
class CustomPaymentMethod extends StatelessWidget {
  PaymentController _paymentController=Get.put(PaymentController());
    Responsive _responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    _responsive.setContext(context);
    return  Container(
              padding: EdgeInsets.only(
                  left: _responsive.setWidth(4),
                  right: _responsive.setWidth(4),
                  top: _responsive.setHeight(3)),
              width: _responsive.setWidth(100),
              decoration: BoxDecoration(
               
                gradient:
                    LinearGradient(colors: [colors.textColor, Colors.white60]),
              ),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: _responsive.setWidth(4),
                          right: _responsive.setWidth(4),
                          top: _responsive.setHeight(3)),
                      child: MyText(
                        title: "Payment Method",
                        clr: colors.blackColor,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: _responsive.setWidth(4),
                          right: _responsive.setWidth(4),
                          top: _responsive.setHeight(3),
                          bottom: _responsive.setHeight(4)),
                      child: Obx(()=>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    _paymentController.payementMethodeSelected(1);
                                  },
                                  child: Container(
                                    padding:EdgeInsets.all(_responsive.setWidth(3)),
                                    margin: EdgeInsets.all(_responsive.setWidth(2)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.textColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colors.gray,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 2.0,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          ImagePath.cardImage,
                                          height: _responsive.setHeight(5),
                                         
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child:_paymentController.payementMethodeSelected.value==1? Icon(
                                      Icons.check_circle_sharp,
                                      color: colors.primaryColor,
                                    ):SizedBox()
                                    ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: _responsive.setWidth(2),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    _paymentController.payementMethodeSelected(2);
                                  },
                                  child: Container(
                                     padding:EdgeInsets.all(_responsive.setWidth(3)),
                                    margin: EdgeInsets.all(_responsive.setWidth(2)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.textColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colors.gray,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 2.0,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          ImagePath.visaImage,
                                          height: _responsive.setHeight(5),
                                       
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: _paymentController.payementMethodeSelected.value==2? Icon(
                                      Icons.check_circle_sharp,
                                      color: colors.primaryColor,
                                    ):SizedBox(),
                                    ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: _responsive.setWidth(2),
                          ),
                          
                          Expanded(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    _paymentController.payementMethodeSelected(3);
                                  },
                                  child: Container(
                                    padding:EdgeInsets.all(_responsive.setWidth(3)),
                                    margin: EdgeInsets.all(_responsive.setWidth(2)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.textColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colors.gray,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 2.0,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          ImagePath.paypalImage,
                                          height: _responsive.setHeight(5),
                                         
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child:_paymentController.payementMethodeSelected.value==3? Icon(
                                      Icons.check_circle_sharp,
                                      color: colors.primaryColor,
                                    ):SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
            );
  }
}
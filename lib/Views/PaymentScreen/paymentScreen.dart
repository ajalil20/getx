import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_payment_method.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/payment_card_detail.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
class PaymentScreen extends StatelessWidget {
 Responsive responsive= Responsive();
 ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle1: true,
      showAppBar: true,
      showCircle2: false,
      screenNamee: "Payment",
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
           Padding(
                padding:  EdgeInsets.only( left: responsive.setWidth(4),
                    right: responsive.setWidth(4), top: responsive.setWidth(4)),
                child: Container(
              
                  padding: EdgeInsets.all(responsive.setWidth(5)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colors.textColor,
                        boxShadow: [
                                        BoxShadow(
                                          color: colors.gray,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 2.0,
                                        )
                                      ],
                        ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                                MyText(title: "Ticket Purchase date",size: 16,clr: colors.blackColor,),
                                MyText(title: "12 Jan 2021",size: 14,clr: colors.gray,),


                        ],
                      ),
                      SizedBox(width: responsive.setWidth(4),),
                      Expanded(child: MyButton(title: "USD 700",height: responsive.setHeight(5),bgColor: colors.secondaryColor,radius: 10,))
                ],),),
              ),
              CustomPaymentMethod(),
              CustomPaymentDetail(),
               Container(
                 margin: EdgeInsets.only(left: responsive.setWidth(4),right: responsive.setWidth(4),top: responsive.setHeight(3),bottom: responsive.setHeight(2)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colors.primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(2)),
                    child: MyText(title: "You have to pay of your ticket",clr: colors.textColor,size: 16,),),
                  Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                    bottom:  responsive.setHeight(2),
                    top: responsive.setHeight(2)),
                    child:Row(children: [
                       MyText(title: "700",clr: colors.textColor,size: 20,weight: "Bold",),
                       SizedBox(width: responsive.setWidth(2),),
                        MyText(title: "USD",clr: colors.blackColor,size: 16,weight: "Bold",)
                    ],
                    )
                    ),
                  
                  Row(children: List.generate(46, (index) {
                   return index%2==0?SizedBox(width: responsive.setWidth(2),):Container(width: responsive.setWidth(2),color: colors.blackColor,height: 1,);
                  }),),
                  Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(2)),
                    child: MyText(title: "Name",size: 14,clr: colors.textColor),),
                      Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(2)),
                    child: MyText(title: "John Johnson",size: 18,clr: colors.textColor),),
                      Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(4)),
                    child: MyText(title: "Order Number",size: 14,clr: colors.textColor),),
                     Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(2)),
                    child: MyText(title: "12540146",size: 18,clr: colors.textColor),),
                    Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(4)),
                    child: MyText(title: "Service",size: 14,clr: colors.textColor),),
                     Padding(
                     padding: EdgeInsets.only(
                    left: responsive.setWidth(4),
                   
                    top: responsive.setHeight(2)),
                    child: MyText(title: "EDM Gold passes front stage tickets",size: 18,clr: colors.textColor,toverflow: TextOverflow.ellipsis,),),
                  SizedBox(height: 20,)
                ],),
                ),
                Padding(
                  padding:  EdgeInsets.all(responsive.setWidth(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    MyText(title: "Previous Step",size: 16,clr: colors.gray,weight: "Bold",),
                    MyButton(
                      onTap: (){
                        Get.toNamed("/confirmPayment");
                      },
                      title: "Pay 11,70.00 USD",bgColor: colors.secondaryColor,radius: 10,)
                  ],),
                ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
        ],),
      ),
    );
  }
}
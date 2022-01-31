import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/ConfirmPaymentController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/PaymentScreen/PaymentConfirmPopup.dart';
class ConfirmPaymentScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
 ConfirmPaymentController _confirmationController= Get.put(ConfirmPaymentController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle1: true,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showAppBar: true,
      titleClr:colors.blackColor ,
      screenNamee: "Confirmation",
      child: Column(children: [
           Container(
                width: responsive.setWidth(90),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(4)),
                      child: MyText(title: "Order Information",size: 16,clr: colors.blackColor),),
                       Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(1)),
                      child: MyText(title: "Today,3 March, 19:00 1 Pet Dog,Max Pet",size: 15,clr: colors.gray,toverflow: TextOverflow.ellipsis,),),
                        Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(4)),
                      child: MyText(title: "Name",size: 16,clr: colors.blackColor,),),
                       Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(1)),
                      child: MyText(title: "John Johnson",size: 15,clr: colors.gray,toverflow: TextOverflow.ellipsis,),),
                        Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(4)),
                      child: MyText(title: "Phone",size: 16,clr: colors.blackColor),),
                       Padding(
                       padding: EdgeInsets.only(
                      left: responsive.setWidth(4),
                     
                      top: responsive.setHeight(1)),
                      child: MyText(title: "+1 (245) 648 - 24 - 35",size: 15,clr: colors.gray,toverflow: TextOverflow.ellipsis,),),
                      Padding(
                        padding:  EdgeInsets.only(left:   responsive.setWidth(4),right:  responsive.setWidth(2),top: responsive.setHeight(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          MyText(title: "Confirmation Code",size: 16,clr: colors.blackColor),
                           MyText(title: "Your phone is confirm",size: 14,clr: colors.primaryColor),
                        ],),
                      ),
                       Padding(
                        padding:  EdgeInsets.only(left:   responsive.setWidth(4),right:  responsive.setWidth(2),top: responsive.setHeight(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         Expanded(
                           child: Container(
                             margin: EdgeInsets.all(responsive.setWidth(3)),
                             decoration: BoxDecoration(
                               border: Border.all(color: colors.gray),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: MyTextField(
                               hintText: "1",
                               onChanged: (v){
                                  FocusScope.of(context).requestFocus(_confirmationController.focusNode2); 
                                 
                               },
                               inputAction: TextInputAction.next,
                               horizontalPadding: responsive.setWidth(6),
                               inputType: TextInputType.number,
                               inputFormate: _confirmationController.confirmCode,
                               
                                textColor: colors.primaryColor,
                               hintTextColor: colors.primaryColor,
                              
                              borderColor: Colors.transparent,
                             ),
                           )),
                           Expanded(
                           child: Container(
                             margin: EdgeInsets.all(responsive.setWidth(3)),
                             decoration: BoxDecoration(
                               border: Border.all(color: colors.gray),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: MyTextField(
                               hintText: "1",
                               onChanged: (v){
                                  FocusScope.of(context).requestFocus(_confirmationController.focusNode3); 
                                 
                               },
                               focusNode: _confirmationController.focusNode2,
                               inputAction: TextInputAction.next,
                               horizontalPadding: responsive.setWidth(6),
                               inputFormate: _confirmationController.confirmCode,
                               inputType: TextInputType.number,
                           
                              borderColor: Colors.transparent,
                               textColor: colors.primaryColor,
                               hintTextColor: colors.primaryColor,
                             ),
                           )),
                           Expanded(
                           child: Container(
                             margin: EdgeInsets.all(responsive.setWidth(3)),
                             decoration: BoxDecoration(
                               border: Border.all(color: colors.gray),
                               
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: MyTextField(
                               hintText: "1",
                               focusNode: _confirmationController.focusNode3,
                              onChanged: (v){
                                  FocusScope.of(context).requestFocus(_confirmationController.focusNode4); 
                                 
                               },
                               inputAction: TextInputAction.next,
                               horizontalPadding: responsive.setWidth(6),
                               inputFormate: _confirmationController.confirmCode,
                               inputType: TextInputType.number,
                              
                              borderColor: Colors.transparent,
                             textColor: colors.primaryColor,
                               hintTextColor: colors.primaryColor,
                             ),
                           )),
                           Expanded(
                           child: Container(
                            margin: EdgeInsets.all(responsive.setWidth(3)),
                             decoration: BoxDecoration(
                               border: Border.all(color: colors.gray),
                               borderRadius: BorderRadius.circular(10),
                               
                             ),
                             child: MyTextField(
                               hintText: "1",
                               focusNode: _confirmationController.focusNode4,
                               inputAction: TextInputAction.done,
                               horizontalPadding: responsive.setWidth(6),
                               inputFormate: _confirmationController.confirmCode,
                               textColor: colors.primaryColor,
                               hintTextColor: colors.primaryColor,
                               inputType: TextInputType.number,
                         
                              borderColor: Colors.transparent,
                             ),
                           )),
                        
                        ],),
                      ),
                    
                      SizedBox(height: 20,)
                  ],
                ),
                ),
                  Padding(
                        padding:EdgeInsets.only(top: responsive.setHeight(4),left:responsive.setHeight(4) ,right:responsive.setHeight(4),bottom: responsive.setHeight(4) ) ,
                        child: MyButton(bgColor: colors.secondaryColor,title: "Payment",fontSize: 18,height: responsive.setHeight(7),radius: 10,onTap: (){
                          var check=_confirmationController.checkConfirmCode();
                          if(check==true){
                            // showAlertDialog(context);
                             showDialog(
context:context,
    builder:(BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: ConfirmPaymentPopup(),
      );
    } 
  );
                          }
                        },),
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                            Icon(Icons.arrow_back_sharp,color: colors.gray,size: 18,),
                            MyText(title: "Prevoius Step",size: 18,clr: colors.gray,)
                      ],)
      ],),
    );
  }
}
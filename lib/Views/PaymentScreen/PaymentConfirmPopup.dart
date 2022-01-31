import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
class ConfirmPaymentPopup extends StatelessWidget {
  
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
        padding: EdgeInsets.all(responsive.setWidth(2)),
          decoration: BoxDecoration(
            color: colors.primaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
        
        
         width: responsive.setWidth(100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(icon: Icon(Icons.close,color: colors.textColor,),onPressed: (){
                Get.back();
                },)
                ),
              Image.asset(ImagePath.popupSuccess,fit: BoxFit.cover,height: responsive.setHeight(12),),
              Padding(
                padding:  EdgeInsets.only(top: responsive.setHeight(2)),
                child: MyText(title: "Thank You",center: true,clr: colors.textColor,size: 20,weight: "Bold",),
                
              ),
              Padding(
                padding:  EdgeInsets.only(top: responsive.setHeight(2)),
                child: MyText(title: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat",center: true,clr: colors.textColor,size: 16,line: 6,),
                
              ),
               Padding(
                padding:  EdgeInsets.all( responsive.setHeight(4)),
                child: MyButton(
                  height: responsive.setHeight(8),
                  radius: 10,
                  title: "Got It",bgColor: colors.secondaryColor,fontSize: 20,onTap: (){
                      // Get.offNamed("/HomeScreen");
                       Get.back();
                },),
                
              ),
            ],
          ),
      );
  }
}
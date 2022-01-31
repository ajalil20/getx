import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
class MeetingRequestPopup extends StatelessWidget {
 Responsive responsive = Responsive();
 ColorConfig colors =ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      padding: EdgeInsets.all(responsive.setHeight(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
        colors: [
            colors.darkYellow.withOpacity(0.9),
            colors.darkYellow.withOpacity(0.9)
      ])),
              height: responsive.setHeight(75),
              width: responsive.setWidth(100),
              child: Column(
              
                children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.close,color: colors.whiteColor,)),
                    ),
                    Image.asset(ImagePath.meetingIcn),
                    MyText(title: "MEETING REQUEST",size: 16,),
                    Wrap(children: [
                    MyText(title: "FOR ",size: 16,),
                    MyText(title: "NJ SHELTER",clr: colors.whiteColor,size: 16,),
                  
                    ],),
                      Expanded(

                      child: ListView.builder(
                        itemCount: 4,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Container(
                              margin: EdgeInsets.only(bottom: responsive.setHeight(2.5)),
                              padding: EdgeInsets.only(top:responsive.setWidth(3),right:responsive.setWidth(3),left: responsive.setWidth(3),bottom: responsive.setWidth(5) ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.darkYellow),
                              child:Column(
                            children: [
                              Row(children: [
                                MyText(title: "Vanessa feirdro",size: 16,clr: colors.blackColor,),
                                MyText(title: "Pet Grooming",size: 16,clr: colors.blackColor,),

                              Icon(Icons.more_horiz)


                              ],),
                              MyText(title: "Vanesa has requested to schedule an a appointment with Garfield for 9/14/21 at 12:00 EST",size: 16,clr: colors.whiteColor)
                            ],
                          ) ,),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: MyButton(title: "Log Meeting",height: responsive.setHeight(5),bgColor: colors.primaryColor,width: responsive.setWidth(40),fontSize: responsive.setTextScale(12),radius: 10,))
                          
                          ],),
                        );
                      }),
                    ),
                 MyButton(
                  onTap: (){
                  
                  },
                   title: "View More",bgColor: colors.whiteColor,elevation: 5,radius: 15,fontSize: 15,textColor: colors.primaryColor,width: responsive.setWidth(40),),
                 SizedBox(height: responsive.setHeight(4))
                     
            ],
            ),
            );
  }
}
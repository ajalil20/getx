import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/MeetRequest/MeetingRequestPopup.dart';
class MeetingRequest extends StatelessWidget {
 ColorConfig colors = ColorConfig();
 Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle1: true,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: false,
      child: Stack(children: [
         Padding(
           padding:  EdgeInsets.only(left: responsive.setWidth(4),top: responsive.setHeight(2)),
           child: Column(
             children: [
               Row(
            
                 children: [
                   MyCircleImage(
                   imgPath: 'assets/users/userImage.png',
                   borderColor: Colors.transparent,
                   size: responsive.setWidth(2),
                 ),
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       MyText(
                         title: '  Anna Bills',
                         size: 17,
                         weight: 'Semi Bold',
                         toverflow: TextOverflow.ellipsis,
                       ),
                       Row(
                         children: [
                           Icon(
                             Icons.location_on_outlined,
                             color: colors.primaryColor,
                           ),
                           Expanded(
                             child: MyText(
                               title: 'Bali, California ',
                               clr: colors.secondaryColor,
                               toverflow: TextOverflow.ellipsis,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ],),
                     SizedBox(
                     height: responsive.setHeight(1),
                   ),
                   Divider(thickness: 1,color: colors.gray,indent: responsive.setWidth(4)),
                  
              
             ],
           ),
         ),
          Positioned(
                     right: 0,
                     top: 0,
                     child:Image.asset(
                     'assets/pets/sideDog.png',
                     width: responsive.setWidth(35),
                     fit: BoxFit.cover,
                   ),),
          Positioned(
            top: responsive.setHeight(15),
            child: Container(
              height: responsive.setHeight(85),
              width: responsive.setWidth(100),
              child: Column(
              
                children: [
                    Image.asset(ImagePath.meetingIcn),
                    MyText(title: "MEETING REQUEST",size: 16,),
                    Wrap(children: [
                    MyText(title: "FOR ",size: 16,),
                    MyText(title: "NJ SHELTER",clr: colors.primaryColor,size: 16,),
                  
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
                                color: colors.containerChat),
                              child:Column(
                            children: [
                              Row(children: [
                                MyText(title: "Vanessa feirdro",size: 16,clr: colors.blackColor,),
                                MyText(title: "Pet Grooming",size: 16,clr: colors.blackColor,),

                              Icon(Icons.more_horiz)


                              ],),
                              MyText(title: "Vanesa has requested to schedule an a appointment with Garfield for 9/14/21 at 12:00 EST",size: 16,clr: colors.gray)
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
                     showDialog(
context:context,
    builder:(BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: MeetingRequestPopup(),
      );
    } 
  );
                  },
                   title: "View More",bgColor: colors.whiteColor,elevation: 5,radius: 15,fontSize: 15,textColor: colors.primaryColor,width: responsive.setWidth(40),),
                 SizedBox(height: responsive.setHeight(4))
                     
            ],
            ),
            ),
          )     
      ],),
    );
  }
}
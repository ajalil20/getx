import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
class SendStory extends StatelessWidget {
 Responsive responsive = Responsive();
 ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle1: false,
      showAppBar: false,
      showBottomBar: false,
      child: Container(
        height:responsive.setHeight(100) ,
        width: responsive.setWidth(100),
        decoration:BoxDecoration(

          image: DecorationImage(image: AssetImage(ImagePath.pet),fit: BoxFit.cover)
        ),
        child:BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Wrap(children: [
              IconButton(onPressed: (){}, icon:Icon( Icons.arrow_back),color: colors.whiteColor,),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){}, icon:Icon( Icons.bolt),color: colors.whiteColor,)),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){}, icon:Icon( Icons.title),color: colors.whiteColor,)),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){}, icon:Icon( Icons.queue_music),color: colors.whiteColor,)),
            ],),
           Wrap(children: [
             Align(
                 alignment: Alignment.center,
                 child: InkWell(
                     onTap: (){

                     },
                     child: Image.asset(ImagePath.storyImageIcon))),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 IconButton(onPressed: (){}, icon:Icon( Icons.collections),color: colors.whiteColor,),
                 Wrap(
                   direction: Axis.vertical,
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children: [
                     MyText(title: "Story",size: 20,clr: colors.whiteColor,weight: "Bold",),
                     Container(height: 2,width: responsive.setWidth(12),color: colors.whiteColor,),
                   ],),
                 IconButton(onPressed: (){}, icon:Icon( Icons.send_sharp),color: colors.whiteColor,),

               ],)
           ],)

            ],),
        ),),
    );
  }
}
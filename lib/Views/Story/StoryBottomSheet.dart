import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
class StoryBottomSheet extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        height: responsive.setHeight(80),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          image:DecorationImage(
            image: AssetImage(ImagePath.pet),
            fit: BoxFit.cover
          )
        ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCircleImage(
                imgPath: 'assets/users/userImage.png',
                borderColor: Colors.transparent,
                size: responsive.setWidth(2),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: 'Anna Bills',
                        size: 20,

                        clr: colors.whiteColor,
                        toverflow: TextOverflow.ellipsis,
                      ),
                      MyText(
                        title: '15 min ago',
                        clr: colors.whiteColor,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.close,color: colors.whiteColor,))
            ],
          ),
        ),
        MyTextField(
        hintText: "Send message",
          fullBorder: true,
          backgroundColor: colors.whiteColor.withOpacity(0.8),
          hintTextColor: colors.primaryColor,
          suffixIconData: Icons.send_sharp,
          sufixIconColor: colors.primaryColor,
          borderColor: colors.whiteColor,
          onTapSuffixFaIcon: (){
          Get.back();
          },
        ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
      ],),
      ),
    );


  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';

class IntroScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Scaffold(
      body: Container(
        height: responsive.setHeight(100),
        width: responsive.setWidth(100),
        color: colors.whiteColor,
        child: Stack(
          children: [
            Positioned(
              left: responsive.setWidth(65),
              bottom: responsive.setHeight(78),
              child: Container(
                height: responsive.setHeight(35),
                width: responsive.setHeight(50),
                decoration: BoxDecoration(
                  color: colors.primaryColor,
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            Positioned(
              left: responsive.setWidth(85),
              bottom: responsive.setHeight(-5),
              child: Container(
                height: responsive.setHeight(15),
                width: responsive.setHeight(15),
                decoration: BoxDecoration(
                    color: colors.primaryColor,
                    borderRadius: BorderRadius.circular(200)),
              ),
            ),
            Positioned(
              left: responsive.setWidth(-15),
              bottom: responsive.setHeight(28),
              child: Container(
                height: responsive.setHeight(15),
                width: responsive.setHeight(15),
                decoration: BoxDecoration(
                    color: colors.primaryColor,
                    borderRadius: BorderRadius.circular(200)),
              ),
            ),
            //Main Image
            Positioned(
                top: responsive.setHeight(30),
                child: Container(
                  height: responsive.setHeight(45),
                  width: responsive.setWidth(100),
                  child: Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.fitWidth,
                  ),
                )),
            Positioned(
              top: responsive.setHeight(10),
              child: Container(
                width: responsive.setWidth(100),
                child: MyText(
                  title: '${TextConstant.en["IntroScreen"]["HeadingP1"]}',
                  clr: colors.blackColor,
                  // weight: 'Semi Bold',
                  center: true,
                  size: responsive.setHeight(4),
                ),
              ),
            ),
            Positioned(
              top: responsive.setHeight(15),
              child: Container(
                width: responsive.setWidth(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: MyText(
                    title: '${TextConstant.en["IntroScreen"]["HeadingP2"]}',
                    clr: colors.blackColor,
                    center: true,
                  ),
                ),
              ),
            ),
            //Buttons
            Positioned(
              top: responsive.setHeight(75.5),
              child: Container(
                width: responsive.setWidth(100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyElevatedButton(
                      onTap: () {
                        // Get.toNamed('/login');
                        // Get.offAndToNamed('/login');
                      },
                      height: responsive.setHeight(7.5),
                      width: responsive.setWidth(90),
                      title: '${TextConstant.en["IntroScreen"]["SignUpBtn"]}',
                      textColor: colors.primaryColor,
                      isImage: true,
                      imageColor: colors.blackColor.withOpacity(0.3),
                      fontSize:  responsive.setTextScale(16),

                    ),
                    SizedBox(
                      height: responsive.setHeight(2),
                    ),
                    MyButton(
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      height: responsive.setHeight(7.5),
                      width: responsive.setWidth(90),
                      radius: 10,
                      title: '${TextConstant.en["IntroScreen"]["CreateAccount"]}',
                      bgColor: colors.bgFieldColor,
                      fontSize:  responsive.setTextScale(15),

                    ),
                    SizedBox(
                      height: responsive.setHeight(3),
                    ),
                    InkWell(
                      onTap: (){
                        Get.toNamed('/login');
                      },
                      child: MyText(
                        title:
                            '${TextConstant.en['IntroScreen']['AccountHolder']}',
                        clr: colors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

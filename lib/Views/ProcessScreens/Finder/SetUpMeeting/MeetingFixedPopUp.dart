import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class MeetingFixedPopUp extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      decoration: BoxDecoration(
          color: colors.primaryColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            // Align(
            //   alignment: Alignment.topRight,
            //   child: GestureDetector(
            //     onTap: (){
            //       Get.back();
            //     },
            //     child: Icon(
            //       Icons.close,
            //       color: colors.whiteColor,
            //     ),
            //   ),
            // ),
            Image.asset('assets/icons/popSuccess.png'),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            MyText(
              title: 'Successfully Fixed',
              weight: 'Semi Bold',
              size: responsive.setTextScale(22),
              clr: colors.whiteColor,
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            MyText(
              title:
                  '''We can't wait for you to meet your new friend your appointment is booked , the meeting will be fixed As soon as possible.''',
              size: responsive.setTextScale(16),
              center: true,
              clr: colors.whiteColor,
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            MyText(
              title: 'Thank you !',
              weight: 'Semi Bold',
              size: responsive.setTextScale(22),
              clr: colors.whiteColor,
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            MyButton(
              onTap: (){
               Get.toNamed("/finderHome");
              },
              width: responsive.setWidth(30),
              title: 'Got it',
              bgColor: colors.whiteColor,
              textColor: colors.primaryColor,
              radius: 10,
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
          ],
        ),
      ),
    );
  }
}

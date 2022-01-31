import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_tag_selection.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/custom_slider.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class LocationBottomSheetContent extends StatelessWidget {
  ProfileSettingController controller = Get.put(ProfileSettingController());
  ColorConfig colors = ColorConfig();
  Responsive respons = Responsive();

  @override
  Widget build(BuildContext context) {
    respons.setContext(context);
    return Container(
        height: respons.setHeight(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.blackColor.withOpacity(0.5),
                  colors.blackColor.withOpacity(0.5),
                ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              title: "Current Location",
              size: 15,
              clr: colors.textColor,
            ),

            // MyText(
            //   title: '${controller.user.value.result!.locationName}',
            //   size: 13,
            //   clr: colors.textColor,
            // ),

            Padding(
              padding: EdgeInsets.only(
                  left: respons.setWidth(10),
                  right: respons.setWidth(10),
                  top: 20,
                  bottom: 20),
              child: Center(
                child: MyButton(
                  title: "Update Location",
                  bgColor: colors.primaryColor,
                  height: respons.setHeight(6),
                  fontSize: 18,
                  weight: "Bold",
                  radius: 10,
                  onTap: () {
                    controller.determinePosition(context);
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}

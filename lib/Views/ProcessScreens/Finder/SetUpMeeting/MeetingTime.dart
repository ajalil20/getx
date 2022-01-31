import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/select_time_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/SetUpMeeting/MeetingFixedPopUp.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class MeetingTimeScreen extends StatelessWidget {
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  SelectTimeController selectTimeController = Get.put(SelectTimeController());
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
  // showTime(context);
    return BaseView(
      screenNamee: 'Select Time',
      titleFontSize: 20,
      titleClr: colors.blackColor,
      showCircle3: false,
      align1Top: 70,
      align1Bottom: 85,
      align2Top: -30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            color: colors.primaryColor,
          ),
          MyElevatedButton(
            width: responsive.setWidth(55),
            height: responsive.setHeight(6.5),
            bgColor: colors.primaryColor,
            imageColor: colors.blackColor.withOpacity(0.3),
            title: 'Fixed Meeting',
            isImage: true,
            onTap: (){

              // Get.dialog(
              //     MeetingFixedPopUp()
              // );
            },
          ),
        ],
      ),
    );
  }

}

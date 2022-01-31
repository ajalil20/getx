// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/SetUpMeeting/MeetingFixedPopUp.dart';
import 'package:pawndr/Views/widgets/pets_card.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SetUpMeetingScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController usercontroller = Get.put(UserController());
  PetScreenController petScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      screenNamee: 'Select Month',
      titleFontSize: 20,
      titleClr: colors.blackColor,
      showCircle3: false,
      align2Top: -30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: responsive.setHeight(3),
              ),
              Row(
                children: [
                  ProfileImage(),
                  SizedBox(
                    width: responsive.setWidth(3),
                  ),
                  Container(
                    width: responsive.setWidth(50),
                    child:RichText(text: TextSpan(
                        text:"Hey ${usercontroller.user.value.result!.name!}" ,
                        style: TextStyle(fontSize: responsive.setTextScale(17),fontWeight: FontWeight.w500,color: colors.blackColor),
                        children: [
                          TextSpan(text: ", Schedule A Meetup with your friend",style:  TextStyle(fontSize: responsive.setTextScale(14),fontWeight: FontWeight.normal))
                        ]),
                  ))
                ],
              ),
              SizedBox(
                height: responsive.setHeight(3),
              ),
              Divider(
                color: colors.primaryColor,
              ),
              SfDateRangePicker(
                enablePastDates: false,
                view: DateRangePickerView.month,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                 usercontroller.selectedDate.value=args.value;
                },
                selectionColor: colors.secondaryColor,

                headerStyle: DateRangePickerHeaderStyle(

                  textAlign: TextAlign.center
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(

                ),

              ),
              SizedBox(height: responsive.setHeight(15),),

              Center(
                child: MyElevatedButton(
                  onTap: () {
                    petScreenController.showTime(context);
                  },
                  width: responsive.setWidth(55),
                  title: 'Continue',
                  isImage: true,
                  bgColor: colors.primaryColor,
                  imageColor: colors.blackColor.withOpacity(0.3),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

}

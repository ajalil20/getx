import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/help_controller.dart';
import 'package:pawndr/Controller/termscondition_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class TermsScreen extends StatelessWidget {
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  TermsConditionController controller = Get.put(TermsConditionController());
  
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      align1Top: 67,
      align1Bottom: 83,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: true,
      screenNamee: 'Terms of service',
      titleFontSize: responsive.setTextScale(20),
      titleClr: colors.blackColor,
      child: Obx(()=> Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(4))+EdgeInsets.only(top: responsive.setHeight(10)),
              child: Container(
                  height: responsive.setHeight(68),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: MyText(
                      title:'${controller.termsCondition.value}',
                      size: responsive.setTextScale(14),
                    ),
                  )),
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
      controller.controller.user.value.result!.termsCondition !="true"?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => MyButton(
                    onTap: () {
                      controller.isAccepted.value = true;
                      controller.updateTermsAndCondtion();
                    },
                    width: responsive.setWidth(30),
                    title: 'Accept',
                    bgColor: controller.isAccepted == true
                        ? colors.secondaryColor
                        : Colors.transparent,
                    textColor: controller.isAccepted == true
                        ? colors.whiteColor
                        : colors.hintColor,
                    borderColor: controller.isAccepted == true
                        ? Colors.transparent
                        : colors.hintColor,
                  ),
                ),
                SizedBox(
                  width: responsive.setWidth(5),
                ),
                Obx(() => MyButton(
                      onTap: () {
                        controller.isAccepted.value = false;
                      },
                      width: responsive.setWidth(30),
                      title: 'Decline',
                      bgColor: controller.isAccepted == false
                          ? colors.secondaryColor
                          : Colors.transparent,
                      textColor: controller.isAccepted == false
                          ? colors.whiteColor
                          : colors.drawerColor,
                      borderColor: controller.isAccepted == false
                          ? Colors.transparent
                          : colors.drawerColor,
                    )),
              ],
            )
          : Container()
          ],
        ),
      ),
    );
  }
}

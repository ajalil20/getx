// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_circlewithicon.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_seprator.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/forgotpassword_controller.dart';
import 'package:pawndr/Controller/signInController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showDrawer: false,
      showCircle2: false,
      showCircle1: true,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: true,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [

                SizedBox(
                  height: responsive.setHeight(1),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: responsive.setWidth(40),
                ),
                SizedBox(
                  height: responsive.setHeight(3),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: MyText(
                    title: '${TextConstant.en['ForgotPassword']['Heading']}',
                    clr: colors.blackColor.withOpacity(0.8),
                    size: responsive.setTextScale(20),
                    // weight: 'Bold',
                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                MyTextField(
                  controller: controller.email.value,
                  width: responsive.setWidth(90),
                  prefixIconData: Icons.email_outlined,
                  prefixIconColor: colors.primaryColor,
                  hintText: '${TextConstant.en['Login']['Email']}',
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                                SizedBox(
                  height: responsive.setHeight(3),
                ),
                MyElevatedButton(
                  onTap: () {
                    controller.validation();
                  },
                  height: responsive.setHeight(7.5),
                  width: responsive.setWidth(90),
                  title: '${TextConstant.en['ForgotPassword']['Button']}',
                  textColor: colors.whiteColor,
                  bgColor: colors.primaryColor,
                  isImage: false,
                ),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                MyText(
                  title: '${TextConstant.en['ForgotPassword']['HaveAccount']}',
                  clr: colors.hintColor,
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed("/login");
                  },
                  child: MyText(
                    title: '${TextConstant.en['ForgotPassword']['SignIn']}',
                    clr: colors.secondaryColor,
                  ),
                ),
                Image.asset(
                  'assets/images/cat.png',
                  width: responsive.setWidth(65),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

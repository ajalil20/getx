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
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  ForgotPasswordController controller = Get.find();
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
                  alignment: Alignment.center,
                  child: MyText(
                    title: 'Check your email',
                    clr: colors.blackColor.withOpacity(0.8),
                    size: responsive.setTextScale(20),
                    // weight: 'Bold',
                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    title: 'We\'ve sent you a  code, please enter the code to verify your account.',
                    clr: colors.hintColor.withOpacity(0.8),
                    size: responsive.setTextScale(14),
                    // weight: 'Bold',
                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(3)),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    // controller: controller.otp,
                    // backgroundColor: colors.primaryColor,
                    onChanged: (val) {},
                    // onCompleted: controller.verifyCode,
                    // boxShadows: [BoxShadow(color: colors.textColor)],
                    autoDismissKeyboard: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      selectedColor: colors.secondaryColor,
                      fieldWidth: responsive.setWidth(10),
                      fieldHeight: responsive.setHeight(6),
                      activeFillColor: colors.textColor,
                      borderRadius: BorderRadius.circular(5),
                      inactiveColor: colors.secondaryColor,
                      activeColor: colors.secondaryColor,
                      borderWidth: 1,
                    ),
                    textStyle: TextStyle(color: colors.secondaryColor,),
                    cursorColor: colors.secondaryColor,
                    keyboardType: TextInputType.number,
                    onCompleted: (val) {
                      controller.otpCode!.value = val.toString();
                    },

                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                SizedBox(
                  height: responsive.setHeight(3),
                ),
                MyElevatedButton(
                  onTap: () {
                    controller.validateOtp();
                  },
                  height: responsive.setHeight(7.5),
                  width: responsive.setWidth(90),
                  title: 'Verify OTP',
                  textColor: colors.whiteColor,
                  bgColor: colors.primaryColor,
                  isImage: false,
                ),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                MyText(
                  title: 'Didn\'t receive a code?',
                  clr: colors.hintColor,
                ),
                InkWell(
                  onTap: (){
                   controller.sendOTP();
                  },
                  child: MyText(
                    title: 'Resend',
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

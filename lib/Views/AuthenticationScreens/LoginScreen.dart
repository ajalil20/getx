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
import 'package:pawndr/Controller/signInController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showDrawer: false,
      showCircle2: false,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
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
                    title: '${TextConstant.en['Login']['Heading']}',
                    clr: colors.blackColor.withOpacity(0.8),
                    size: responsive.setWidth(7),
                    // weight: 'Bold',
                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                MyTextField(
                  controller: _loginController.email,
                  width: responsive.setWidth(90),
                  prefixIconData: Icons.email_outlined,
                  prefixIconColor: colors.primaryColor,
                  hintText: '${TextConstant.en['Login']['Email']}',
                  focusNode: _loginController.f1.value,
                  onFieldSubmit: (val) {
                    _loginController.f1.value.unfocus();
                    FocusScope.of(context).requestFocus(_loginController.f2.value);
                  },
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
               Obx(()=> MyTextField(
                 width: responsive.setWidth(90),
                 controller:  _loginController.password,
                 prefixIconData: Icons.lock_outline,
                 prefixIconColor: colors.primaryColor,
                 obscureText: _loginController.showPassword.value,
                 hintText: '${TextConstant.en['Login']['Password']}',
                 suffixIconData:_loginController.showPassword.value==false ?Icons.visibility:Icons.visibility_off,
                 sufixIconColor:_loginController.showPassword.value==false ? colors.secondaryColor:colors.gray,
                 onTapSuffixIcon: (){
                    _loginController.showPassword(!_loginController.showPassword.value);
                 },
                 focusNode: _loginController.f2.value,
                 onFieldSubmit: (val) {
                   _loginController.f2.value.unfocus();
                 },
               ),),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){Get.toNamed('/forgotPassword');},
                    child: MyText(
                      title: '${TextConstant.en['Login']['ForgotPassword']}',
                      clr: colors.secondaryColor,
                      size: responsive.setTextScale(14),
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(2),
                ),
                Row(
                  children: [
                  Obx(()=>  Checkbox(
                      value: _loginController.remeberMeLogin.value,
                      onChanged: (val) {
                        _loginController.remeberMeLogin(val);
                      },
                      activeColor: colors.secondaryColor),),
                    MyText(
                      title: '${TextConstant.en['Login']['Remember']}',
                      size: responsive.setTextScale(12),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsive.setHeight(3),
                ),
                MyElevatedButton(
                  onTap: () { _loginController.f1.value.unfocus();_loginController.f2.value.unfocus();
                  // if(_loginController.email.text=="V"){
                  //    Get.toNamed('/volunteerSelectionPreference');
                  //  }else if(_loginController.email.text=="P"){
                  //    Get.toNamed("/payment");
                  //  }else if(_loginController.email.text=="S"){
                  //    Get.toNamed("/shelterHome");
                  //  }else{
                  //    _loginController.validation(context);
                  //  }
                  _loginController.validation(context);
                  },
                  height: responsive.setHeight(7.5),
                  width: responsive.setWidth(90),
                  title: '${TextConstant.en['Login']['Heading']}',
                  textColor: colors.whiteColor,
                  bgColor: colors.primaryColor,
                  // isImage: true,
                ),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                InkWell(
                  onTap: (){
                    Get.toNamed("/signup");
                  },
                  child: MyText(
                    title: '${TextConstant.en['Login']['NoAccount']}',
                    clr: colors.hintColor,
                    size: responsive.setTextScale(13),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.toNamed("/signup");
                  },
                  child: MyText(
                    title: '${TextConstant.en['SignUp']['Heading']}',
                    clr: colors.secondaryColor,
                    size: responsive.setTextScale(13),

                  ),
                ),
                SizedBox(
                  height: responsive.setHeight(1.5),
                ),
                MySeprator(),
                SizedBox(
                  height: responsive.setHeight(1.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      padding: EdgeInsets.only(left:responsive.setWidth(3),right: responsive.setWidth(3)),
                      height: responsive.setHeight(5),
                      decoration: BoxDecoration(color: colors.blackColor,borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      FaIcon(
                        FontAwesomeIcons.apple,
                        color: colors.whiteColor,
                        // size: responsive.setTextScale(18),

                      ),
                      Container(width: responsive.setWidth(2),),
                      MyText(title: "Continue With",size:responsive.setTextScale(13),clr: colors.whiteColor,
                      )

                    ],),),
                    Row(
                      children: [
                        // CircleWithIcon(
                        //   height: responsive.setWidth(14),
                        //   width: responsive.setWidth(14),
                        //   withImg: true,
                        //   img: 'assets/icons/google.png',
                        //   bgColor: colors.secondaryColor,
                        // ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors.secondaryColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          height: responsive.setWidth(14),
                           width: responsive.setWidth(14),
                          child: FaIcon(
                            FontAwesomeIcons.google,
                            color: colors.whiteColor,

                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colors.blueFb,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          height: responsive.setWidth(14),
                          width: responsive.setWidth(14),
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: colors.whiteColor,

                          ),
                        )
                        // CircleWithIcon(
                        //   height: responsive.setWidth(14),
                        //   width: responsive.setWidth(14),
                        //   withImg: true,
                        //   img: 'assets/icons/facebook.png',
                        //   bgColor: colors.blueFb,
                        // ),
                      ],
                    )
                  ],
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

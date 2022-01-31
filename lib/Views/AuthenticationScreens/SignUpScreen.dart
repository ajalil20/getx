// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_circlewithicon.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_seprator.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/signUpController.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class SignUpScreen extends StatelessWidget {
  SignupController _signupController = Get.put(SignupController());
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
      align3Top: -10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SingleChildScrollView(
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
                  title: '${TextConstant.en['SignUp']['Heading']}',
                  clr: colors.blackColor.withOpacity(0.8),
                  // size: responsive.setTextScale(16),
                  // weight: 'Bold',
                  size: responsive.setWidth(7),

                ),
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              MyTextField(
                width: responsive.setWidth(90),
                prefixIconData: Icons.person_outline,
                prefixIconColor: colors.primaryColor,
                hintText: '${TextConstant.en['SignUp']['Name']}',
                controller: _signupController.name,
                focusNode: _signupController.f1.value,
                onFieldSubmit: (val) {
                  _signupController.f1.value.unfocus();
                  FocusScope.of(context)
                      .requestFocus(_signupController.f2.value);
                },
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              MyTextField(
                width: responsive.setWidth(90),
                prefixIconData: Icons.phone_in_talk_outlined,
                prefixIconColor: colors.primaryColor,
                hintText: '${TextConstant.en['SignUp']['Phone']}',
                controller: _signupController.phone,
                inputType: TextInputType.phone,
                focusNode: _signupController.f2.value,
                onFieldSubmit: (val) {
                  _signupController.f2.value.unfocus();
                  FocusScope.of(context)
                      .requestFocus(_signupController.f3.value);
                },
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              MyTextField(
                width: responsive.setWidth(90),
                prefixIconData: Icons.email_outlined,
                prefixIconColor: colors.primaryColor,
                hintText: '${TextConstant.en['SignUp']['Email']}',
                controller: _signupController.email,
                focusNode: _signupController.f3.value,
                onFieldSubmit: (val) {
                  _signupController.f3.value.unfocus();
                  FocusScope.of(context)
                      .requestFocus(_signupController.f4.value);
                },
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              Obx(
                () => MyTextField(
                  width: responsive.setWidth(90),
                  prefixIconData: Icons.lock_outline,
                  obscureText: _signupController.showPassword.value,
                  prefixIconColor: colors.primaryColor,
                  hintText: '${TextConstant.en['SignUp']['Password']}',
                  suffixIconData: _signupController.showPassword.value == false
                      ? Icons.visibility
                      : Icons.visibility_off,
                  sufixIconColor: _signupController.showPassword.value == false
                      ? colors.secondaryColor
                      : colors.gray,
                  onTapSuffixIcon: () {
                    _signupController.showPassword(!_signupController.showPassword.value);
                  },
                  controller: _signupController.password,
                  focusNode: _signupController.f4.value,
                  onFieldSubmit: (val) {
                    _signupController.f4.value.unfocus();
                    FocusScope.of(context)
                        .requestFocus(_signupController.f5.value);
                  },
                ),
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              Obx(
                () => MyTextField(
                  width: responsive.setWidth(90),
                  obscureText: _signupController.showConfirmPassword.value,
                  prefixIconData: Icons.lock_outline,
                  prefixIconColor: colors.primaryColor,
                  hintText: '${TextConstant.en['SignUp']['ConfPassword']}',
                  suffixIconData:
                      _signupController.showConfirmPassword.value == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                  sufixIconColor:
                      _signupController.showConfirmPassword.value == false
                          ? colors.secondaryColor
                          : colors.gray,
                  onTapSuffixIcon: () {
                    _signupController.showConfirmPassword(!_signupController.showConfirmPassword.value);
                  },
                  controller: _signupController.confirmPassword,
                  focusNode: _signupController.f5.value,
                  onFieldSubmit: (val) {
                    _signupController.f5.value.unfocus();
                  },
                ),
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              Container(
                width: responsive.setWidth(90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: colors.hintColor
                  )
                ),

                child: Row(
                  children: [
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: responsive.setWidth(2)),
                  child:
                    Icon(Icons.person_outline,color: colors.primaryColor,size: responsive.setTextScale(26),),
                    ),
                    Container(
                      height: responsive.setHeight(4),
                      width: responsive.setWidth(0.3),
                      color: colors.hintColor,
                    ),
                    InkWell(
                      onTap: (){
                        print("NMun");
                        

                      },
                      child: CoolDropdown(
                        resultHeight: responsive.setHeight(6),
                        dropdownWidth: responsive.setWidth(75),
                        // resultWidth: responsive.setWidth(90),
                        resultWidth: responsive.setWidth(75),
                        isAnimation: false,
                        
                        gap: 0,
                        // resultHeight: responsive.setHeight(10),
                        dropdownHeight: responsive.setHeight(16),
                        placeholder: "User type",
                        dropdownList: _signupController.dropdownItemList,
                        onChange: (val) {
                          _signupController.chosenValue.value = val["value"].toString();
                        },
                       onOpen: (val){
                         FocusScope.of(context).requestFocus(FocusNode());
                         Timer(const Duration(seconds: 100), () {
                         });
                          // _signupController.f1.value.unfocus();_signupController.f2.value.unfocus();_signupController.f3.value.unfocus();_signupController.f4.value.unfocus();_signupController.f5.value.unfocus();

                          },
                        resultIcon: Icon(Icons.expand_more,color: colors.hintColor,),
                        dropdownItemMainAxis: MainAxisAlignment.center,
                        resultAlign: Alignment.centerLeft,
                        dropdownBD:  BoxDecoration(
                          color: colors.primaryColor,
                          borderRadius: BorderRadius.circular(10),

                        ),
                        // resultMainAxis: MainAxisAlignment.center,
                        placeholderTS:  TextStyle(
                          color: colors.hintColor, fontSize: responsive.setTextScale(14),),
                        selectedItemBD:  BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: colors.primaryColor, width: 0))),
                        unselectedItemTS: TextStyle(
                            color: colors.whiteColor, fontSize: responsive.setTextScale(15)),
                        selectedItemTS: TextStyle(
                          color: colors.whiteColor, fontSize: responsive.setTextScale(15),

                        ),
                        resultTS: TextStyle(
                          color: colors.hintColor, fontSize: responsive.setTextScale(14)),
                        // defaultValue: controller.identityList[1],
                        resultBD: BoxDecoration(
                          color: colors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // placeholder: 'insert...',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              Row(
                children: [
                  Obx(() => Checkbox(

                      value: _signupController.acceptTermsAndCondition.value,
                      onChanged: (val) {
                        _signupController.acceptTermsAndCondition(val);
                      },
                      activeColor: colors.secondaryColor)),
                  MyText(
                    size: responsive.setTextScale(11),
                    title: '${TextConstant.en['SignUp']['Terms']
                    }',
                    
                  ),
                ],
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              MyElevatedButton(
                onTap: () {
                  _signupController.validation(context);
                },
                height: responsive.setHeight(7.5),
                width: responsive.setWidth(90),
                title: 'Sign Up',
                textColor: colors.whiteColor,
                bgColor: colors.primaryColor,
                isImage: true,
                imageColor: colors.blackColor.withOpacity(0.3),
              ),
              SizedBox(
                height: responsive.setHeight(1),
              ),
              InkWell(
                onTap: (){                        Get.toNamed('/login');
                },
                child: MyText(
                  title: '${TextConstant.en['SignUp']['HaveAccount']}',
                  clr: colors.blackColor,
                ),
              ),
              SizedBox(
                height: responsive.setHeight(2),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}

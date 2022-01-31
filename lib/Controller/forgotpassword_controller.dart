import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/signup_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:pawndr/Service/base_services.dart';

class ForgotPasswordController extends GetxController{
  UserController controller = Get.put(UserController());
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<SignUpModel> resp = SignUpModel().obs;
  BaseService baseService =BaseService();
  Rx<String>? otpCode = "".obs;
  Rx<FocusNode> f1 = FocusNode().obs;
  Rx<FocusNode> f2 = FocusNode().obs;

  validation() {
    if (email.value.text.isEmpty) {
      CustomToast().showToast("Warning", "Email cannont be empty", true);
    } else if (!email.value.text.isEmail) {
      CustomToast().showToast("Warning", "Enter valid email", true);
    } else{
      sendOTP();
    }
  }
  Future<void> sendOTP() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map jsondata = {
      "email": email.value.text,
    };
    resp.value = await SignUpModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.resetPassword, jsondata,  loading: true,));
    print(resp.value.result);
    if(resp.value.result!=null){
      if (resp.value.result!.code != 0) {
        storage.setString(LocalDBKeys.USERID, resp.value.result!.id!);
        CustomToast().showToast('Success', "A pin code has been sent to your phone", false);
        // if(resp.value.result!.userType=="petfinder") {
          Get.toNamed('/OTPScreen');
        // } else if (resp.value.result!.userType=="volunteershelter") {Get.toNamed('/volunteerInformation');}
      }
    }
    else{
      CustomToast().showToast('Error', resp.value.message!, true);
    }
  }
  void validateOtp()  {
    if(otpCode!.value==resp.value.result!.code.toString())
      {
        Get.toNamed('/ChangePassword');
        CustomToast().showToast("Success", "OTP verified !", false);
      }
    else
    {
      CustomToast().showToast("Incorrect", "Please enter a valid OTP", true);
    }

  }
  void validatePassword()  {
    if (password.value.text.isEmpty) {
      CustomToast().showToast("Warning", "Password cannont be empty", true);
    }
    else if (password.value.text.length<8) {
      CustomToast().showToast("Warning", "Password length should be at least 8 characters", true);
    }
    else if (password.value.text != confirmPassword.value.text) {
      CustomToast().showToast("Warning", "Password do not match", true);
    } else{
      // sendOTP();
    }
  }
  Future<void> sendConfirmPassword() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map jsondata = {
      "email": email.value.text,
    };
    resp.value = await SignUpModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.resetPassword, jsondata,  loading: true,));
    print(resp.value.result);
    if(resp.value.result!=null){
      if (resp.value.result!.code != 0) {
        storage.setString(LocalDBKeys.USERID, resp.value.result!.id!);
        CustomToast().showToast('Success', "A pin code has been sent to your phone", false);
        // if(resp.value.result!.userType=="petfinder") {
        Get.toNamed('/OTPScreen');
        // } else if (resp.value.result!.userType=="volunteershelter") {Get.toNamed('/volunteerInformation');}
      }
    }
    else{
      CustomToast().showToast('Error', resp.value.message!, true);
    }
  }

}
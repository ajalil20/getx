import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/chat_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/signup_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:pawndr/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'finderhome_controller.dart';

class SignupController extends GetxController {
  UserController controller = Get.put(UserController());

  // RxString name = ''.obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  RxBool acceptTermsAndCondition = false.obs;
  BaseService baseService = BaseService();
  Rx<SignUpModel> resp = SignUpModel().obs;
  RxString chosenValue = "petfinder".obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  Rx<FocusNode> f1 = FocusNode().obs;
  Rx<FocusNode> f2 = FocusNode().obs;
  Rx<FocusNode> f3 = FocusNode().obs;
  Rx<FocusNode> f4 = FocusNode().obs;
  Rx<FocusNode> f5 = FocusNode().obs;

  List dropdownItemList = [
    {
      'label': 'Pet Finder',
      'value': 'petfinder'
    }, // label is required and unique
    {'label': 'Volunteer Shelter', 'value': 'volunteershelter'},
  ];
  validation(context)async {
    if (name.text.isEmpty) {
      FocusScope.of(context).requestFocus(f1.value);
      CustomToast().showToast("Warning", "Name cannot be empty", true);
    } else if (!phone.text.isPhoneNumber) {
      FocusScope.of(context).requestFocus(f2.value);
      CustomToast()
          .showToast("Warning", "Please Enter correct phone number", true);
    } else if (email.text.isEmpty) {
      FocusScope.of(context).requestFocus(f3.value);
      CustomToast().showToast("Warning", "Email cannont be empty", true);
    } else if (!email.text.isEmail) {
      CustomToast().showToast("Warning", "Enter valid email", true);
    } else if (password.text.isEmpty) {
      FocusScope.of(context).requestFocus(f4.value);
      CustomToast().showToast("Warning", "Password cannot be empty", true);
    } else if (password.text.length < 8) {
      CustomToast().showToast("Warning", "Password should be 8 digit", true);
    } else if (confirmPassword.text.isEmpty) {
      FocusScope.of(context).requestFocus(f4.value);
      CustomToast().showToast("Warning", "Confirm password cannot be empty", true);
    }
    else if (confirmPassword.text != password.text) {
      FocusScope.of(context).requestFocus(f5.value);
      CustomToast().showToast("Warning", "Password should be same", true);
    } else if (acceptTermsAndCondition.value != true) {
      CustomToast().showToast("Warning", "Accept terms and Condition", true);
    } else {


       UserSignUp(context);

      // Get.offNamed("/Introduction");
    }
  }

  Future<void> UserSignUp(context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map<String, String> jsondata = {
      "name": name.text,
      "user_type": chosenValue.value,
      "phone": phone.text,
      "email": email.text,
      "password": password.text
    };
    print(jsondata);
    resp.value = await SignUpModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.signupURL,
      jsondata,
      loading: true,
    ));
    // print(resp.value.result!.status);
    if (resp.value.result != null) {
      if (resp.value.result!.status == '1') {
        CustomToast().showToast('Success', 'User register successfully', false);
        storage.setString(LocalDBKeys.USERID, resp.value.result!.id!);
        storage.setString(LocalDBKeys.TOKEN, resp.value.result!.token!);
        storage.setString(LocalDBKeys.SELECTPREF, resp.value.result!.userType!);
        storage.setBool(LocalDBKeys.ACTIVENOTIFICTION, true);
        storage.setString(LocalDBKeys.ISREMEMBER, "true");
        if (chosenValue.value == "petfinder") {
          Get.offAllNamed('/finderHome');
          UserController controller = Get.put(UserController());
          FinderHomeController finderHomeController = Get.put(FinderHomeController());
          controller.user.value.result=resp.value.result;
          print('yaha aya');
          controller.user.refresh();
          ChatController chatController = Get.put(ChatController());
          await finderHomeController.getData(true);
        } else if (chosenValue.value == "volunteershelter") {
          Get.offAllNamed('/volunteerHome');
          UserController controller = Get.put(UserController());
          FinderHomeController finderHomeController = Get.put(FinderHomeController());
          // await controller.getUser(true);
          controller.user.value.result=resp.value.result;
          print('yaha aya 1');
          controller.user.refresh();
          await finderHomeController.getData(true);
          ChatController chatController = Get.put(ChatController());
        }
        // controller.getUser(true);
      }
    } else {
      CustomToast().showToast('Error', resp.value.message!, true);
    }
  }

  void toggle() {
    showPassword.value = !showPassword.value;
  }

  void toggleshowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void unFocus() {
    f1.value.unfocus();
    f2.value.unfocus();
    f3.value.unfocus();
    f4.value.unfocus();
    f5.value.unfocus();
  }
}

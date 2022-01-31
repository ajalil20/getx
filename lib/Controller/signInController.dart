import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/shelterpetinformation_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/signup_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:pawndr/Service/base_services.dart';

import 'BottomBarController.dart';
import 'chat_controller.dart';
import 'finderhome_controller.dart';

class LoginController extends GetxController {
  RxBool showPassword = true.obs;
  RxBool remeberMeLogin = false.obs;
  ShelterPetInformationController controller = Get.put(
      ShelterPetInformationController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Rx<SignUpModel> resp = SignUpModel().obs;
  BaseService baseService = BaseService();
  Rx<FocusNode> f1 = FocusNode().obs;
  Rx<FocusNode> f2 = FocusNode().obs;
  var tokenResp;

  validation(context) async {
    if (email.text.isEmpty) {
      FocusScope.of(context).requestFocus(f1.value);
      CustomToast().showToast("Warning", "Email cannont be empty", true);
    } else if (!email.text.isEmail) {
      CustomToast().showToast("Warning", "Enter valid email", true);
    } else if (password.text.isEmpty) {
      FocusScope.of(context).requestFocus(f2.value);
      CustomToast().showToast("Warning", "Password cannot be empty", true);
    } else {
      UserSignIn(context);
    }
  }

  Future<void> UserSignIn(context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map jsondata = {
      "email": email.text.toLowerCase(),
      "password": password.text
    };
    resp.value = await SignUpModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.signinURL, jsondata, loading: true,));
    if (resp.value.result != null) {
      if (resp.value.result!.status == '1') {
        storage.setString(LocalDBKeys.USERID, resp.value.result!.id!);
        storage.setString(LocalDBKeys.TOKEN, resp.value.result!.token!);
        storage.setString(LocalDBKeys.SELECTPREF, resp.value.result!.userType!);
        storage.setBool(LocalDBKeys.ACTIVENOTIFICTION, true);
        await registerDeviceNotification(context);

        storage.setString(
            LocalDBKeys.ISREMEMBER, remeberMeLogin.value.toString());
        CustomToast().showToast('Success', 'Login successfully.', false);
        if (resp.value.result!.userType == "petfinder") {
          // Get.toNamed('/getStart');
          Get.offAllNamed('/finderHome');
          UserController controller = Get.put(UserController());
          FinderHomeController finderHomeController = Get.put(
              FinderHomeController());
          // await controller.getUser(false);
          controller.user.value.result = resp.value.result;
          ChatController chatController = Get.put(ChatController());
          await finderHomeController.getData(false);
        } else if (resp.value.result!.userType == "volunteershelter") {
          // Get.toNamed('/volunteerInformation');
          Get.offAllNamed('/volunteerHome');
          UserController controller = Get.put(UserController());
          FinderHomeController finderHomeController = Get.put(
              FinderHomeController());
          // await controller.getUser(false);
          controller.user.value.result = resp.value.result;
          ChatController chatController = Get.put(ChatController());
          await finderHomeController.getData(false);
        }
      }
    }
    else {
      CustomToast().showToast('Error', resp.value.message!, true);
    }

  }
  Future<void> registerDeviceNotification(context,{token}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map jsondata = {
      // "user_id": resp.value.result!.id!,
      "user_id":storage.getString(LocalDBKeys.USERID),
      "device_token": token == 0  ? token: storage.getString(LocalDBKeys.NOTIFICATIONTOKEN)
    };
    print(jsondata);
    tokenResp = await baseService.basePostAPI(APIEndpoints.updateDeviceToken, jsondata, loading: false,);
    if (tokenResp['result'] != null) {
      if (tokenResp['result'] == true) {
      }
      else {
        // CustomToast().showToast('Error', resp.value.message!, true);
      }
    }
  }
}
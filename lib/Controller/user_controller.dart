import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Modals/signup_model.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Service/api_endpoints.dart';

class UserController extends GetxController {

  Rx<SignUpModel> user = SignUpModel().obs;
  BaseService baseService = BaseService();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool loading = true.obs;

  // Rx<double> lat=0.0.obs;
  // Rx<double> long=0.0.obs;
  Rx<String> selectedTime = "".obs;

  Future<void> getUser(isloading) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map jsondata = {"user_id": storage.getString(LocalDBKeys.USERID),};
    user.value = await SignUpModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.userData,
      jsondata,
      loading: isloading,
    ));
    if (user.value.result != null) {
      if (user.value.result!.status == '1') {
        loading.value = false;
      }
    } else {
      CustomToast().showToast('Error', user.value.message!, true);
    }
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';

class TermsConditionController extends GetxController {
  UserController controller = Get.find();
  BaseService baseService =BaseService();
  RxInt selectedIndex = 0.obs;
  RxBool isAccepted = true.obs;
  RxString termsCondition="".obs;
  var resp;

  var result;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  Future<void> getData() async{
    result =await baseService.baseGetAPI(APIEndpoints.getTermsCondition, loading: true,);
    termsCondition.value =await result['result'][0]['terms_condition'];
  }
  Future<void> updateTermsAndCondtion() async {
    Map jsondata = {"user_id": controller.user.value.result!.id};
    resp = await baseService.basePostAPI(APIEndpoints.updateTermsConditions, jsondata, loading: true,);
    resp =await resp['result'];
    print("resp");
    print(resp);
    if(resp==true)
      {
        print("yaha agya");
        controller.user.value.result!.termsCondition="true";
        controller.user.refresh();
        CustomToast().showToast("Done", "Thank you for accepting Terms & Condition!", false);
      }
    else
      {
        controller.user.value.result!.termsCondition="false";
        CustomToast().showToast("Not Selected", "Try again", true);
      }
  }
}
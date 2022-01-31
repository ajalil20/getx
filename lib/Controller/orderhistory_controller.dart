import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/petscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';

class OrderHistoryController extends GetxController {
  BaseService baseService =BaseService();
  Rx<OrderHistoryModel> resp = OrderHistoryModel().obs;
  UserController controller = Get.put(UserController());
  var result;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  Future<void> getData() async{
    var jsondata = {"user_id":controller.user.value.result!.id
    };resp.value =await OrderHistoryModel.fromJson(await baseService.basePostAPI(APIEndpoints.getUserOrder,jsondata, loading: true,));
  }
  Future<void> deleteOrder(id) async{
    print("id ye ha");
    print(id);
    result =await baseService.baseGetAPI(APIEndpoints.deleteOrder+id, loading: true,);
    result =await result['result'];
    print("resp");
    print(result);
    if(result==1)
    {
      await getData();
      resp.refresh();
      CustomToast().showToast("Done", "Order deleted", false);
    }
    else
    {
      CustomToast().showToast("Try again !", "Order not deleted", true);
    }

  }
}
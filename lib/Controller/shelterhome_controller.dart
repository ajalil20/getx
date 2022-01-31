import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/shelterscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelterHomeController extends GetxController{
  Rx<ShelterModel> resp = ShelterModel().obs;
  Rx<ShelterModel> massiveShelters = ShelterModel().obs;
  Rx<ShelterModel> favoriteShelters = ShelterModel().obs;
  RxBool loading = true.obs;
  BaseService baseService =BaseService();
  UserController controller = Get.put(UserController());
  @override
  Future<void> getData() async{
    getFavouriteSheltersData();
    getMassiveSheltersData();
    EasyLoading.show(status: "Please wait...");
    Map jsondata = {
      "user_id":controller.user.value.result!.id,
      "latitude":"${controller.user.value.result!.latitude}",
      "longitude":"${controller.user.value.result!.longitude}",
      "range_in_meter" : "0.10"
    };
    print("Shelter ye ha");
    print(jsondata);
    var data = await baseService.basePostAPI(
      APIEndpoints.getNearByShelters, jsondata);
    print("resp ye ha");
    print(data);
    resp.value=(await ShelterModel.fromJson(data));
    for(var data in resp.value.result!){
      if(data.shelterGallery!=null){
        for(var productData in data.shelterGallery!){
          if(productData.path.toString().contains("mp4")){
            productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
            finderHomeController.petView.refresh();
          }
        }
      }
    }
    if(resp.value.result!=null){

      loading.value=false;
    }
    else{
      loading.value=true;
    }
    EasyLoading.dismiss();
  }
  Future<void> getFavouriteSheltersData() async{
    Map jsondata = {
      "user_id": controller.user.value.result!.id
    };
    var data = await baseService.basePostAPI(APIEndpoints.getFavouriteShelters,jsondata);
    print("favoriteShelters shelter data");
    print(data);
    favoriteShelters.value=(await ShelterModel.fromJson(data));
    for(var data in favoriteShelters.value.result!){
      if(data.shelterGallery!=null){
        for(var productData in data.shelterGallery!){
          if(productData.path.toString().contains("mp4")){
            productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
            finderHomeController.petView.refresh();
          }
        }
      }
    }
    if(favoriteShelters.value.result!=null){
      // loading.value=false;
    }
    else{
      // loading.value=true;
    }
    // EasyLoading.dismiss();
  }
  Future<void> getMassiveSheltersData() async{
    var data = await baseService.baseGetAPI(APIEndpoints.getMassiveShelters);
    print("Massive shelter data");
    print(data);
    massiveShelters.value=(await ShelterModel.fromJson(data));
    for(var data in massiveShelters.value.result!){
      if(data.shelterGallery!=null){
        for(var productData in data.shelterGallery!){
          if(productData.path.toString().contains("mp4")){
            productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
            finderHomeController.petView.refresh();
          }
        }
      }
    }
    if(massiveShelters.value.result!=null){
      // loading.value=false;
    }
    else{
      // loading.value=true;
    }
    // EasyLoading.dismiss();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getData();
    // print("Function called");
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/setting_screens_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/petscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FinderHomeController extends GetxController {
  UserController controller = Get.find();
  Rx<PetModel> favorite = PetModel().obs;
  Rx<PetModel> nearByPets = PetModel().obs;
  Rx<PetModel> petView = PetModel().obs;
  Rx<Pet>? currentPetInfo = Pet().obs;
  Rx<FocusNode> f1 = FocusNode().obs;


  RxBool loading = true.obs;
  BaseService baseService = BaseService();

  Future<void> getData(isloading) async {
    // if (await Permission.location.request().isGranted) {
    //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //   controller.lat.value=position.latitude;
    //   controller.long.value=position.longitude;
    // }
    getNearByPets(isloading);
    await getRecentPetView(isloading);
    //
    // Map jsondata = {};
    // resp.value = await PetModel.fromJson(await baseService.basePostAPI(
    //   APIEndpoints.allPetsData, jsondata,  loading: isloading,));
    // resp.value.result!.forEach((data) {
    //   data.productGallery!.forEach((element) async {
    //
    //     if (element.path.toString().contains("mp4")) {
    //       element.thumbnail = File(await finderHomeController.getThumbnail(element.path.toString()));
    //       finderHomeController.resp.refresh();
    //       print(element.thumbnail!.path);
    //     }
    //   });
    // });

    loading.value = false;
    if (petView.value.result!=null){
      print("yahn ghus gya");
      generateThumbnail(petView.value.result, petView);
    }
    if (nearByPets.value.result!=null){
      generateThumbnail(nearByPets.value.result, nearByPets);
    }
    await getFavorite(false);
    if(favorite.value.result!=null)
    {
      generateThumbnail(favorite.value.result, favorite);
    }
  }

  Future<void> getRecentPetView(isLoading) async {
    Map jsondata = {"user_id": controller.user.value.result!.id};
    petView.value = await PetModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.recentPetView,
      jsondata,
      loading: isLoading,
    ));

    print(petView.value.result!.toString());
  }

  Future<void> getNearByPets(isLoading) async {
    Map jsondata = {
      "user_id": controller.user.value.result!.id,
      "latitude": "${controller.user.value.result!.latitude}",
      "longitude": "${controller.user.value.result!.longitude}",
      "range_in_meter": "0.10"
    };
    nearByPets.value = await PetModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.getNearyByPets,
      jsondata,
      loading: isLoading,
    ));
  }

  getThumbnail(String path) async {
    var fileName = await VideoThumbnail.thumbnailFile(
      video: "${APIEndpoints.baseURL}" + path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );
    return fileName;
  }

  Rx<File> thumnail = File("").obs;

  // setThumbnail(index)async{
  //
  //   if(resp!.value.result![index].productGallery!.isNotEmpty&&resp!.value.result![index].productGallery!.last.path!.contains("mp4")){
  //    thumnail.value= File(await getThumbnail(resp!.value.result![index].productGallery!.last.path.toString()));
  //   }
  //
  // }
  Future<void> getFavorite(isLoading) async {
    Map jsondata = {"user_id": controller.user.value.result!.id};
    favorite.value = await PetModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.getFavorites,
      jsondata,
      loading: isLoading,
    ));
  }

  generateThumbnail(thumnbaildata,list) async {
    for (var data in thumnbaildata) {
      for (var productData in data.productGallery!) {
        if (productData.path.toString().contains("mp4")) {
          productData.thumbnail = File(await getThumbnail(productData.path.toString()));
          print("refresh hua");
          petView.refresh();
          favorite.refresh();
          nearByPets.refresh();
        }
      }
    }
  }



}

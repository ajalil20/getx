import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/setting_screens_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/adopt_pet_model.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/petscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/SetUpMeeting/MeetingFixedPopUp.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'finderhome_controller.dart';

class PetScreenController extends GetxController{
  UserController controller = Get.put(UserController());
  Rx<PetScreenModel> resp = PetScreenModel().obs;
  BaseService baseService =BaseService();
  FinderHomeController finderHomeController = Get.put(FinderHomeController());
  Rx<Pet>? currentPetInfo = Pet().obs;
  List<String> myList = ['.mp4', '.webm', 'US'];
  Rx<AdoptPet> adoptPetRes= AdoptPet().obs;
  Rx<bool> isThumbnail=true.obs;
  var favouriteResp;
  RxBool loading = true.obs;



@override

  Future<void> getData(loader) async{
  Map<String,String> jsondata = {"user_id":controller.user.value.result!.id!};
  resp.value =await PetScreenModel.fromJson(await baseService.basePostAPI(APIEndpoints.petsData,jsondata, loading: loader??true,));
    loading.value = false;
  }
  Future<void> Favourite(String id,bool fav) async{
    Map<String,String> jsondata = {"product_id": id, "user_id":controller.user.value.result!.id!, "post_type": fav==true? "add": "remove"};
    favouriteResp = await baseService.basePostAPI(APIEndpoints.postFavourite,jsondata,loading: true);
    await finderHomeController.getFavorite(false);
    if(favouriteResp['result']['product_id']!=null) {
      if(currentPetInfo!=null)
      {
        currentPetInfo!.refresh();
      }
      getData(false);
      finderHomeController.favorite.refresh();
      CustomToast().showToast("Successfully", "Added to favorite!", false);}
    else{CustomToast().showToast("Successfully", "Removed from favorite!", false);}
    if(currentPetInfo!=null)
    {
      currentPetInfo!.refresh();
    }
    getData(false);
    finderHomeController.favorite.refresh();
  }
  getThumbnail(String path) async{
    var fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 100,);
    return fileName;
  }

  Future<void> adoptPet(context) async{
    print("Adopt pet");
    print(currentPetInfo!.value.id );
    print(currentPetInfo!.value.shelterId);
    print(controller.user.value.result!.id );
    print(controller.selectedDate.value.toString() );
    print(controller.selectedDate.value.toString().split(" ")[0]+"T"+controller.selectedTime.value+":00.000+00:00" );
    Map jsondata = {
      "product_id" : currentPetInfo!.value.id,
      "shelter_id" : currentPetInfo!.value.shelterId,
      "volunteer_id" : currentPetInfo!.value.volunteerId,
      "user_id" : controller.user.value.result!.id,
      "order_date" :controller.selectedDate.value.toString(),
      "order_time" :controller.selectedDate.value.toString().split(" ")[0]+"T"+controller.selectedTime.value+":00.000+00:00"
    };
    print(jsondata);
    var data= await baseService.basePostAPI(APIEndpoints.adoptPet, jsondata,loading: true);
    print("Rsp is ");
    print(data);
    adoptPetRes.value= await AdoptPet.fromJson(data);
   if(adoptPetRes.value.result!.productId!=null){
     showDialog(
         context:context,
         barrierDismissible: false,
         builder:(BuildContext context){
           return AlertDialog(
             backgroundColor: Colors.transparent,
             contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
             content: MeetingFixedPopUp(),
           );
         }
     );
   }else{
     print(adoptPetRes.value.result!.errors.toString());
     CustomToast().showToast("Error", adoptPetRes.value.result!.toString(), false);
   }
    loading.value = false;
  }
  showTime(context)async{
    TimeOfDay? time = await PlatformDatePicker.showTime(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        showCupertino: false,
        use24hFormat: true
    );
    print(time.toString());
    if(time!=null){

      controller.selectedTime.value="${time.hour}:${time.minute}";


    adoptPet(context);

    }else{
      CustomToast().showToast("Select Time", "Please select any time to proceed", false);
    }
    // selectedTime.value

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData(true);
    print("Function called");
  }
}
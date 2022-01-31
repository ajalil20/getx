import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/add_recent_pets.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'finderhome_controller.dart';

class AddRecentPetsController extends GetxController{
  UserController controller = Get.put(UserController());
  Rx<AddRecentProducts> resp = AddRecentProducts().obs;
  BaseService baseService =BaseService();
  PetScreenController petScreenController =Get.put(PetScreenController());
  FinderHomeController finderHomeController = Get.put(FinderHomeController());
  Future<void> addRecentProduct() async{
    Map jsondata = {
      "product_id" : petScreenController.currentPetInfo!.value.id,
      "user_id" : controller.user.value.result!.id,
    };
    print(jsondata);
    resp.value= await AddRecentProducts.fromJson(await baseService.basePostAPI(APIEndpoints.addRecentProduct, jsondata,loading: false));
    if(resp.value.result!=null){
      await finderHomeController.getRecentPetView(false);
    }
  }
}
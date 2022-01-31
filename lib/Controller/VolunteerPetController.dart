import 'package:get/get.dart';
import 'package:pawndr/Modals/petscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';

class VolunteerPetController extends GetxController {
  Rx<PetScreenModel> resp = PetScreenModel().obs;
  BaseService baseService =BaseService();

  RxBool loading = true.obs;
  Future<void> getData(petid) async{
    Map<String,String> jsondata = {"product_id": petid};
    resp.value =await PetScreenModel.fromJson(await baseService.basePostAPI(APIEndpoints.petsData,jsondata, loading: true,));
    loading.value = false;
  }
}

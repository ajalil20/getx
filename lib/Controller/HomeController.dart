import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/shelterscreen_model.dart';
import 'package:pawndr/Modals/tags_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeController extends GetxController {
  UserController controller = Get.find();

  var Breeds,Colors,Characterstics,petCategory;
  Rx<TextEditingController> search = TextEditingController().obs;
  Rx<TextEditingController> searchShelter = TextEditingController().obs;
  var distance = 0.0.obs;
  Rx<SfRangeValues> ageRange = SfRangeValues(0.0, 300.0).obs;
  Rx<SfRangeValues> heightRange = SfRangeValues(0.0, 300.0).obs;
  Rx<SfRangeValues> weightRange = SfRangeValues(0.0, 300.0).obs;
  BaseService baseService =BaseService();
  Rx<PetModel> filterPets = PetModel().obs;
  Rx<ShelterModel> filterShelters = ShelterModel().obs;
  RxBool isFilter=false.obs;
  RxBool isShelterFilter=false.obs;
  RxInt breedSelection = 0.obs;
  Rx<FocusNode> f1 = FocusNode().obs;



// Filter List Work

  RxList<Tags> petsList = List<Tags>.empty().obs;
  RxList<Tags> breedList = List<Tags>.empty().obs;
  RxList<Tags> colorList = List<Tags>.empty().obs;
  RxList<Tags> charList = List<Tags>.empty().obs;
  RxString markedPet = "".obs;
  RxList<Tags> currentTags = List<Tags>.empty().obs;
  RxList<Tags> markedBreedList = List<Tags>.empty().obs;
  RxList<Tags> markedColorList = List<Tags>.empty().obs;
  RxList<Tags> markedCharList = List<Tags>.empty().obs;

  Future<void> getData() async{
    Colors =await baseService.baseGetAPI(APIEndpoints.getColor, loading: false,);
    Characterstics =await baseService.baseGetAPI(APIEndpoints.getCharacteristicsList, loading: false,);
    petCategory =await baseService.baseGetAPI(APIEndpoints.getPetCategoryList, loading: false,);
    SetList();
  }
  SetList(){
    print("set list called");
    for (var i = 0; i < Colors['result'].length; i++) {colorList.add(Tags(name: Colors['result'][i],id: Colors['result'][i], selected: false));}
    for (var i = 0; i < Characterstics['result'].length; i++) { charList.add(Tags(name: Characterstics['result'][i]['name'],id: Characterstics['result'][i]['_id'],selected: false));}
    for (var i = 0; i < petCategory['result'].length; i++) { petsList.add(Tags(name: petCategory['result'][i]['name'],id: petCategory['result'][i]['_id'], selected: false));}
  }

  getBreeds() async {
    print("id");
    print(markedPet.value);
    Breeds =await baseService.baseGetAPI(APIEndpoints.getBreeds+'?pet_category_id='+markedPet.value, loading: false,);
    breedList.value=[];
    print(Breeds);
    for (var i = 0; i < Breeds['result'].length; i++) {breedList.add(Tags(name: Breeds['result'][i]['name'],id: Breeds['result'][i]['_id'], selected: false,));}
    breedList.refresh();
    print(breedList);
    print(Breeds);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 1), () { getData();});
  }

  void setPetList(event) {petUpdate(event,petsList);}
  Future<void> setBreedList(tags) async {markedBreedList.value =await updateList(tags,breedList,markedBreedList);}
  void setCharList(char)  async {markedCharList.value =await updateList(char,charList,markedCharList);}
  void setColorList(char)  async {markedColorList.value =await  updateList(char,colorList,markedColorList);}


    updateList(event,list,markedList) async {
    int index = list.indexWhere((element) => element == event);
    Tags temp = list.elementAt(index);
    list.removeAt(index);
    temp.selected = !(temp.selected!);
    list.insert(index, temp);
    list.refresh();
    markedList=[];
    for(int i=0;i<list.length;i++)
    {
      if(list[i].selected==true) {
        markedList.add(list[i].id);
      }
    }
    {print(markedList);}
    return Future.value(markedList);
  }
    resetList(list) async {
      for(int i=0;i<list.length;i++)
      {
        Tags temp = list.elementAt(i);
        list.removeAt(i);
        temp.selected = false;
        list.insert(i, temp);
        list.refresh();
      }
  }
  void petUpdate(event,list) {
    for(int i=0;i<list.length;i++)
    {
      Tags temp = list.elementAt(i);
      list.removeAt(i);
      temp.selected = false;
      list.insert(i, temp);
      list.refresh();
    }
    int index = list.indexWhere((element) => element == event);
    Tags temp = list.elementAt(index);
    list.removeAt(index);
    temp.selected = true;
    list.insert(index, temp);
    list.refresh();
    for(int i=0;i<list.length;i++)
    {
      if(list[i].selected==true) {
        markedPet.value=list[i].id!;
        getBreeds();
      }
    }
  }



  Future<void> getFilterPetsData() async {
    print("ye breed list ha");
    print(markedBreedList);
    print(markedBreedList.value);
    print("ye markedCharList list 2 ha");
    print(markedCharList);
    print(markedCharList.value);
    Map jsondata = {
      "latitude": controller.user.value.result!.latitude,
      "longitude":controller.user.value.result!.longitude,
      "range_in_meter" : distance.value.floor(),
      "pet_category_id": markedPet.value,
      "breed_id":  markedBreedList.value.map((e) => e.id).toList(),
      "characteristics_id": markedCharList.value.map((e) => e.id).toList(),
      "start_age":ageRange.value.start.floor(),
      "end_age":ageRange.value.end.floor(),
      "color":  markedColorList.value.map((e) => e.name).toList(),
      "start_weight":weightRange.value.start.floor(),
      "end_weight":weightRange.value.end.floor(),
      "start_height":heightRange.value.start.floor(),
      "end_height":heightRange.value.end.floor()
    };
    print(jsondata);

    var data = await baseService.basePostAPI(
        APIEndpoints.filterPets, jsondata,loading: true);
    print("filter pets");
    print(data);
    filterPets.value = (await PetModel.fromJson(data));

    for (var data in filterPets.value.result!) {
      if (data.productGallery != null) {
        for (var productData in data.productGallery!) {
          if (productData.path.toString().contains("mp4")) {
            productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
            finderHomeController.petView.refresh();
          }
        }
      }
    }
    if (filterPets.value.result != null) {
      isFilter.value=true;
      search.value.text="";
      // loading.value=false;
    } else {
      // loading.value=true;
    }
    // EasyLoading.dismiss();
  }
  searchPets() async {
    print(search.value.text.length);
    // if(search.value.text.isNotEmpty)
    {
      var data = await baseService.baseGetAPI(
          APIEndpoints.searchPets + search.value.text,
          loading: false);
      print("search pets");
      print(data);
      filterPets.value = (await PetModel.fromJson(data));

      // filterPets.value = (await PetModel.fromJson(await baseService.baseGetAPI(APIEndpoints.searchPets+search.value.text, loading: false,)));
      for (var data in filterPets.value.result!) {
        if (data.productGallery != null) {
          for (var productData in data.productGallery!) {
            if (productData.path.toString().contains("mp4")) {
              productData.thumbnail = File(await finderHomeController
                  .getThumbnail(productData.path.toString()));
              finderHomeController.petView.refresh();
            }
          }
        }
      }
    }
    // else {
    //   isFilter.value = false;
    //   print("no result pa agya");
    //   print(isFilter);
    // }
  }



  searchShelters() async {
    var data = await baseService.baseGetAPI(
        APIEndpoints.searchShelters + searchShelter.value.text,
        loading: false);
    print("search shelter");
    print(data);
    filterShelters.value = (await ShelterModel.fromJson(data));

    // filterPets.value = (await PetModel.fromJson(await baseService.baseGetAPI(APIEndpoints.searchPets+search.value.text, loading: false,)));
    for (var data in filterShelters.value.result!) {
      if (data.shelterGallery != null) {
        for (var productData in data.shelterGallery!) {
          if (productData.path.toString().contains("mp4")) {
            productData.thumbnail = File(await finderHomeController
                .getThumbnail(productData.path.toString()));
            filterShelters.refresh();
          }
        }
      }
    }
  }

  resetFilter() async {
    isFilter.value = false;
    search.value.text="";
    markedPet.value = "";
    resetList(petsList);
    resetList(breedList);
    resetList(charList);
    resetList(colorList);
    distance.value = 0.0;
    ageRange.value = SfRangeValues(0.0, 300.0);
    heightRange.value = SfRangeValues(0.0, 300.0);
    weightRange.value = SfRangeValues(0.0, 300.0);
  }

}

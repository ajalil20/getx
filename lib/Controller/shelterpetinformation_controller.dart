import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'map_controller.dart';

class ShelterPetInformationController extends GetxController{
  UserController controller = Get.put(UserController());
  MapControler mapControler = Get.put(MapControler());

  BaseService baseService =BaseService();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var resp;
  RxBool loading = true.obs;
  Rx<PetModel> recentPets = PetModel().obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<TextEditingController> gender = TextEditingController().obs;
  Rx<String> color = "".obs;
  Rx<TextEditingController> characterstics = TextEditingController().obs;
  Rx<TextEditingController> breed = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<FocusNode> f1 = FocusNode().obs;
  Rx<FocusNode> f2 = FocusNode().obs;
  Rx<FocusNode> f3 = FocusNode().obs;
  Rx<FocusNode> f4 = FocusNode().obs;
  Rx<FocusNode> f5 = FocusNode().obs;
  Rx<FocusNode> f6 = FocusNode().obs;
  Rx<FocusNode> f7 = FocusNode().obs;

  RxBool showList = false.obs;
  RxString petType= "Select the pet type".obs;
  RxList<File> filePaths=List<File>.empty().obs;
  Rx<File> imagePick = File("").obs;
  RxList petTypeList = ["Bulldog", "Izzy", "Piper", "Luna"].obs;

  validation(context){
    if(name.value.text.isEmpty){
      CustomToast().showToast("Warning", "Name cannot be empty", true);
    }
    else if(age.value.text.isEmpty){
      CustomToast().showToast("Warning", "Age cannot be empty", true);
    }
    else if(gender.value.text.isEmpty){
      CustomToast().showToast("Warning", "Gender cannot be empty", true);
    }
    else if(color.value==""){
      CustomToast().showToast("Warning", "Color cannot be empty", true);
    }
    else if(characterstics.value.text.isEmpty){
      CustomToast().showToast("Warning", "Characterstics cannot be empty", true);
    }
    else if(breed.value.text.isEmpty){
      CustomToast().showToast("Warning", "Breed cannot be empty", true);
    }
    else if(description.value.text.isEmpty){
      CustomToast().showToast("Warning", "Description cannot be empty", true);
    }
    else if(petType.value=="Select the pet type"){
      CustomToast().showToast("Warning", "Pet type cannot be empty", true);
    }
    else {
      AddPet(context);
      // Get.offNamed("/Introduction");
    }
  }


  Future<void> AddPet(context) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    var jsondata = {
      "breed": breed.value.text,
      "char" : characterstics.value.text,
      "pet" : petType.value,
      "shelter_id" : mapControler.currentPinInfo!.value.id.toString(),
      "volunteer_id": controller.user.value.result!.id!,
      "name":  name.value.text,
      "description" : description.value.text,
      "age" : age.value.text,
      "color": color.value,
      "gender": gender.value.text,
    };
    print(jsondata.toString());
    // print(controller.user.value.result!.token!);
    baseService.token= storage.getString(LocalDBKeys.TOKEN);
    ///start
    if(filePaths.value.isNotEmpty)
    {
      resp = await baseService.baseFormPostAPI(
        APIEndpoints.addPetData,
        jsondata,
        []..addAll(filePaths.value),[]..addAll(List.generate(filePaths.length, (index) => "product_gallery")),
        context,
        loading: true,
      );
    }
    else
    {
      resp = await baseService.baseFormPostAPI(
        APIEndpoints.addPetData,
        jsondata,
        [],
        [],
        context,
        loading: true,
      );

    }

      var data=jsonDecode(resp);

    print("check1");
    print(data.toString());
    if (data["result"]['name'] != null) {
      CustomToast().showToast('Success', 'Pet Added', false);
    } else if(data["result"]['errors'] != null) {
      CustomToast().showToast('Failed', data['_message'].toString(), true);
    }
  }


  Future imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 20);

    if(pickedFile!=""){
      imagePick.value = File(pickedFile!.path);
      filePaths.add(imagePick.value);
    }else{
      CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }
  Future imgFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 20);

    if(pickedFile!=""){
      imagePick.value = File(pickedFile!.path);
      filePaths.add(imagePick.value);
    }else{
      CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }
  var dateValidate = new MaskTextInputFormatter(
      mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')});

  Future<void> getRecentPets() async {


    var jsondata = {
      "volunteer_id": controller.user.value.result!.id
    };
    recentPets.value = ( PetModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.getRecentAddedPet, jsondata,  loading: true,)));
    for(var data in recentPets.value.result!){
      for(var productData in data.productGallery!){
        if(productData.path.toString().contains("mp4")){
          productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
          finderHomeController.petView.refresh();
        }
      }
    }
    loading.value=false;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1900, 8),

        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate){
      selectedDate.value=picked;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(selectedDate.value);
      age.value.text=formatted;

    }

  }


}
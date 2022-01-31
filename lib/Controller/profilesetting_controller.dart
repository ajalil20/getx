import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/updateprofile_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'HomeController.dart';

class ProfileSettingController extends GetxController {
  UserController controller = Get.find();
  HomeController homeController = Get.find();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<File> imageProfile = File("").obs;
  RxInt checkFile=0.obs;
  RxBool loading = true.obs;
  RxBool profileUpdated = false.obs;
  RxList<File> imageIdentity= List<File>.empty().obs;
  RxList activityList=List.empty().obs;
  RxList breedList=[{'label': '', 'value': ''}].obs;
  RxList colorList=[{'label': '', 'value': ''}].obs;
  var Breeds;
  var Colors;
  BaseService baseService =BaseService();



  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> zip = TextEditingController().obs;
  Rx<TextEditingController> about = TextEditingController().obs;
  Rx<FocusNode> f1 = FocusNode().obs;
  Rx<FocusNode> f2 = FocusNode().obs;
  Rx<FocusNode> f3 = FocusNode().obs;
  Rx<FocusNode> f4 = FocusNode().obs;
  Rx<FocusNode> f5 = FocusNode().obs;

  RxString identity = "identitycard".obs;
  RxString breed = "".obs;
  RxString color = "".obs;
  // RxString age = "".obs;
  Rx<SfRangeValues> age = SfRangeValues(1.0, 300.0).obs;


  List identityList = [
    {'label': 'Driving License', 'value': 'drivinglicense'}, // label is required and unique
    {'label': 'Identity Card', 'value': 'identitycard'},
  ];
  Future<void> getData() async{
    Breeds =await baseService.baseGetAPI(APIEndpoints.getAllBreeds, loading: false,);
    Colors =await baseService.baseGetAPI(APIEndpoints.getColor, loading: false,);
    if(Breeds['result'].isNotEmpty)
    {
      breedList.removeAt(0);
      for (var i = 0; i < Breeds['result'].length; i++) {
        breedList.add({
          'label': '${Breeds['result'][i]}',
          'value': '${Breeds['result'][i]}',
        });
      }
      breed.value = breedList.value[0]['value'];
    }
    if(Colors['result'].isNotEmpty)
    {
      colorList.removeAt(0);
    for (var i = 0; i < Colors['result'].length; i++) {
        colorList.add({
          'label': '${Colors['result'][i]}',
          'value': '${Colors['result'][i]}',
        });
      }
      color.value = colorList.value[0]['value'];
    }
    EasyLoading.dismiss();
    loading.value = false;
  }

  // Rx<UpdateProfileModel> resp = UpdateProfileModel().obs;
  var resp,updatePetResp;
  var dateValidate = new MaskTextInputFormatter(
      mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')});
  parseDate(){
    List l1=[];
    print(dob.value.text);
    if(dob.value.text.contains("-")) {
      l1 = dob.value.text.split("-");
    }
    if(dob.value.text.contains("/")) {
      l1 = dob.value.text.split("/");
    }
    return l1[0]+l1[1]+l1[2];
  }

  diff() {
    var difference = DateTime.now().difference(DateTime.parse(dob.value.text)).inDays;
    print(difference.toString());
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    EasyLoading.show(status: "Please wait...");
    getData();
    if(controller.user.value.result !=null)
    {
      name.value.text = controller.user.value.result!.name=="N/A"?"": controller.user.value.result!.name!;
      location.value.text = controller.user.value.result!.locationName=="N/A"?"": controller.user.value.result!.locationName!;
      identity.value = controller.user.value.result!.identityType=="N/A"?"": controller.user.value.result!.identityType!;
      dob.value.text = controller.user.value.result!.dateofbirth == null ? "N/A" : DateFormat('yyyy/MM/dd').format(DateTime.parse(controller.user.value.result!.dateofbirth!));
      zip.value.text = controller.user.value.result!.zipcode=="N/A"?"":controller.user.value.result!.zipcode!;
      about.value.text = controller.user.value.result!.about=="N/A"?"": controller.user.value.result!.about!;
    }
    print("profile setting on init called");
  }


  Future<bool> UpdateProfile(context, {updatePref = true}) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    var jsondata = {
      "user_id": controller.user.value.result!.id!,
      "name":  name.value.text,
      "location_name" : location.value.text,
      "latitude" : controller.user.value.result!.latitude!,
      "longitude" : controller.user.value.result!.longitude!,
      "dateofbirth" : dob.value.text,
      "zipcode": zip.value.text,
      "indentity_type": identity.value,
      "about" : about.value.text
    };
    print(jsondata.toString());
    baseService.token= storage.getString(LocalDBKeys.TOKEN);
    if(imageIdentity.value.isEmpty&& imageProfile.value.path.isEmpty)
    {
      print("no profile no id");
      resp = await baseService.baseFormPostAPI(
        APIEndpoints.updateprofileURL,
        jsondata,
        [],
        [],
        context,
        loading: true,
      );
    }
    else if (imageIdentity.value.isNotEmpty && imageProfile.value.path=="")
    {
      print("yes profile no id");
      resp = await baseService.baseFormPostAPI(
        APIEndpoints.updateprofileURL,
        jsondata,
        // [imageIdentity.value],["indentity"],
        []..addAll(imageIdentity.value),[]..addAll(List.generate(imageIdentity.length, (index) => "indentity")),
        context,
        loading: true,
      );
    }
    else if (imageIdentity.value.isEmpty && imageProfile.value.path.isNotEmpty)
    {
      print("profile pic wala");
      resp = await baseService.baseFormPostAPI(
        APIEndpoints.updateprofileURL,
        jsondata,
        [imageProfile.value],["profile_image"],
        context,
        loading: true,
      );
    }
    else
    {
      print("dono");

      resp = await baseService.baseFormPostAPI(
        APIEndpoints.updateprofileURL,
        jsondata,
        [imageProfile.value]..addAll(imageIdentity),["profile_image"]..addAll(List.generate(imageIdentity.length, (index) => "imageIdentity")),
        context,
        loading: true,
      );
    }
     var data =await json.decode(resp);
    print('arso arso arso');
     print(data);
     resp = await UpdateProfileModel.fromJson(data);
    if (resp.result.reason == null) {
      print('arso yaha gaya hon');
        profileUpdated.value=true;
        controller.user.value.result!.name = name.value.text;
        controller.user.value.result!.locationName = location.value.text;
        controller.user.value.result!.dateofbirth= await parseDate();
        controller.user.value.result!.zipcode= zip.value.text;
        controller.user.value.result!.about= about.value.text;
        controller.user.value.result!.profileImage= resp.result.profileImage;
        controller.user.value.result!.identityImgPath= resp.result.identityImgPath;
      print('arso yaha gaya hon');
      print('arso yaha gaya hon');
        controller.user.refresh();
        Get.back();
        // CustomToast().showToast('Success', 'User updated successfully', false);
        if(updatePref==true) {await UpdatePetPreference();}
        return Future.value(true);
    } else {
        CustomToast().showToast('Error', resp.result.message, true);
        return Future.value(false);
      }

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
        dob.value.text=formatted;

      }

    }
    Future imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pickedFile!=""){
      if(checkFile==0){
        imageProfile.value=File(pickedFile!.path);
      }else{
        imageIdentity.add(File(pickedFile!.path));
      }

    }else{
      CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }
    Future imgFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedFile!=""){
      if(checkFile==0){
        imageProfile.value=File(pickedFile!.path);
      }else{
        imageIdentity.add(File(pickedFile!.path));
      }
    }
    else{
      CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }
    Future<void> UpdatePetPreference() async {
    Map jsondata = {
      "user_id":controller.user.value.result!.id,
      "color"  :color.value,
      "age":age.value.toString(),
      "breed":breed.value
    };
    updatePetResp = await baseService.basePostAPI(APIEndpoints.updatePetPreferences, jsondata);
    print(updatePetResp);
    if(updatePetResp['result']!=null){
      if(updatePetResp['result']=true){
        CustomToast().showToast('Success', "Setting Updated!", false);
      }
    }
    // else{
    //   CustomToast().showToast('Error', resp.value.message!, true);
    // }
  }
    Future<void> determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomToast().showToast("Required", "Enable access location", true);

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomToast().showToast("Required", "Enable access location", true);
      }
    } else if (permission == LocationPermission.deniedForever) {
      CustomToast().showToast(
          "Required",
          "Location permissions are permanently denied, we cannot request permissions",
          true);
    } else {
      var myLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final coordinates =
      new Coordinates(myLocation.latitude, myLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      if(UpdateProfile(context,updatePref: false)==true);
      {
        print( first.addressLine);
        controller.user.value.result!.locationName = first.addressLine;
        location.value.text=first.addressLine;
        controller.user.value.result!.latitude = myLocation.latitude.toString();
        controller.user.value.result!.longitude = myLocation.longitude.toString();
        print("LC"+controller.user.value.result!.locationName.toString());
        CustomToast().showToast('Success', "Location Updated", false);

      }
      // print('${first.addressLine}');
      // print('${first.countryName}');
      // print('${first.adminArea}');
      // print('${first.coordinates}');
      // print('${first.countryCode}');
      // print('${first.featureName}');
      // print('${first.locality}');
      // print('${first.subLocality}');
      // print('${first.subAdminArea}');
      // print('${first.postalCode}');
      // print('${first.subThoroughfare}');
      // print('${first.thoroughfare}');
    }
  }
  Future<bool> resetData(){
  name.value.text =
  controller.user.value.result!.name!;
  location.value.text =
  controller.user.value.result!.locationName!;
  identity.value =
  controller.user.value.result!.identityType!;
  dob.value.text =
  controller.user.value.result!.dateofbirth == null
      ? ""
      : DateFormat('yyyy/MM/dd').format(DateTime.parse(
      controller.user.value.result!.dateofbirth!));
  zip.value.text =
  controller.user.value.result!.zipcode!;
  about.value.text =
  controller.user.value.result!.about!;
  if (profileUpdated.value == false)
  {
    print("ye false ha");
    imageIdentity.value=List<File>.empty();
    imageProfile.value=File("");

  }
  return Future.value(true);
}
}

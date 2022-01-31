import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Modals/shelterscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'dart:ui' as ui;

import 'package:pawndr/Utils/image_path.dart';
import 'package:url_launcher/url_launcher.dart';


class MapControler extends GetxController{
  RxBool showInfo = false.obs;
  ShelterHomeController shelterHomeController = Get.put(ShelterHomeController());
  GoogleMapController? controller;
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  Rx<PetModel> pet = PetModel().obs;
  BaseService baseService =BaseService();
  RxBool loading = true.obs;

  LatLng? markerPosition;
  Rx<Shelter>? currentPinInfo = Shelter().obs;
  RxList<Shelter> markerModel= RxList<Shelter>.empty();
  void onMapCreated(GoogleMapController controller)async {
    this.controller = controller;
    print("on map creatd");
   await shelterHomeController.getData();
    // initialize();
    for(var data in shelterHomeController.massiveShelters.value.result!)
      {
        initMarker(data);
      }
    // shelterHomeController.massiveShelters.value.result!.forEach((element) {
    //   initMarker(element);
    // });
    // markerModel.forEach((element) {
    //   element.shelterGallery!.forEach((element) {
    //   });
    // });

  }
   Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  void initMarker(specify) async {
   
    final Uint8List markerIcon =
        await getBytesFromAsset(ImagePath.locationIcn, 100);
    var markerIdVal = specify.id.toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
     
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
//         infoWindow: InfoWindow(
//     title: specify.shelterName,onTap: (){
//         },s
//
// ),
        position: LatLng(double.parse(specify.latitude.toString()), double.parse(specify.longitude.toString())),
        onTap: () async {
          showInfo.value=true;
          currentPinInfo!.value=specify;
          // currentPinInfo!.value.name=specify.name;
          // currentPinInfo!.value.description=specify.description;
          // currentPinInfo!.value.city=specify.city;
          // currentPinInfo!.value.state=specify.state;
          // currentPinInfo!.value.country=specify.country;
          // currentPinInfo!.value.phone=specify.phone;
          // currentPinInfo!.value.shelterGallery=specify.shelterGallery;
          await getShelterPets();
          currentPinInfo!.refresh();
           }
        );
    markers[markerId] = marker;
    //print(markerId);
  }
  Future<void> getShelterPets() async{
    var jsondata = {
      "shelter_id": currentPinInfo!.value.id
    };
    var data =await baseService.basePostAPI(APIEndpoints.getShelterPets, jsondata,  loading: false,);
    pet.value = await PetModel.fromJson(data);
    for(var data in pet.value.result!){
      for(var productData in data.productGallery!){
        if(productData.path.toString().contains("mp4")){
          productData.thumbnail = File(await finderHomeController.getThumbnail(productData.path.toString()));
          finderHomeController.petView.refresh();
        }
      }
    }

    loading.value = false;
  }



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await shelterHomeController.getData();
    print("init wala");
    // initialize();
    // markerModel.forEach((element) {
    //
    //   initMarker(element);
    //   print(element.shelterID);
    // });

  }
  initialize()async{
    var doubleValue=24.8688;
 shelterHomeController.massiveShelters.value.result!.forEach((element) {
   doubleValue+=0.5;
      markerModel.add(Shelter(name: element.name,id: element.id,latitude:element.latitude, longitude: element.longitude,description: element.description,city: element.city,state: element.state,country: element.country,phone: element.phone,volunteerId: element.volunteerId,shelterGallery: element.shelterGallery));
      // markerModel.add(MarkerModel(shelterName: element.name,markerId: element.id,latLong: LatLng(double.parse(/*element.latitude!*/24.8688.toString()),double.parse(67.0614.toString()))));
    });
    // markerModel.value=[
    //   MarkerModel(shelterName: "Cafe New yourk",markerId: "1",latLong: LatLng(24.8688,67.0614)),
    // MarkerModel(shelterName: "Cafe Down Town",markerId: "2",latLong: LatLng(24.8788,67.0714))
    // ];

  }
  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
}
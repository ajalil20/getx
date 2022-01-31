
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BottomBarController extends GetxController{
  RxInt currentIndex=0.obs;
  // MainHomeFeedController controller=Get.find();
  // ProfileController profileController=Get.find();
  // PostController postController=Get.put(PostController());
  // UnityController unityController=Get.put(UnityController());

  List<ImageData> images=[
    ImageData('assets/icons/homeIcon.png',6,),
    ImageData('assets/icons/dogIcon.png',7,),
    ImageData('assets/icons/userIcon.png',6,),
    ImageData('assets/icons/menuIcon.png',6,),
  ];

  List<String> data=[
    'Home',
    'Pets',
    'Profile',
    'Menu'
  ];

  Future<void> onTap(int index,context) async {
    if(index==0){
      currentIndex(index);
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? user = storage.getString(LocalDBKeys.SELECTPREF);
      if(user=="petfinder") {Get.toNamed('/finderHome');} else  {Get.toNamed('/volunteerHome');}
    }else if(index==1){
      currentIndex(index);
      Get.toNamed('/pets');
    }else if(index==2){
      currentIndex(index);
      Get.toNamed('/userProfile');
      }else{
      // currentIndex(index);
      Scaffold.of(context).openDrawer();
      }
      // Get.to(Hud());
    }
  }

class ImageData{
  ImageData(this.image,this.size);
  String? image;
  double? size;

}
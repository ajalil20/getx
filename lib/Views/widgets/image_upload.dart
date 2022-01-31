import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/ShelterPicVideoController.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
class UploadPhoto extends StatelessWidget {

  String? text;
  String? screenName;
  UploadPhoto({required this.screenName});
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  ShelterPicAndVideoController controller = Get.put(ShelterPicAndVideoController());
  ProfileSettingController profileSettingController =Get.put(ProfileSettingController());
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      content:MyText(title:"Select Image Mode",center: true,clr: colors.primaryColor,weight: "Semi Bold",size: 18,),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        new TextButton(
          child:MyText(title: "Gallery",center: true,clr: colors.whiteColor,size: 15,),
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => colors.primaryColor),
              elevation: MaterialStateProperty.all(5)
          ),
          onPressed: () {
            Get.back();
            if(screenName=="shelter"){
              if(controller.showPicAndVideo=="pictures"){
                controller.imgFromGallery();

              }
              else{
                controller.videoFromGallery();
              }
            }else if(screenName=="profile_setting"){
              profileSettingController.imgFromGallery();
            }

          },
        ),
        new TextButton(
          child:MyText(title: "Camera",center: true,clr: colors.whiteColor,size: 15,),
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => colors.primaryColor),
              elevation: MaterialStateProperty.all(5)
          ),
          onPressed: () {
            Get.back();

            if(screenName=="shelter"){
              if(controller.showPicAndVideo=="pictures"){
                controller.imgFromCamera();

              }
              else{
                controller.videoFromCamera();
              }
            }else if(screenName=="profile_setting"){
              profileSettingController.imgFromCamera();
            }

          },
        ),
      ],
    );
  }
}

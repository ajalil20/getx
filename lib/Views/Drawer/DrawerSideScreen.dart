// ignore_for_file: file_names, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pawndr/Component/custom_circlewithicon.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/setting_screens_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSideScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            // height: responsive.setHeight(100),
            // width: responsive.setWidth(100),
            decoration: BoxDecoration(
            // borderRadius: 0,
            // blur: 40,
            // border: 2,
              gradient: LinearGradient(
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  // Color(0xFFffffff).withOpacity(0.6),
                  // Colors.grey.withOpacity(0.65),
                  colors.whiteColor.withOpacity(0.9),
                  colors.whiteColor.withOpacity(0.7),
                ],
                // stops: [
                //   0.1,
                //   1,
                // ]
            ),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              ),
            // borderGradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xFFffffff).withOpacity(0.0),
            //     Color((0xFFFFFFFF)).withOpacity(0.0),
            //   ],
            // ),
        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.user.value.result == null
                    ? Container(
                        height: responsive.setHeight(8),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: responsive.setWidth(3), top:  responsive.setHeight(6),bottom: responsive.setHeight(4), left: responsive.setWidth(3)),

                  child: Row(
                          children: [
                            Container(
                              child: ProfileImage(
                                size: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: colors.whiteColor,
                                  width: 2
                                )
                              ),
                            ),
                            SizedBox(
                              width: responsive.setWidth(3),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: responsive.setWidth(4)),
                                    child: MyText(
                                      title: controller.user.value.result!.name!,
                                      size: responsive.setTextScale(17),
                                      clr: colors.primaryColor,
                                      line: 1,
                                      toverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  MyText(
                                      title: 'Personal Info',
                                      size: responsive.setTextScale(12),
                                      clr: colors.hintColor),
                                  SizedBox(
                                    height: responsive.setHeight(0.7),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: colors.secondaryColor,
                                        size: responsive.setTextScale(25),
                                      ),
                                      SizedBox(
                                        width: responsive.setWidth(1),
                                      ),
                                      Expanded(
                                        child: MyText(
                                          title: controller
                                              .user.value.result!.locationName!,
                                          size: responsive.setTextScale(12),
                                          clr: colors.secondaryColor,
                                          toverflow: TextOverflow.ellipsis,
                                          line: 1,
                                          weight: 'Semi Bold',
                                        ),
                                      ),
                                      SizedBox(
                                        width: responsive.setWidth(2),
                                      ),
                                    ],
                                  ),
                                  // Row(children: [
                                  //   MyText(title: 'Available ',size: responsive.setTextScale(15),clr: colors.secondaryColor,),
                                  //   MyText(title: '/ Not Available ',size: responsive.setTextScale(12),clr: colors.hintColor,),
                                  // ],)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                Expanded(
                  child: Container(
                    width: responsive.setWidth(60),
                    child: ListView.builder(
                      itemCount: settingScreenController.items.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(3)),
                      itemBuilder: (BuileContext, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: responsive.setHeight(0)),
                          child: Obx(() => GestureDetector(
                                onTap: () {
                                  settingScreenController.selectedIndex.value =
                                      index;
                                  Get.toNamed(
                                      settingScreenController.items[index].path!);
                                  settingScreenController.items[index].onTap!();
                                },
                                child: Container(
                                  width: responsive.setWidth(80),
                                  decoration: BoxDecoration(
                                    color: settingScreenController
                                                .selectedIndex.value ==
                                            index
                                        ? colors.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(responsive.setHeight(2)),
                                    child: MyText(
                                      title: settingScreenController
                                          .items[index].name!,
                                      size: responsive.setTextScale(16),
                                      clr: settingScreenController
                                                  .selectedIndex.value ==
                                              index
                                          ? colors.whiteColor
                                          : colors.primaryColor,
                                      weight: settingScreenController
                                          .selectedIndex.value ==
                                          index
                                          ?"Semi Bold":"",
                                    ),
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(right: responsive.setWidth(3), bottom: responsive.setHeight(4), left: responsive.setWidth(3)),
                  child: GestureDetector(
                    onTap: () async {
                      final storage = await SharedPreferences.getInstance();
                      await storage.clear();
                      EasyLoading.dismiss();
                      Get.offAllNamed("/login");
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyText(
                          title: 'Log Out',
                          clr: colors.errorColor,
                          size: responsive.setTextScale(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

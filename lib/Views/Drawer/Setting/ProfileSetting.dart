import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/custom_slider.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/image_upload.dart';

class ProfileSetting extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  ProfileSettingController controller = Get.put(ProfileSettingController());
  UserController usercontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    // controller.onInit();
    responsive.setContext(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: BaseView(
        showCircle2: false,
        titleClr: colors.blackColor,
        screenNamee: 'Profile Settings',
        titleWeight: 'Semi Bold',
        titleFontSize: responsive.setTextScale(20),
        showBackButton: true,
        onTapBackButton: controller.resetData,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Obx(() => controller.loading.value == true
                ? Container()
                : Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: responsive.setHeight(2.2),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: responsive.setHeight(2.5),
                                    ),
                                    Center(
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            height: responsive.setWidth(23),
                                            width: responsive.setWidth(23),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                color: colors.whiteColor),
                                            padding: EdgeInsets.all(
                                                responsive.setWidth(1)),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  ImagePreview(
                                                    network: controller
                                                                .imageProfile
                                                                .value
                                                                .path ==
                                                            ""
                                                        ? usercontroller
                                                                .user
                                                                .value
                                                                .result!
                                                                .profileImage!
                                                                .isNotEmpty
                                                            ? APIEndpoints
                                                                    .baseURL +
                                                                usercontroller
                                                                    .user
                                                                    .value
                                                                    .result!
                                                                    .profileImage!
                                                            : null
                                                        : null,
                                                    fileImage: controller
                                                        .imageProfile.value,
                                                    // asset: (mapControler.currentPinInfo!.value.gallery == null&& mapControler.currentPinInfo!.value.gallery!.isEmpty)?ImagePath.noImageFound: null,
                                                  ),
                                                  isScrollControlled: true,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    // image: DecorationImage(
                                                    //   image:
                                                    //   controller.imageProfile.value.path=="" ?
                                                    //   const AssetImage('assets/users/userImage.png')
                                                    //       : Image.file(
                                                    //     controller.imageProfile.value,
                                                    //     fit: BoxFit.cover,
                                                    //   ).image,
                                                    //   fit: BoxFit.cover,
                                                    //   alignment: Alignment.center,
                                                    // )
                                                    image: controller
                                                                .imageProfile
                                                                .value
                                                                .path ==
                                                            ""
                                                        ? usercontroller
                                                                    .user
                                                                    .value
                                                                    .result!
                                                                    .profileImage !=
                                                                null
                                                            ? DecorationImage(
                                                                image: NetworkImage(APIEndpoints
                                                                        .baseURL +
                                                                    usercontroller
                                                                        .user
                                                                        .value
                                                                        .result!
                                                                        .profileImage!),
                                                                fit: BoxFit
                                                                    .cover,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )
                                                            : DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/users/userImage.png'),
                                                                fit: BoxFit
                                                                    .cover,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )
                                                        : DecorationImage(
                                                            image: Image.file(
                                                              controller
                                                                  .imageProfile
                                                                  .value,
                                                              fit: BoxFit.cover,
                                                            ).image,
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment
                                                                .center,
                                                          )),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: responsive.setWidth(13)),
                                            child: GestureDetector(
                                              onTap: () async {
                                                controller.checkFile.value = 0;
                                                // controller.parseDate();
                                                await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return UploadPhoto(
                                                        screenName:
                                                            "profile_setting",
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                height: responsive.setWidth(10),
                                                width: responsive.setWidth(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: colors.secondaryColor,
                                                ),
                                                child: Icon(
                                                  Icons.photo_camera_outlined,
                                                  color: colors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MyText(
                                      title: 'Personal Settings',
                                      size: responsive.setTextScale(16),
                                      weight: 'Semi Bold',
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyText(title: 'Name'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyTextField(
                                      hintText: 'Name',
                                      backgroundColor: colors.whiteColor,
                                      borderColor: colors.whiteColor,
                                      boxShadow: true,
                                      controller: controller.name.value,
                                      focusNode: controller.f1.value,
                                      onFieldSubmit: (val) {
                                        controller.f1.value.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(controller.f2.value);
                                      },
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Location'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyTextField(
                                      hintText: 'Location',
                                      backgroundColor: colors.whiteColor,
                                      borderColor: colors.whiteColor,
                                      boxShadow: true,
                                      controller: controller.location.value,
                                      focusNode: controller.f2.value,
                                      onFieldSubmit: (val) {
                                        controller.f2.value.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(controller.f3.value);
                                      },
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Date of Birth'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyTextField(
                                      onTap: () async {
                                        print("check");
                                        await controller.selectDate(context);
                                      },
                                      readOnly: true,
                                      hintText: 'yyyy-mm-dd',
                                      backgroundColor: colors.whiteColor,
                                      borderColor: colors.whiteColor,
                                      inputFormate: controller.dateValidate,
                                      inputType: TextInputType.number,
                                      boxShadow: true,
                                      controller: controller.dob.value,
                                      focusNode: controller.f3.value,
                                      onFieldSubmit: (val) {
                                        controller.f3.value.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(controller.f4.value);
                                      },
                                      onChanged: (val) {
                                        // controller.diff();
                                      },
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Zip Code'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyTextField(
                                      hintText: 'Zip Code',
                                      backgroundColor: colors.whiteColor,
                                      borderColor: colors.whiteColor,
                                      boxShadow: true,
                                      controller: controller.zip.value,
                                      focusNode: controller.f4.value,
                                      onFieldSubmit: (val) {
                                        controller.f4.value.unfocus();
                                      },
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Verify your identity'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: responsive.setWidth(55),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: CoolDropdown(
                                            // dropdownWidth: responsive.setWidth(90),
                                            // resultWidth: responsive.setWidth(90),
                                            // resultHeight: responsive.setHeight(10),
                                            dropdownHeight:
                                                responsive.setHeight(16),
                                            dropdownList:
                                                controller.identityList,
                                            onChange: (val) {
                                              controller.identity.value =
                                                  val["value"].toString();
                                              controller.imageIdentity.value =
                                                  [];
                                            },
                                            resultIcon: Icon(
                                              Icons.expand_more,
                                              color: colors.primaryColor,
                                            ),
                                            dropdownItemMainAxis:
                                                MainAxisAlignment.center,
                                            resultAlign: Alignment.center,
                                            dropdownBD: BoxDecoration(
                                              color: colors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            dropdownWidth:
                                                responsive.setWidth(45),
                                            resultMainAxis:
                                                MainAxisAlignment.center,
                                            placeholder:
                                                "Select your identity type",
                                            placeholderTS: TextStyle(
                                              color: colors.primaryColor,
                                              fontSize:
                                                  responsive.setTextScale(12),
                                            ),
                                            selectedItemBD: BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(
                                                        color:
                                                            colors.primaryColor,
                                                        width: 0))),
                                            unselectedItemTS: TextStyle(
                                                color: colors.whiteColor,
                                                fontSize: responsive
                                                    .setTextScale(15)),
                                            selectedItemTS: TextStyle(
                                              color: colors.whiteColor,
                                              fontSize:
                                                  responsive.setTextScale(15),
                                            ),
                                            resultTS: TextStyle(
                                              color: colors.primaryColor,
                                              fontSize:
                                                  responsive.setTextScale(15),
                                            ),
                                            // defaultValue: controller.identityList[1],
                                            resultBD: BoxDecoration(
                                              color: colors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            // placeholder: 'insert...',
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive.setWidth(3),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              controller.checkFile.value = 1;
                                              controller.imageIdentity.value
                                                          .length <
                                                      2
                                                  ? showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return UploadPhoto(
                                                          screenName:
                                                              "profile_setting",
                                                        );
                                                      })
                                                  : CustomToast().showToast(
                                                      'Error',
                                                      "Max upload 2 images",
                                                      true);
                                            },
                                            child: Container(
                                              width: responsive.setWidth(30),
                                              height: responsive.setHeight(6.5),
                                              decoration: BoxDecoration(
                                                color: colors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        responsive.setWidth(4)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    MyText(
                                                      title: 'Upload',
                                                      clr: colors.hintColor,
                                                    ),
                                                    Icon(Icons
                                                        .photo_library_outlined)
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    controller.imageIdentity.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20, top: 20),
                                            child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemBuilder: (Context, index) {
                                                return Container(
                                                  height:
                                                      responsive.setWidth(15),
                                                  width:
                                                      responsive.setWidth(15),
                                                  margin: EdgeInsets.only(
                                                      left: responsive
                                                          .setWidth(2),
                                                      bottom: responsive
                                                          .setWidth(2)),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: Image.file(
                                                          controller
                                                              .imageIdentity
                                                              .value[index],
                                                          fit: BoxFit.cover,
                                                        ).image,
                                                        fit: BoxFit.cover),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.imageIdentity
                                                          .removeAt(index);
                                                    },
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: colors
                                                              .secondaryColor,
                                                        )),
                                                  ),
                                                );
                                              },
                                              itemCount: controller
                                                  .imageIdentity.value.length,
                                            ),
                                          )
                                        : usercontroller.user.value.result!
                                                    .identityImgPath !=
                                                null
                                            ? usercontroller.user.value.result!
                                                    .identityImgPath!.isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            top: 20),
                                                    child: GridView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount:
                                                                  3),
                                                      itemBuilder:
                                                          (Context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Get.bottomSheet(
                                                              ImagePreview(
                                                                network: controller
                                                                            .imageProfile
                                                                            .value
                                                                            .path ==
                                                                        ""
                                                                    ? usercontroller
                                                                            .user
                                                                            .value
                                                                            .result!
                                                                            .profileImage!
                                                                            .isNotEmpty
                                                                        ? APIEndpoints.baseURL +
                                                                            usercontroller.user.value.result!.profileImage!
                                                                        : null
                                                                    : null,
                                                                fileImage:
                                                                    controller
                                                                        .imageProfile
                                                                        .value,
                                                                // asset: (mapControler.currentPinInfo!.value.gallery == null&& mapControler.currentPinInfo!.value.gallery!.isEmpty)?ImagePath.noImageFound: null,
                                                              ),
                                                              isScrollControlled:
                                                                  true,
                                                            );
                                                          },
                                                          child: Container(
                                                            height: responsive
                                                                .setWidth(15),
                                                            width: responsive
                                                                .setWidth(15),
                                                            margin: EdgeInsets.only(
                                                                left: responsive
                                                                    .setWidth(
                                                                        2),
                                                                bottom: responsive
                                                                    .setWidth(
                                                                        2)),
                                                            alignment: Alignment
                                                                .center,

                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              image: NetworkImage(APIEndpoints
                                                                      .baseURL +
                                                                  usercontroller
                                                                          .user
                                                                          .value
                                                                          .result!
                                                                          .identityImgPath![
                                                                      index]!),
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                            )),
                                                            // child: InkWell(
                                                            //   onTap: (){
                                                            //     usercontroller.user.value.result!.identityImgPath!.removeAt(index);
                                                            //     usercontroller.user.refresh();
                                                            //     },
                                                            //   child: Align(
                                                            //       alignment: Alignment.topRight,
                                                            //       child: Icon(Icons.cancel,color:colors.secondaryColor,)
                                                            //   ),
                                                            // ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount: usercontroller
                                                          .user
                                                          .value
                                                          .result!
                                                          .identityImgPath!
                                                          .length,
                                                    ),
                                                  )
                                                : Container()
                                            : Container(),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'About Yourself'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyTextField(
                                      hintText: 'About',
                                      backgroundColor: colors.whiteColor,
                                      borderColor: colors.whiteColor,
                                      boxShadow: true,
                                      controller: controller.about.value,
                                      focusNode: controller.f5.value,
                                      onFieldSubmit: (val) {
                                        controller.f5.value.unfocus();
                                      },
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title: 'Pet Preferences',
                                      size: responsive.setTextScale(18),
                                      weight: 'Semi Bold',
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    MyText(title: 'Age Restrictions'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    Container(
                                      width: responsive.setWidth(100),
                                      height: responsive.setHeight(7),
                                      decoration: BoxDecoration(
                                          color: colors.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: CustomSlider(
                                          showLabel: false,
                                          maxValue: 300,
                                          minValue: 1,
                                          enableToolTip: true,
                                          showTick: false,
                                          stepSize: 1,
                                          rangeSlider: true,
                                          checkType: controller
                                              .homeController.ageRange.value,
                                          returnValue: (val) {
                                            controller.homeController.ageRange
                                                .value = val;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    // MyText(title: 'Activity'),
                                    // SizedBox(
                                    //   height: responsive.setHeight(1),
                                    // ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Favourite Pet Breed'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    Container(
                                      height: responsive.setHeight(5.5),
                                      width: responsive.setWidth(100),
                                      decoration: BoxDecoration(
                                        color: colors.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: CoolDropdown(
                                        dropdownWidth: responsive.setWidth(90),
                                        resultWidth: responsive.setWidth(100),
                                        // resultHeight: responsive.setHeight(10),

                                        dropdownHeight:
                                            responsive.setHeight(16),
                                        dropdownList: controller.breedList,
                                        onChange: (val) {
                                          controller.breed.value =
                                              val["value"].toString();
                                        },

                                        resultIcon: Icon(
                                          Icons.expand_more,
                                          color: colors.primaryColor,
                                        ),
                                        dropdownItemMainAxis:
                                            MainAxisAlignment.center,
                                        resultAlign: Alignment.center,
                                        dropdownBD: BoxDecoration(
                                          color: colors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        resultMainAxis:
                                            MainAxisAlignment.center,
                                        placeholder: "Select breed type",
                                        placeholderTS: TextStyle(
                                          color: colors.primaryColor,
                                          fontSize: responsive.setTextScale(12),
                                        ),
                                        selectedItemBD: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: colors.primaryColor,
                                                    width: 0))),
                                        unselectedItemTS: TextStyle(
                                            color: colors.whiteColor,
                                            fontSize:
                                                responsive.setTextScale(15)),
                                        selectedItemTS: TextStyle(
                                          color: colors.whiteColor,
                                          fontSize: responsive.setTextScale(15),
                                        ),
                                        resultTS: TextStyle(
                                          color: colors.primaryColor,
                                          fontSize: responsive.setTextScale(15),
                                        ),
                                        // defaultValue: controller.identityList[1],
                                        resultBD: BoxDecoration(
                                          color: colors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),

                                        // defaultValue: controller.breedList.isEmpty?"No Breeds Available": controller.breedList[0],
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                    MyText(title: 'Color Preference'),
                                    SizedBox(
                                      height: responsive.setHeight(1),
                                    ),
                                    Container(
                                      height: responsive.setHeight(5.5),
                                      width: responsive.setWidth(100),
                                      decoration: BoxDecoration(
                                        color: colors.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: CoolDropdown(
                                        dropdownWidth: responsive.setWidth(90),
                                        resultWidth: responsive.setWidth(100),
                                        // resultHeight: responsive.setHeight(10),

                                        dropdownHeight:
                                            responsive.setHeight(16),
                                        dropdownList: controller.colorList,
                                        onChange: (val) {
                                          controller.color.value =
                                              val["value"].toString();
                                        },
                                        resultIcon: Icon(
                                          Icons.expand_more,
                                          color: colors.primaryColor,
                                        ),

                                        dropdownItemMainAxis:
                                            MainAxisAlignment.center,
                                        resultAlign: Alignment.center,
                                        dropdownBD: BoxDecoration(
                                          color: colors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        resultMainAxis:
                                            MainAxisAlignment.center,
                                        placeholderTS: TextStyle(
                                          color: colors.primaryColor,
                                          fontSize: responsive.setTextScale(12),
                                        ),
                                        selectedItemBD: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: colors.primaryColor,
                                                    width: 0))),
                                        unselectedItemTS: TextStyle(
                                            color: colors.whiteColor,
                                            fontSize:
                                                responsive.setTextScale(15)),
                                        selectedItemTS: TextStyle(
                                          color: colors.whiteColor,
                                          fontSize: responsive.setTextScale(15),
                                        ),
                                        resultTS: TextStyle(
                                          color: colors.primaryColor,
                                          fontSize: responsive.setTextScale(15),
                                        ),
                                        // defaultValue: controller.identityList[1],
                                        resultBD: BoxDecoration(
                                          color: colors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),

                                        // defaultValue:  controller.colorList.isEmpty?"No Breeds Available": controller.colorList[0],
                                        placeholder: 'Select Color Type',
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(1.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.setHeight(2),
                          ),
                          MyElevatedButton(
                            onTap: () {
                              controller.f1.value.unfocus();
                              controller.f2.value.unfocus();
                              controller.f3.value.unfocus();
                              controller.f4.value.unfocus();
                              controller.f5.value.unfocus();
                              controller.UpdateProfile(context);
                              // controller.parseDate();
                            },
                            height: responsive.setHeight(7.5),
                            width: responsive.setWidth(90),
                            title: 'Update Settings',
                            textColor: colors.whiteColor,
                            bgColor: colors.primaryColor,
                            isImage: true,
                            imageColor: colors.blackColor.withOpacity(0.3),
                          ),
                          SizedBox(
                            height: responsive.setHeight(3),
                          ),
                        ],
                      ),
                      Positioned(
                          top: responsive.setHeight(1),
                          child: Image.asset(
                            'assets/icons/dohleftside.png',
                            width: responsive.setWidth(35),
                          )),
                    ],
                  ))),
      ),
    );
  }

  Future<bool> onWillPop() {
    Get.back();
    controller.resetData();
    return Future.value(true);
  }
}

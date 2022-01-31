import 'package:awesome_select/awesome_select.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/ShelterPicVideoController.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Controller/shelterpetinformation_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/tags_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseComponent/CustomSettingContainer.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:pawndr/Views/widgets/user_location.dart';

class AddPet extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController usercontroller = Get.put(UserController());
  ShelterPetInformationController controller =   Get.find();


  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return WillPopScope(
      onWillPop: () async {
        return Get.delete<ShelterPetInformationController>();
      },
      child: BaseView(
        showAppBar: false,
        showCircle2: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(
            () =>controller.loading.value==true?Container(): Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: responsive.setWidth(70),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ProfileImage(),
                                UserLocation()
                              ],
                            ),
                            SizedBox(
                              height: responsive.setHeight(3),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text:
                                    "Hey ${usercontroller.user.value.result!.name!}! ",
                                    style: TextStyle(
                                        fontSize: responsive
                                            .setTextScale(17),
                                        fontWeight: FontWeight.w500,
                                        color: colors.blackColor),
                                    children: [
                                      TextSpan(
                                          text:
                                          "Let\'s help someone out ",
                                          style: TextStyle(
                                              fontSize: responsive
                                                  .setTextScale(14),
                                              fontWeight:
                                              FontWeight.normal))
                                    ]),
                              ),
                            )
            ],
                        ),
                      ),
                    ),
                    Container(
                        width: responsive.setWidth(30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/pets/sideDog.png',
                            width: responsive.setWidth(45),
                          ),
                        ))
                  ],
                ),

                Divider(
                  thickness: 1,
                  color: colors.gray,
                  indent: responsive.setWidth(4),
                  endIndent: responsive.setWidth(4),
                ),
                GestureDetector(
                  onTap: () {
                    selectImageMode(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(responsive.setHeight(2)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primaryColor),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: colors.whiteColor,
                        ),
                        MyText(
                            title: "Add Photos",
                            size: 12,
                            clr: colors.whiteColor)
                      ],
                    ),
                  ),
                ),
                controller.filePaths.length == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (Context, index) {
                            return  GestureDetector(
                              onTap: (){
                                Get.bottomSheet(
                                  ImagePreview(
                                    thumbnail: controller.filePaths[index],
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: Container(
                                height: responsive.setWidth(16),
                                width: responsive.setWidth(15),
                                // margin: EdgeInsets.only(left: responsive.setWidth(2),bottom: responsive.setWidth(2)),
                                alignment: Alignment.topRight,
                                 padding: EdgeInsets.only(top: responsive.setWidth(1),right: responsive.setWidth(1)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: colors.primaryColor),
                                  image: DecorationImage(
                                    image: FileImage(
                                      controller.filePaths[index],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: (){controller.filePaths.removeAt(index);},
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.cancel,color:colors.secondaryColor,)
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: controller.filePaths.length,
                        )),
                SizedBox(height:  responsive.setHeight(2),),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                      child: MyTextField(
                    showBar: false,
                    borderColor: Colors.transparent,
                    hintText: 'Name',
                    hintTextColor: colors.hintColor,
                    controller: controller.name.value,
                    inputType: TextInputType.name,
                    focusNode: controller.f1.value,
                    onFieldSubmit: (val) {
                      controller.f1.value.unfocus();
                      FocusScope.of(context).requestFocus(controller.f2.value);
                    },
                  )),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Age",
                    path: "",
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      onTap: () async {
                        print("check");
                        await controller.selectDate(context);
                      },
                      readOnly: true,
                      hintText: 'Age',
                      hintTextColor: colors.hintColor,
                      controller: controller.age.value,
                      inputType: TextInputType.number,
                      focusNode: controller.f2.value,
                      onFieldSubmit: (val) {
                        controller.f2.value.unfocus();
                        FocusScope.of(context)
                            .requestFocus(controller.f3.value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Gender",
                    path: "",
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      hintText: 'Gender',
                      hintTextColor: colors.hintColor,
                      controller: controller.gender.value,
                      focusNode: controller.f3.value,
                      onFieldSubmit: (val) {
                        controller.f3.value.unfocus();
                        FocusScope.of(context)
                            .requestFocus(controller.f4.value);
                      },
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       vertical: responsive.setHeight(1),
                //       horizontal: responsive.setWidth(2)),
                //   child: CustomSettingContainer(
                //     tabName: "Color",
                //     path: "",
                //     child:CoolDropdown(
                //       dropdownWidth: responsive.setWidth(90),
                //       resultWidth: responsive.setWidth(100),
                //       resultHeight: responsive.setHeight(12),
                //
                //       dropdownHeight:
                //       responsive.setHeight(16),
                //       dropdownList: profileSettingController.colorList,
                //       onChange: (val) {
                //         controller.color.value = val["value"].toString();
                //       },
                //       resultIcon: Icon(
                //         Icons.expand_more,
                //         color: colors.primaryColor,
                //       ),
                //
                //       dropdownItemMainAxis:
                //       MainAxisAlignment.center,
                //       resultAlign: Alignment.center,
                //
                //       dropdownBD: BoxDecoration(
                //         color: colors.primaryColor,
                //         borderRadius:
                //         BorderRadius.circular(10),
                //       ),
                //       resultMainAxis:
                //       MainAxisAlignment.center,
                //       placeholderTS: TextStyle(
                //         color: colors.primaryColor,
                //         fontSize: responsive.setTextScale(12),
                //       ),
                //       selectedItemBD: BoxDecoration(
                //           border: Border(
                //               left: BorderSide(
                //                   color: colors.primaryColor,
                //                   width: 0))),
                //       unselectedItemTS: TextStyle(
                //           color: colors.whiteColor,
                //           fontSize:
                //           responsive.setTextScale(15)),
                //       selectedItemTS: TextStyle(
                //         color: colors.whiteColor,
                //         fontSize: responsive.setTextScale(15),
                //       ),
                //       resultTS: TextStyle(
                //         color: colors.primaryColor,
                //         fontSize: responsive.setTextScale(15),
                //       ),
                //       // defaultValue: controller.identityList[1],
                //       resultBD: BoxDecoration(
                //         color: colors.whiteColor,
                //         borderRadius:
                //         BorderRadius.circular(10),
                //       ),
                //
                //       // defaultValue:  controller.colorList.isEmpty?"No Breeds Available": controller.colorList[0],
                //       placeholder: 'Select Color Type',
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Color",
                    path: "",
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      hintText: 'Color',
                      hintTextColor: colors.hintColor,
                      // controller: controller.color.value,
                      focusNode: controller.f4.value,
                      onFieldSubmit: (val) {
                        controller.f4.value.unfocus();
                        FocusScope.of(context)
                            .requestFocus(controller.f5.value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Characteristics",
                    path: "",
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      hintText: 'Characteristics',
                      hintTextColor: colors.hintColor,
                      controller: controller.characterstics.value,
                      focusNode: controller.f5.value,
                      onFieldSubmit: (val) {
                        controller.f5.value.unfocus();
                        FocusScope.of(context)
                            .requestFocus(controller.f6.value);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Breed",
                    path: "",
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      hintText: 'Breed',
                      hintTextColor: colors.hintColor,
                      controller: controller.breed.value,
                      focusNode: controller.f6.value,
                      onFieldSubmit: (val) {
                        controller.f6.value.unfocus();
                        FocusScope.of(context)
                            .requestFocus(controller.f7.value);
                      },
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: responsive.setWidth(2), right: responsive.setWidth(2), top: responsive.setHeight(0)),
                //   child: SmartSelect.multiple(
                //     title: 'Breeds',
                //     // selectedValue: _homeController.petsList.value,
                //     onChange: (selected) {
                //       if(selected!.value!=null)
                //       {
                //         for(int i=0;i<selected.value!.length;i++)
                //         {
                //           _homeController.markedCharList.add(Tags(
                //               name: "${selected.title![i]}",
                //               id: "${selected.value![i]}"));
                //         }
                //         print(_homeController.markedCharList);
                //       }
                //     },
                //     choiceItems: S2Choice.listFrom<String, Tags>(
                //       source: _homeController.charList.value,
                //       value: (index, item) => item.id ?? '',
                //       title: (index, item) => item.name ?? '',
                //     ),
                //     choiceType: S2ChoiceType.chips,
                //     modalFilter: true,
                //     modalTitle: "",
                //     modalType: S2ModalType.popupDialog,
                //     tileBuilder: (context, state) {
                //       return S2Tile.fromState(
                //         state,
                //         isTwoLine: false,
                //         value: Text(""),
                //         title: MyText(title: "Characterstics",size: responsive.setTextScale(16),
                //           clr: colors.textColor,),
                //         trailing: Icon(  Icons.arrow_forward_ios_rounded,
                //           size: responsive.setTextScale(15),
                //           color: colors.textColor,),
                //         body: S2TileChips(
                //           chipLength: _homeController.markedCharList.length,
                //           chipLabelBuilder: (context, i) {
                //             return Text(_homeController.markedCharList[i].name!,);
                //           },
                //           chipOnDelete: (i) {
                //             _homeController.markedCharList.remove([i]);
                //           },
                //           chipDeleteIcon: Icon(Icons.check_circle_outline,size: responsive.setTextScale(14),),
                //           chipColor: colors.whiteColor,
                //         ),
                //       );
                //     },
                //
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: responsive.setHeight(1),
                      horizontal: responsive.setWidth(2)),
                  child: CustomSettingContainer(
                    tabName: "Description",
                    path: "",
                    height: 15,
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      hintText: 'Description',
                      hintTextColor: colors.hintColor,
                      controller: controller.description.value,
                      focusNode: controller.f7.value,
                      minLines: 5,
                      maxLines: 10,
                      onFieldSubmit: (val) {
                        controller.f7.value.unfocus();
                      },

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: responsive.setWidth(2),
                      right: responsive.setWidth(2),
                      bottom: responsive.setHeight(2),
                      top: responsive.setHeight(1)),
                  padding: EdgeInsets.all(responsive.setHeight(2)),
                  decoration: BoxDecoration(
                      color: colors.darkYellow,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      SizedBox(height: responsive.setHeight(0.5)),
                      InkWell(
                        onTap: () {
                          controller.f1.value.unfocus();
                          controller.f2.value.unfocus();
                          controller.f3.value.unfocus();
                          controller.f4.value.unfocus();
                          controller.f5.value.unfocus();
                          controller.f6.value.unfocus();
                          controller.f7.value.unfocus();
                          controller.showList.value = !controller.showList.value;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              title: controller.petType.value,
                              clr: colors.whiteColor,
                              size: 16,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: colors.whiteColor,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.setHeight(0.5)),
                      controller.showList.isTrue
                          ? SizedBox(
                              height: responsive.setHeight(20),
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: controller.petTypeList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.showList.value = false;
                                        controller.petType.value =
                                            controller.petTypeList[index];
                                      },
                                      child: Container(
                                        child: Wrap(
                                          children: [
                                            Divider(
                                                thickness: 1,
                                                color: colors.whiteColor),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: responsive.setHeight(1),
                                                  bottom:
                                                      responsive.setHeight(1)),
                                              child: MyText(
                                                title: controller
                                                    .petTypeList[index],
                                                clr: colors.whiteColor,
                                                size: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container()
                    ],
                  ),
                ),
                MyButton(
                  textColor: colors.whiteColor,
                  title: "Submit",
                  fontSize: 14,
                  bgColor: colors.primaryColor,
                  width: responsive.setWidth(35),
                  onTap: () {
                    controller.f1.value.unfocus();
                    controller.f2.value.unfocus();
                    controller.f3.value.unfocus();
                    controller.f4.value.unfocus();
                    controller.f5.value.unfocus();
                    controller.f6.value.unfocus();
                    controller.f7.value.unfocus();
                    controller.validation(context);
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: responsive.setWidth(4),
                        bottom: responsive.setHeight(1)),
                    child: MyText(
                      title: "Past Entries",
                      size: 18,
                    ),
                  ),
                ),
                controller.recentPets.value.result!.isEmpty?Center(
                  child: MyText(
                    title: 'No Recent Pets',
                    size: responsive.setTextScale(18),
                    clr: colors.gray,
                  ),
                ):  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.recentPets.value.result!.length,
                    itemBuilder: (Context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: responsive.setWidth(2)),
                        margin: EdgeInsets.only(
                            left: responsive.setWidth(4),
                            right: responsive.setWidth(4),
                            bottom: responsive.setHeight(2)),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: colors.gray,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                ImagePath.pet,
                                height: responsive.setHeight(15),
                                width: responsive.setHeight(12),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: responsive.setWidth(4)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title: controller.recentPets.value.result![index].name!,
                                      size: 16,
                                      clr: colors.primaryColor,
                                    ),
                                    controller.recentPets.value.result![index].breed== null? MyText(
                                      title:
                                      "N/A",
                                      size: 10,
                                      clr: colors.whiteColor,
                                      line: 5,
                                    ):
                                    SizedBox(
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            controller.recentPets.value.result![index].breed!.length,
                                                (index) => MyText(
                                              title:
                                              "${controller.recentPets.value.result![index].breed} ",
                                              size: 10,
                                              clr: colors.whiteColor,
                                              line: 5,
                                            )),
                                      ),
                                    ),
                                    // MyText(
                                    //   title:controller.recentPets.value.result![index].breed![0].name!,
                                    //   size: 12,
                                    //   clr: colors.gray,
                                    //   toverflow: TextOverflow.ellipsis,
                                    //   line: 2,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: responsive.setWidth(1),
                                  right: responsive.setWidth(1)),
                              height: responsive.setHeight(10),
                              width: responsive.setWidth(0.2),
                              color: colors.gray,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      MyText(
                                        title: " Weight",
                                        size: 12,
                                        clr: colors.gray,
                                      ),
                                      MyText(
                                        title: "  : ",
                                        size: 12,
                                        clr: colors.blackColor,
                                      ),
                                      Expanded(child:
                                      MyText(
                                        title: "${controller.recentPets.value.result![index].weight!} Kg",
                                        size: 12,
                                        clr: colors.primaryColor,
                                      ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        title: " Age",
                                        size: 12,
                                        clr: colors.gray,
                                      ),
                                      MyText(
                                        title: "        :",
                                        size: 12,
                                        clr: colors.blackColor,
                                      ),
                                      Expanded(
                                        child: MyText(
                                            title: "${controller.recentPets.value.result![index].age!} years",
                                            size: 12,
                                            clr: colors.primaryColor,
                                            toverflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        title: " Gender",
                                        size: 12,
                                        clr: colors.gray,
                                      ),
                                      MyText(
                                        title: " : ",
                                        size: 12,
                                        clr: colors.blackColor,
                                      ),
                                      Expanded(
                                        child: MyText(
                                          title: controller.recentPets.value.result![index].gender!,
                                          size: 12,
                                          clr: colors.primaryColor,
                                          toverflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        title: " Color",
                                        size: 12,
                                        clr: colors.gray,
                                      ),
                                      MyText(
                                        title: "     : ",
                                        size: 12,
                                        clr: colors.blackColor,
                                      ),
                            Expanded(child:
                                      MyText(
                                          title:  controller.recentPets.value.result![index].color!,
                                          size: 12,
                                          clr: colors.primaryColor,
                                          toverflow: TextOverflow.ellipsis),),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImageMode(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            content: MyText(
              title: "Select Image Mode",
              center: true,
              clr: colors.primaryColor,
              weight: "Semi Bold",
              size: 18,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              new TextButton(
                child: MyText(
                  title: "Gallery",
                  center: true,
                  clr: colors.whiteColor,
                  size: 15,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => colors.primaryColor),
                    elevation: MaterialStateProperty.all(5)),
                onPressed: () {
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              new TextButton(
                child: MyText(
                  title: "Camera",
                  center: true,
                  clr: colors.whiteColor,
                  size: 15,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => colors.primaryColor),
                    elevation: MaterialStateProperty.all(5)),
                onPressed: () {
                  controller.imgFromCamera();
                  Get.back();
                },
              )
            ],
          );
        });
  }
}

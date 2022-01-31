// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_divider.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_multitext.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Controller/selection_controller.dart';
import 'package:pawndr/Controller/signInController.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/PetDetailScreen.dart';
import 'package:pawndr/Views/Story/StoryBottomSheet.dart';
import 'package:pawndr/Views/widgets/filter_bottom_sheet.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/location_sheet.dart';
import 'package:pawndr/Views/widgets/pets_tile.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:pawndr/Views/widgets/user_location.dart';
import 'package:photo_view/photo_view.dart';

class FinderHomeScreen extends StatelessWidget {
  UserController controller = Get.find();
  FinderHomeController finderHomeController = Get.put(FinderHomeController());
  HomeController homeController = Get.put(HomeController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return DoubleBack(
        message: "Press back again to close",
        child: BaseView(
            showAppBar: false,
            showCircle2: false,
            child: Obx(
              () => finderHomeController.loading.value == true ? Container()
                  : controller.user.value.result==null?Container(): SingleChildScrollView(
                      child: Column(
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
                                                  "Hey ${controller.user.value.result!.name!}! ",
                                              style: TextStyle(
                                                  fontSize: responsive
                                                      .setTextScale(17),
                                                  fontWeight: FontWeight.w500,
                                                  color: colors.blackColor),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "what are you looking for? ",
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: responsive.setHeight(2),
                                ),
                                Card(
                                    elevation: 5,
                                    child: MyTextField(
                                        showBar: false,
                                        borderColor: Colors.transparent,
                                        prefixIconData: Icons.search,
                                        prefixIconColor: colors.primaryColor,
                                        hintText: 'Find your partner',
                                        hintTextColor: colors.hintColor,
                                        focusNode: finderHomeController.f1.value,
                                        suffixFaIconData: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.slidersH,
                                            color: colors.primaryColor,
                                          ),
                                        ),
                                        controller: homeController.search.value,
                                        onChanged:(val){
                                          if (val.isNotEmpty) {
                                            homeController.isFilter.value =
                                            true;
                                            homeController.searchPets();
                                          } else {homeController.isFilter.value = false;}
                                            } ,
                                        onFieldSubmit: (val) {
                                          finderHomeController.f1.value.unfocus();
                                        },
                                        onTapSuffixFaIcon: () =>
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              enableDrag: true,
                                              elevation: 5,
                                              builder: (context) =>
                                                  FilterBottomSheetContent(),
                                            ))),
                                SizedBox(
                                  height: responsive.setHeight(1.5),
                                ),
                                MyText(
                                  title: 'Recent Pets View',
                                  size: responsive.setTextScale(20),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(1.5),
                                ),
                                Container(
                                  height: responsive.setHeight(10),
                                  width: responsive.setWidth(100),
                                  child: finderHomeController.petView.value.result!.isEmpty
                                      ? Center(
                                          child: MyText(
                                            title: 'No Recent Views',
                                            size: responsive.setTextScale(18),
                                            clr: colors.gray,
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: finderHomeController
                                              .petView.value.result!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return PetTile(
                                                onTap: false,
                                                width: 20,
                                                height: 8,
                                                index: index,
                                                pet: finderHomeController
                                                    .petView.value.result![index].obs);
                                            // return Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(right: 10.0),
                                            //   child: InkWell(
                                            //     onTap: () => showModalBottomSheet(
                                            //       context: context,
                                            //       isScrollControlled: true,
                                            //       enableDrag: true,
                                            //       elevation: 5,
                                            //       barrierColor:
                                            //           colors.gray.withOpacity(0.9),
                                            //       builder: (context) =>
                                            //           StoryBottomSheet(),
                                            //     ),
                                            //     child: Container(
                                            //       width: responsive.setWidth(15),
                                            //       child: PetTile(
                                            //
                                            //       ),
                                            //       // child: MyCircleImage(
                                            //       //   isNetworkImage: true,
                                            //       //   // finderHomeController.petView.value.result![index].petGallery ==null?
                                            //       //   imgPath:
                                            //       //   finderHomeController.petView.value.result![index].petGallery !=null?
                                            //       //   finderHomeController.petView.value.result![index].petGallery!.isEmpty?
                                            //       //   ImagePath.noImageFound:
                                            //       //   APIEndpoints.baseURL+finderHomeController.petView.value.result![index].petGallery!.last.path.toString():
                                            //       //   ImagePath.noImageFound,
                                            //       //   // finderHomeController.petView.value.result![index]!.petGallery,
                                            //       //   borderColor: Colors.transparent,
                                            //       // ),
                                            //     ),
                                            //   ),
                                            // );
                                          }),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(2),
                                ),
                                MyDivider(
                                  color: colors.primaryColor.withOpacity(0.5),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(2),
                                ),
                                MyText(
                                  title: homeController.isFilter.isTrue?"Search Result" :"""People Pet's Near You""",
                                  size: responsive.setTextScale(20),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(2),
                                ),
                                Container(
                                  height: responsive.setHeight(26),
                                  width: responsive.setWidth(100),
                                  child:
                                  // finderHomeController.nearByPets.value.result!=null?
                                   homeController.isFilter.isTrue?
                                   homeController.filterPets.value.result!=null ?
                                   homeController.filterPets.value.result!.isNotEmpty ?
                                   ListView.builder(
                                       physics: BouncingScrollPhysics(),
                                       scrollDirection: Axis.horizontal,
                                       itemCount: homeController.filterPets.value.result!.length,
                                       itemBuilder: (BuildContext context,
                                           int index) {
                                         return PetTile(
                                             width: 35,
                                             height: 22,
                                             index: index,
                                             pet: homeController
                                                 .filterPets.value.result![index].obs);
                                       }):
                                   Center(
                                     child: MyText(
                                       title: 'No Pets Available',
                                       size: responsive.setTextScale(18),
                                       clr: colors.gray,
                                     ),
                                   ):
                                   Center(
                                     child: MyText(
                                       title: 'No Pets Available',
                                       size: responsive.setTextScale(18),
                                       clr: colors.gray,
                                     ),
                                   ):
                                   finderHomeController.nearByPets.value.result!=null ?
                                   finderHomeController.nearByPets.value.result!.isNotEmpty ?
                                   ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: finderHomeController
                                              .nearByPets.value.result!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return PetTile(
                                                width: 35,
                                                height: 22,
                                                index: index,
                                                pet: finderHomeController
                                                    .nearByPets.value.result![index].obs);
                                          }):
                                   Center(
                                    child: MyText(
                                      title: 'No Pets Available',
                                      size: responsive.setTextScale(18),
                                      clr: colors.gray,
                                    ),
                                  ):Center(
                                     child: MyText(
                                       title: 'No Pets Available',
                                       size: responsive.setTextScale(18),
                                       clr: colors.gray,
                                     ),
                                   ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            )));
  }
}

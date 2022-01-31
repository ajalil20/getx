import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pawndr/Views/widgets/shelter_tile.dart';

class ShelterHomeScreen extends StatelessWidget {
  ShelterHomeController controller = Get.put(ShelterHomeController());
  HomeController homeController = Get.put(HomeController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showAppBar: true,
      titleWeight: 'Bold',
      screenNamee: 'Shelters',
      titleFontSize: responsive.setTextScale(20),
      titleClr: colors.blackColor,
      showCircle3: false,
      align2Top: -30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(()=>controller.loading.value==true?Container(): Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    elevation: 5,
                    child: MyTextField(
                      showBar: false,
                      borderColor: Colors.transparent,
                      prefixIconData: Icons.search,
                      prefixIconColor: colors.primaryColor,
                      hintText: 'Search your shelter',
                      hintTextColor: colors.hintColor,
                      focusNode: homeController.f1.value,
                      controller: homeController.searchShelter.value,
                      onTapSuffixFaIcon: (){
                        Get.toNamed("/shelterPetPictureUpload");
                      },
                      onChanged:(val){
                        if (val.isNotEmpty) {
                          homeController.isShelterFilter.value =
                          true;
                          homeController.searchShelters();
                        } else {homeController.isShelterFilter.value = false;}
                      } ,
                      onFieldSubmit: (val) {
                        homeController.f1.value.unfocus();
                      },
                      suffixFaIconData: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FaIcon(
                          FontAwesomeIcons.slidersH,
                          color: colors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                MyText(
                  title: homeController.isShelterFilter.isTrue?'Search Results' :'Shelters Near You',
                  weight: 'Semi Bold',
                  size: responsive.setTextScale(18),
                ),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                homeController.isShelterFilter.value==true?
                Container(
                    height: responsive.setHeight(18),
                    width: responsive.setWidth(100),
                    child: homeController.filterShelters.value.result!=null? homeController.filterShelters.value.result!.isNotEmpty?
                    ListView.builder(
                        itemCount: homeController.filterShelters.value.result!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext, int index) {
                          return ShelterTile(index: index,shelter: homeController.filterShelters.value.result![index].obs,);
                        }):
                    Center(
                        child: MyText(
                          title: 'No Shelter Available',
                          size: responsive.setTextScale(18),
                          clr: colors.gray,
                        )
                    ):Container()
                ):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: responsive.setHeight(18),
                      width: responsive.setWidth(100),
                      child: controller.resp.value.result!=null? controller.resp.value.result!.isNotEmpty?
                      ListView.builder(
                          itemCount: controller.resp.value.result!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext, int index) {
                            return ShelterTile(index: index,shelter: controller.resp.value.result![index].obs,);
                          }):
                      Center(
                        child: MyText(
                          title: 'No Shelter Available',
                          size: responsive.setTextScale(18),
                          clr: colors.gray,
                        )
                      ):Container()
                    ),
                    Container(
                      height: 0.5,
                      color: colors.hintColor,
                    ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    MyText(
                      title: 'Massive Shelters',
                      weight: 'Semi Bold',
                      size: responsive.setTextScale(18),
                    ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    Container(
                        height: responsive.setHeight(18),
                        width: responsive.setWidth(100),
                        child: controller.massiveShelters.value.result!=null?
                        controller.massiveShelters.value.result!.isNotEmpty?
                        ListView.builder(
                            itemCount: controller.massiveShelters.value.result!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext, int index) {
                              return ShelterTile(index: index,shelter: controller.massiveShelters.value.result![index].obs,);
                            }):
                        Center(
                          child: MyText(
                            title: 'No Shelter Available',
                            size: responsive.setTextScale(18),
                            clr: colors.gray,
                          ),
                        ):Container()
                    ),
                    MyText(
                      title: 'Favorites Shelters',
                      weight: 'Semi Bold',
                      size: responsive.setTextScale(18),
                    ),
                    SizedBox(
                      height: responsive.setHeight(1),
                    ),
                    Container(
                        height: responsive.setHeight(18),
                        width: responsive.setWidth(100),
                        child:
                        controller.favoriteShelters.value.result!=null? controller.favoriteShelters.value.result!.isNotEmpty?
                        ListView.builder(
                            itemCount: controller.favoriteShelters.value.result!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext, int index) {
                              return ShelterTile(index: index,shelter: controller.favoriteShelters.value.result![index].obs,);
                            }):
                        Center(
                          child: MyText(
                            title: 'No Shelter Available',
                            size: responsive.setTextScale(18),
                            clr: colors.gray,
                          ),
                        ):Container()
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

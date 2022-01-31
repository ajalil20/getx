import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/BottomBarController.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/filter_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/pets_tile.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:pawndr/Views/widgets/user_location.dart';

class PetsScreen extends StatelessWidget {
  UserController usercontroller = Get.put(UserController());
  FinderHomeController finderHomeController = Get.put(FinderHomeController());
  BottomBarController bottomBarController = Get.put(BottomBarController());
  HomeController homeController = Get.put(HomeController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  PetScreenController controller = Get.put(PetScreenController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: BaseView(
        showAppBar: false,
        showCircle2: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () => (controller.loading.isTrue)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 10, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                usercontroller.user.value.result != null
                                    ? Row(
                                        children: [
                                          ProfileImage(),
                                          UserLocation()                                        ],
                                      )
                                    : Container(
                                        height: responsive.setHeight(8),
                                      ),
                                SizedBox(
                                  height: responsive.setHeight(1.5),
                                ),
                                MyText(
                                  title: 'Recent Pets Story',
                                  size: responsive.setTextScale(18),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(1.2),
                                ),
                                Divider(
                                  color: colors.hintColor,
                                  thickness: 0.4,
                                ),
                                SizedBox(
                                  height: responsive.setHeight(0.4),
                                ),
                                Container(
                                  height: responsive.setHeight(10),
                                  width: responsive.setWidth(100),
                                  child: finderHomeController
                                              .petView.value.result ==
                                          null
                                      ? Center(
                                          child: MyText(
                                            title: 'No Recent Views',
                                            size: responsive.setTextScale(18),
                                            clr: colors.gray,
                                          ),
                                        )
                                      : finderHomeController
                                      .petView.value.result!.isEmpty
                                      ? Center(
                                    child: MyText(
                                      title: 'No Recent Views',
                                      size: responsive.setTextScale(18),
                                      clr: colors.gray,
                                    ),
                                  ):ListView.builder(
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
                                                    .petView
                                                    .value
                                                    .result![index]
                                                    .obs);
                                          }),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(0.4),
                                ),
                                Divider(
                                  color: colors.hintColor,
                                  thickness: 0.4,
                                ),
                                SizedBox(
                                  height: responsive.setHeight(0.4),
                                ),
                                Card(
                                    elevation: 5,
                                    child: MyTextField(
                                        showBar: false,
                                        borderColor: Colors.transparent,
                                        prefixIconData: Icons.search,
                                        prefixIconColor: colors.primaryColor,
                                        hintText: 'Find your pet',
                                        hintTextColor: colors.hintColor,
                                        focusNode:
                                            finderHomeController.f1.value,
                                        suffixFaIconData: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.slidersH,
                                            color: colors.primaryColor,
                                          ),
                                        ),
                                        controller: homeController.search.value,
                                        onChanged: (val) {
                                          if (val.isNotEmpty) {
                                            homeController.isFilter.value =
                                            true;
                                            homeController.searchPets();
                                          } else {homeController.isFilter.value = false;}
                                        },
                                        onFieldSubmit: (val) {
                                          finderHomeController.f1.value
                                              .unfocus();
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
                                  height: responsive.setHeight(1),
                                ),
                                MyText(
                                  title: homeController.isFilter.isTrue
                                      ? 'Search Result'
                                      : 'Top Breeds',
                                  size: responsive.setTextScale(18),
                                ),
                                SizedBox(
                                  height: responsive.setHeight(1),
                                ),
                                homeController.isFilter.isTrue
                                    ? Container(
                                        height: responsive.setHeight(19),
                                        width: responsive.setWidth(100),
                                        child: homeController.filterPets.value
                                                .result!.isEmpty
                                            ? Center(
                                                child: MyText(
                                                  title: 'No Pet Available',
                                                  size: responsive
                                                      .setTextScale(18),
                                                  clr: colors.gray,
                                                ),
                                              )
                                            : ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: homeController
                                                    .filterPets
                                                    .value
                                                    .result!
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return PetTile(
                                                    index: index,
                                                    pet: homeController
                                                        .filterPets
                                                        .value
                                                        .result![index]
                                                        .obs,
                                                    height: 12,
                                                    width: 40,
                                                  );
                                                }),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: responsive.setHeight(19),
                                            width: responsive.setWidth(100),
                                            child: controller.resp.value.result!
                                                    .topBreeds!.isEmpty
                                                ? Center(
                                                    child: MyText(
                                                      title: 'Not Available',
                                                      size: responsive
                                                          .setTextScale(18),
                                                      clr: colors.gray,
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .resp
                                                        .value
                                                        .result!
                                                        .topBreeds!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PetTile(
                                                        index: index,
                                                        pet: controller
                                                            .resp
                                                            .value
                                                            .result!
                                                            .topBreeds![index]
                                                            .obs,
                                                        height: 12,
                                                        width: 40,
                                                      );
                                                    }),
                                          ),
                                          SizedBox(
                                            height: responsive.setHeight(1),
                                          ),
                                          MyText(
                                            title: 'Dogs',
                                            size: responsive.setTextScale(18),
                                          ),
                                          SizedBox(
                                            height: responsive.setHeight(1),
                                          ),
                                          Container(
                                            height: responsive.setHeight(19),
                                            width: responsive.setWidth(100),
                                            child: controller.resp.value.result!
                                                    .dog!.isNotEmpty
                                                ? ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .resp
                                                        .value
                                                        .result!
                                                        .dog!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PetTile(
                                                          index: index,
                                                          pet: controller
                                                              .resp
                                                              .value
                                                              .result!
                                                              .dog![index].obs);
                                                    })
                                                : Center(
                                                    child: MyText(
                                                      title: 'Not Available',
                                                      size: responsive
                                                          .setTextScale(18),
                                                      clr: colors.gray,
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: responsive.setHeight(1),
                                          ),
                                          MyText(
                                            title: 'Cats',
                                            size: responsive.setTextScale(18),
                                          ),
                                          SizedBox(
                                            height: responsive.setHeight(1),
                                          ),
                                          Container(
                                            height: responsive.setHeight(19),
                                            width: responsive.setWidth(100),
                                            child: controller.resp.value.result!
                                                    .cat!.isEmpty
                                                ? Center(
                                                    child: MyText(
                                                      title: 'Not Available',
                                                      size: responsive
                                                          .setTextScale(18),
                                                      clr: colors.gray,
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .resp
                                                        .value
                                                        .result!
                                                        .cat!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PetTile(
                                                          index: index,
                                                          pet: controller
                                                              .resp
                                                              .value
                                                              .result!
                                                              .cat![index]
                                                              .obs);
                                                    }),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/pets/sideDog.png',
                      width: responsive.setWidth(35),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    bottomBarController.currentIndex.value = 0;
    if (usercontroller.user.value.result!.userType == "petfinder") {
      Get.toNamed('/finderHome');
    } else if (usercontroller.user.value.result!.userType ==
        "volunteershelter") {
      Get.toNamed('/volunteerHome');
    }
    return Future.value(true);
  }
}

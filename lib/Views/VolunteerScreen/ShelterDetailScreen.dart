import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/map_controller.dart';
import 'package:pawndr/Controller/shelterpetinformation_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/pet_request_popup.dart';
import 'package:pawndr/Views/widgets/pets_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class ShelterDetailScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController controller = Get.find();
  MapControler mapControler = Get.put(MapControler());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showAppBar: false,
      showCircle1: false,
      showBottomBar: true,
      showCircle2: true,
      child: Obx(
        () =>
            // mapControler.loading.isTrue? Container():
            Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            ImagePath.bgImage,
                          ))),
                  height: responsive.setHeight(30),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      ImagePath.pawss,
                    ),
                  )),
                  height: responsive.setHeight(30),
                ),
                Positioned(
                  top: responsive.setHeight(2),
                  left: responsive.setWidth(4),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: colors.darkYellow,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(responsive.setHeight(1)),
                      child: Icon(
                        Icons.arrow_back,
                        color: colors.whiteColor,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: responsive.setWidth(4),
                  top: responsive.setHeight(4),
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        height: responsive.setHeight(5),
                        width: responsive.setHeight(5),
                        decoration: BoxDecoration(
                            color: colors.whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(responsive.setHeight(1)),
                        child: GestureDetector(
                            onTap: () {
                              mapControler.makePhoneCall(
                                  "tel:${mapControler.currentPinInfo!.value.phone!}");
                            },
                            child: Icon(
                              Icons.phone,
                              color: colors.darkYellow,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: responsive.setHeight(5),
                        width: responsive.setHeight(5),
                        decoration: BoxDecoration(
                            color: colors.whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(responsive.setHeight(1)),
                        child: FaIcon(FontAwesomeIcons.comment,
                            color: colors.darkYellow),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: responsive.setHeight(4),
                              bottom: responsive.setHeight(1)),
                          height: responsive.setWidth(22),
                          width: responsive.setWidth(22),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: colors.whiteColor),
                          padding: EdgeInsets.all(responsive.setWidth(0.5)),
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                ImagePreview(
                                  thumbnail: mapControler.currentPinInfo!.value
                                              .shelterGallery !=
                                          null
                                      ? mapControler.currentPinInfo!.value
                                          .shelterGallery!.last.thumbnail
                                      : null,
                                  network: mapControler.currentPinInfo!.value
                                              .shelterGallery !=
                                          null
                                      ? APIEndpoints.baseURL +
                                          mapControler.currentPinInfo!.value
                                              .shelterGallery!.last.path!
                                      : null,
                                  // asset: (mapControler.currentPinInfo!.value.shelterGallery == null&& mapControler.currentPinInfo!.value.shelterGallery!.isEmpty)?ImagePath.noImageFound: null,
                                ),
                                isScrollControlled: true,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: (mapControler.currentPinInfo!.value.shelterGallery != null &&
                                        mapControler.currentPinInfo!.value
                                            .shelterGallery!.isNotEmpty)
                                    ? mapControler
                                                .currentPinInfo!
                                                .value
                                                .shelterGallery!
                                                .last
                                                .thumbnail !=
                                            null
                                        ? DecorationImage(
                                            image: FileImage(mapControler
                                                .currentPinInfo!
                                                .value
                                                .shelterGallery!
                                                .last
                                                .thumbnail!),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(
                                                APIEndpoints.baseURL +
                                                    mapControler
                                                        .currentPinInfo!
                                                        .value
                                                        .shelterGallery!
                                                        .last
                                                        .path!),
                                            fit: BoxFit.cover)
                                    : DecorationImage(
                                        image: AssetImage(
                                          ImagePath.noImageFound,
                                        ),
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        MyText(
                          title: mapControler.currentPinInfo!.value.name!,
                          size: 15,
                          weight: "Bold",
                          clr: colors.whiteColor,
                          center: true,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: colors.whiteColor,
                            ),
                            MyText(
                              title: '${mapControler.currentPinInfo!.value.city!} ${mapControler.currentPinInfo!.value.state!} ${mapControler.currentPinInfo!.value.country!}',
                              clr: colors.whiteColor,
                              toverflow: TextOverflow.ellipsis,
                              center: true,
                            )
                          ],
                        ),
                        RatingBarIndicator(
                          rating: double.parse(mapControler
                              .currentPinInfo!.value.rating
                              .toString()),
                          itemCount: 5,
                          itemSize: responsive.setWidth(8),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                width: responsive.setWidth(100),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: "About",
                            clr: Colors.black,
                            size: 16,
                          ),
                          MyElevatedButton(
                            height: responsive.setHeight(6),
                            width: responsive.setWidth(30),
                            title: controller.user.value.result!.userType ==
                                    "petfinder"
                                ? 'Request '
                                : "Add Pet",
                            bgColor: colors.secondaryColor,
                            horPadding: 0,
                            onTap: () async {
                              if (controller.user.value.result!.userType ==
                                  "petfinder") {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        content: PetRequestPopup(),
                                      );
                                    });
                              } else {
                                ShelterPetInformationController controller =
                                    Get.put(ShelterPetInformationController());
                                await controller.getRecentPets();

                                Get.toNamed('/petInformation');
                              }
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print(mapControler
                              .currentPinInfo!.value.shelterGallery![0].path
                              .toString());
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: responsive.setHeight(2)),
                          child: MyText(
                            title:
                                mapControler.currentPinInfo!.value.description!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(15),
                        child: Obx(()=>
                          mapControler
                                      .currentPinInfo!.value.shelterGallery !=
                                  null
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mapControler.currentPinInfo!.value
                                      .shelterGallery!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          ImagePreview(
                                            thumbnail: mapControler
                                                .currentPinInfo!
                                                .value
                                                .shelterGallery![index]
                                                .thumbnail,
                                            network: APIEndpoints.baseURL +
                                                mapControler.currentPinInfo!.value
                                                    .shelterGallery![index].path!,
                                          ),
                                          isScrollControlled: true,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            right: responsive.setWidth(1)),
                                        height: responsive.setHeight(12),
                                        width: responsive.setHeight(12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: (mapControler.currentPinInfo!
                                                          .value.shelterGallery !=
                                                      null &&
                                                  mapControler
                                                      .currentPinInfo!
                                                      .value
                                                      .shelterGallery!
                                                      .isNotEmpty)
                                              ? mapControler
                                                          .currentPinInfo!
                                                          .value
                                                          .shelterGallery![index]
                                                          .thumbnail !=
                                                      null
                                                  ? FadeInImage(
                                                      image: FileImage(
                                                          mapControler
                                                              .currentPinInfo!
                                                              .value
                                                              .shelterGallery![
                                                                  index]
                                                              .thumbnail!),
                                                      placeholder: AssetImage(
                                                          ImagePath
                                                              .loaderGifImage),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FadeInImage(
                                                      image: NetworkImage(
                                                          APIEndpoints.baseURL +
                                                              mapControler
                                                                  .currentPinInfo!
                                                                  .value
                                                                  .shelterGallery![
                                                                      index]
                                                                  .path!),
                                                      fit: BoxFit.cover,
                                                      placeholder: AssetImage(
                                                          ImagePath.loaderGifImage))
                                              : Image.asset(
                                                  ImagePath.noImageFound,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: MyText(
                                    title: 'No Pictures',
                                    size: responsive.setTextScale(18),
                                    clr: colors.gray,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: "Area Capacity for pet living ",
                            clr: colors.gray,
                            size: 16,
                          ),
                          MyText(
                            title: mapControler
                                        .currentPinInfo!.value.areaCapacity ==
                                    "N/A"
                                ? 'N/A'
                                : ' ${mapControler.currentPinInfo!.value.areaCapacity} +',
                            size: 16,
                            clr: colors.gray,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: "Available Pets",
                            clr: colors.gray,
                            size: 16,
                          ),
                          MyText(
                            title: mapControler.pet.value.result != null
                                ? ' ${mapControler.pet.value.result!.length} +'
                                : '0',
                            size: 16,
                            clr: colors.gray,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.setHeight(2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: "Satisfied Clients",
                            clr: colors.gray,
                            size: 16,
                          ),
                          MyText(
                            title:
                                "${mapControler.currentPinInfo!.value.satisfiedClients} +",
                            size: 16,
                            clr: colors.gray,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.setHeight(4),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          title: "Pets",
                          clr: Colors.black,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        height: responsive.setHeight(4),
                      ),
                      Obx(()=>
                      mapControler.pet.value.result != null
                            ? mapControler.pet.value.result!.length != 0
                                ? GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio:
                                                responsive.setWidth(0.19),
                                            crossAxisCount: 3),
                                    // scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        mapControler.pet.value.result!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return PetTile(
                                          width: 30,
                                          height: 15,
                                          index: index,
                                          pet: mapControler
                                              .pet.value.result![index].obs);
                                    })
                                : Container()
                            : Container(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

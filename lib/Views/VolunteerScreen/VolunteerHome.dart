import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/chat_controller.dart';
import 'package:pawndr/Controller/map_controller.dart';
import 'package:pawndr/Controller/selection_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseComponent/CustomSettingContainer.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/map_view.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:pawndr/Views/widgets/user_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerHome extends StatelessWidget {
  UserController controller = Get.find();
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  MapControler mapControler = Get.put(MapControler());
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle3: true,
      showCircle1: false,
      showAppBar: false,
      showCircle4: true,
      child: Obx(
            () =>
        controller.user.value.result != null
            ? Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: responsive.setHeight(25)),
                height: responsive.setHeight(100),
                child: MapView(
                  lat: 24.8607,
                  long: 67.0011,
                )),
            Container(
              height: responsive.setHeight(30),
              width: responsive.setWidth(100),
              decoration: BoxDecoration(
                  color: colors.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            Positioned(
                top: -responsive.setHeight(4),
                left: responsive.setWidth(70),
                child: Container(
                  height: responsive.setHeight(20),
                  width: responsive.setHeight(20),
                  decoration: BoxDecoration(
                      color: colors.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                )),
            Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                top: responsive.setHeight(2),
                right: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [ProfileImage(), UserLocation()],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, top: responsive.setHeight(3)),
                    child: MyText(
                      title:
                      'Hey ${controller.user.value.result!.name!},',
                      size: responsive.setTextScale(18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: MyText(
                      title: 'Find the shelter you\'d like to serve.',
                      size: responsive.setTextScale(14),
                      clr: colors.gray,
                      toverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: responsive.setHeight(7),
                  ),
                  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: MyTextField(
                        showBar: false,
                        borderColor: Colors.transparent,
                        prefixIconData: Icons.search,
                        prefixIconColor: colors.primaryColor,
                        hintText: 'Search your shelter',
                        hintTextColor: colors.hintColor,
                        suffixFaIconData: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FaIcon(
                            FontAwesomeIcons.slidersH,
                            color: colors.primaryColor,
                          ),
                        ),
                        onTapSuffixFaIcon: () {
                          Get.toNamed("/shelterPetPictureUpload");
                        },
                      )),
                ],
              ),
            ),
            mapControler.showInfo.isTrue
                ? Positioned(
              bottom: responsive.setHeight(5),
              child: GestureDetector(
                onTap: () async {
                  Get.toNamed("/shelterDetail");
                },
                child: Container(
                  margin:
                  EdgeInsets.only(left: responsive.setWidth(4)),
                  padding: EdgeInsets.all(responsive.setHeight(2)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.gray.withOpacity(0.4)),
                  width: responsive.setWidth(92),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: responsive.setWidth(11),
                            height: responsive.setWidth(11),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              image: (mapControler
                                  .currentPinInfo!
                                  .value
                                  .shelterGallery !=
                                  null &&
                                  mapControler
                                      .currentPinInfo!
                                      .value
                                      .shelterGallery!
                                      .isNotEmpty)
                                  ? mapControler
                                  .currentPinInfo!
                                  .value
                                  .shelterGallery!
                                  .last
                                  .thumbnail !=
                                  null
                                  ? DecorationImage(
                                  image: FileImage(
                                      mapControler
                                          .currentPinInfo!
                                          .value
                                          .shelterGallery!
                                          .last
                                          .thumbnail!),
                                  fit: BoxFit.cover)
                                  : DecorationImage(
                                  image:
                                  NetworkImage(APIEndpoints.baseURL +
                                      mapControler.currentPinInfo!.value
                                          .shelterGallery!.last.path!),
                                  fit: BoxFit.cover)
                                  : DecorationImage(image: AssetImage(
                                  'assets/pets/shelterPet3.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: responsive.setWidth(2),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              MyText(
                                title: mapControler
                                    .currentPinInfo!.value.name!,
                                size: 14,
                                clr: colors.whiteColor,
                                weight: "Bold",
                              ),
                              RatingBarIndicator(
                                rating: 4,
                                itemCount: 5,
                                itemSize: 10.0,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, _) =>
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                              ),
                              SizedBox(
                                width: responsive.setWidth(70),
                                child: MyText(
                                  title: mapControler
                                      .currentPinInfo!
                                      .value
                                      .description!,
                                  line: 2,
                                  size: 12,
                                  clr: colors.whiteColor,
                                  toverflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(thickness: 1, color: colors.gray),
                      Row(
                        children: [
                          Wrap(
                            children: [
                              Container(
                                height: responsive.setHeight(5),
                                width: responsive.setHeight(5),
                                decoration: BoxDecoration(
                                    color: colors.primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                padding: EdgeInsets.all(
                                    responsive.setHeight(1)),
                                child: GestureDetector(
                                    onTap: () {
                                      mapControler.makePhoneCall(
                                          "tel:${mapControler.currentPinInfo!
                                              .value.phone!}");
                                    },
                                    child: Icon(
                                      Icons.phone,
                                      color: colors.whiteColor,
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  chatController.chatWithAUser(
                                      mapControler.currentPinInfo!
                                          .value.id);
                                  print("check");
                                  print(mapControler.currentPinInfo!.value.id);
                                  print(mapControler.currentPinInfo!.value.name);


                                    chatController.currentUser.value.user!.id = mapControler.currentPinInfo!.value.id;
                                    chatController.currentUser.value.user!.name = mapControler.currentPinInfo!.value.name;
                                    chatController.currentUser.value.user!.phone = int.parse(mapControler.currentPinInfo!.value.phone.toString());
                                  print(chatController.currentUser.value.user!.id);
                                  print(chatController.currentUser.value.user!.name);
                                  print(chatController.currentUser.value.user!.phone);
                                  // chatController.currentUser.value.user!.email = mapControler.currentPinInfo!.value.;
                                  // chatController.currentUser.value.user!.status = mapControler.currentPinInfo!.value.;
                                  // controller.chatEventsListening();
                                  // Get.toNamed('/chatingScreen');
                                },
                                child: Container(
                                  height: responsive.setHeight(5),
                                  width: responsive.setHeight(5),
                                  decoration: BoxDecoration(
                                      color: colors.primaryColor,
                                      borderRadius:
                                      BorderRadius.circular(
                                          10)),
                                  padding: EdgeInsets.all(
                                      responsive.setHeight(1)),
                                  child: FaIcon(
                                      FontAwesomeIcons.comment,
                                      color: colors.whiteColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: responsive.setWidth(12),
                          ),
                          Wrap(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: colors.primaryColor,
                                size: responsive.setWidth(8),
                              ),
                              SizedBox(
                                  width: responsive.setWidth(38),
                                  child: MyText(
                                    title: mapControler
                                        .currentPinInfo!
                                        .value
                                        .city! +
                                        " " +
                                        mapControler.currentPinInfo!
                                            .value.state! +
                                        " " +
                                        mapControler.currentPinInfo!
                                            .value.country!,
                                    line: 2,
                                    toverflow:
                                    TextOverflow.ellipsis,
                                    clr: colors.whiteColor,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
                : Container()
          ],
        )
            : Container(),
      ),
    );
  }
}

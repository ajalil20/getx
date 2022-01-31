import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/map_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseComponent/CustomSettingContainer.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';
import 'package:pawndr/Views/widgets/user_location.dart';

class VolunteerInformation extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController controller =Get.find();
  MapControler mapControler = Get.put(MapControler());


  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return DoubleBack(
      message: "Press back again to close",
      child: BaseView(
          showAppBar: false,
          showCircle2: false,
          child: Obx(()=>
          controller.user.value.result  !=null?
              Column(
              children: [
                 Row(
                  children: [
                    Container(
                      width: responsive.setWidth(70),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              padding: const EdgeInsets.only(left: 8.0),
                              child: MyText(
                                title: 'Hey ${controller.user.value.result!.name!}! what you looking for?',
                                size: responsive.setTextScale(18),
                                line: 2,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            hintText: 'Select the most popular shelters',
                            hintTextColor: colors.hintColor,
                            suffixFaIconData: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FaIcon(
                                FontAwesomeIcons.slidersH,
                                color: colors.primaryColor,
                              ),
                            ),
                          )),
                          Padding(
                                padding:  EdgeInsets.symmetric(vertical: responsive.setHeight(1)),
                                child: CustomSettingContainer(
                                  tabName: "Name",


                                  path: "",
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: responsive.setHeight(1)),
                                child: CustomSettingContainer(
                                  tabName: "Age",


                                  path: "",
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: responsive.setHeight(1)),
                                child: CustomSettingContainer(
                                  tabName: "Occupation",


                                  path: "",
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical:responsive.setHeight(1) ),
                                child: CustomSettingContainer(
                                  tabName: "Interest",


                                  path: "",
                                ),
                              ),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyElevatedButton(
                                height: responsive.setHeight(6),
                                width: responsive.setWidth(52),
                                title: 'Attach Picture',
                                bgColor: colors.secondaryColor,

                                isIcon: true,

                                onTap: () {
                                  // Get.toNamed('/petProfile');
                                },
                              ),
                              MyElevatedButton(
                                onTap: (){
                                  Get.toNamed("/volunteerHome");
                                },
                                height: responsive.setHeight(6),
                                width: responsive.setWidth(30),
                                title: 'Save',
                                bgColor: colors.primaryColor,
                                isImage: true,
                                imageColor: colors.blackColor.withOpacity(0.3),
                              )
                            ],
                          ),


                                   ],
                  ),
                ),
              ],
            ) : Container(),
          )),
    );
  }
}

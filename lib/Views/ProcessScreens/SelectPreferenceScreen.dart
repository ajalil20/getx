// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_circlewithicon.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/selection_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class SelectPreferenceScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  SelectionController selectionController = Get.put(SelectionController());
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showDrawer: false,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: responsive.setHeight(7),
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: responsive.setWidth(40),
              ),
            ),
            SizedBox(
              height: responsive.setHeight(3),
            ),
            MyText(
              title: '${TextConstant.en['SelectionPreference']['Heading']}',
              weight: 'Semi Bold',
              size: 20,
              clr: Color(0xff3E3E3E),
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      selectionController.SelectPreference('shelter');
                    },
                    child: Container(
                      height: responsive.setHeight(25),
                      width: responsive.setWidth(100),
                      child: Card(
                        color: Color(0xffFFEBF1),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: MyText(
                                title:
                                    '${TextConstant.en['SelectionPreference']['Shelter']}',
                                size: responsive.setTextScale(29),
                                center: true,
                                weight: 'Bold',
                                clr: colors.secondaryColor,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/shelter.png',
                                width: responsive.setWidth(40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                      visible: selectionController.shelter.value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleWithIcon(
                            height: responsive.setHeight(4),
                            width: responsive.setHeight(4),
                            bgColor: colors.primaryColor,
                            icon: Icon(
                              Icons.check,
                              color: colors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      selectionController.SelectPreference('finder');
                    },
                    child: Container(
                      height: responsive.setHeight(25),
                      width: responsive.setWidth(100),
                      child: Card(
                        color: Color(0xffE9E9E9),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/finder.png',
                                width: responsive.setWidth(40),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: MyText(
                                title:
                                    '${TextConstant.en['SelectionPreference']['Finder']}    ',
                                size: responsive.setTextScale(30),
                                center: true,
                                weight: 'Bold',
                                clr: colors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                      visible: selectionController.finder.value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleWithIcon(
                            height: responsive.setHeight(4),
                            width: responsive.setHeight(4),
                            bgColor: colors.primaryColor,
                            icon: Icon(
                              Icons.check,
                              color: colors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

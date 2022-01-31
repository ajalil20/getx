import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_circlewithicon.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/selection_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
class SplashScreen1 extends StatelessWidget {
   SelectionController selectionController = Get.put(SelectionController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showDrawer: false,
      showAppBar: false,
        showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          
          Padding(
            padding:  EdgeInsets.only(left: responsive.setWidth(4),top: responsive.setHeight(3),bottom: responsive.setHeight(2)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                title: '${TextConstant.en['SelectionPreference']['Heading']}',
                weight: 'Semi Bold',
                size: 20,
                clr: Color(0xff3E3E3E),
              ),
            ),
          ),
         
        Row(children: [
            Expanded(
              child:Column(children: [
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
                   
                      child: Card(
                        color: Color(0xffFFEBF1),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          'assets/images/shelter.png',
                          width: responsive.setWidth(40),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                      visible: selectionController.shelter.value,
                      child: Positioned(
                        right: 0,
                        top: 0,
                        child: CircleWithIcon(
                          height: responsive.setHeight(3),
                          width: responsive.setHeight(3),
                          bgColor: colors.primaryColor,
                          icon: Icon(
                            Icons.check,
                            color: colors.whiteColor,
                            size: 12,
                          ),
                        ),
                      ),
                    )),
              ],
          ),
           MyText(
                              title:
                                  '${TextConstant.en['SelectionPreference']['Shelter']}',
                              size: 14,
                              center: true,
                              weight: 'Bold',
                              clr: colors.hintColor,
                            ),
              ],),
            ),
             Expanded(
               child: Column(children: [
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
                     
                      child: Card(
                        color: Color(0xffE9E9E9),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          'assets/images/finder.png',
                          width: responsive.setWidth(40),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                      visible: selectionController.finder.value,
                      child: Positioned(
                        right: 0,
                        top: 0,
                        child: CircleWithIcon(
                          height: responsive.setHeight(3),
                          width: responsive.setHeight(3),
                          bgColor: colors.primaryColor,
                          icon: Icon(
                            Icons.check,
                            color: colors.whiteColor,
                            size: 12,
                          ),
                        ),
                      ),
                    )),
            ],
          ),
           MyText(
                              title:
                                  '${TextConstant.en['SelectionPreference']['Finder']}',
                              size: 14,
                              center: true,
                              weight: 'Bold',
                              clr: colors.hintColor,
                            ),
               ],)
             ),
        ],),
         SizedBox(
            height: responsive.setHeight(1),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(ImagePath.leftSideDog,height: responsive.setHeight(20),width: responsive.setWidth(40),fit: BoxFit.fill,)),
        SizedBox(
            height: responsive.setHeight(1),
          ),
        MyElevatedButton(
            onTap: () {
              Get.toNamed('/volunteerInformation');
            },
            height: responsive.setHeight(7.5),
            width: responsive.setWidth(78),
            title: '${TextConstant.en['GetStart']['GetStarted']}',
            textColor: colors.whiteColor,
            bgColor: colors.primaryColor,
            isImage: true,
            imageColor: colors.blackColor.withOpacity(0.3),
          ),   
         
        ],
      ),
    );
  }
}
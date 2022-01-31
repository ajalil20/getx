import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/help_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class HelpScreen extends StatelessWidget {
  HelpController helpController = Get.put(HelpController());
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      align1Top: 67,
      align1Bottom: 83,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: true,
      screenNamee: 'Help',
      titleFontSize: responsive.setTextScale(20),
      titleClr: colors.blackColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: responsive.setHeight(2),horizontal: responsive.setWidth(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: responsive.setHeight(3),
            ),
            MyText(
              title: 'Frequently Asked Questions',
              clr: colors.blackColor,
              size: responsive.setTextScale(16),
              weight: 'Semi Bold',
            ),
            SizedBox(
              height: responsive.setHeight(2),
            ),
            Obx(()=> helpController.res.value.result ==null? Container():
            Expanded(
                child: ListView.builder(
                    itemCount: helpController.res.value.result!.length,
                    itemBuilder: (BuildContext, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: GestureDetector(
                          onTap: (){
                            helpController.selectedIndex.value = index;
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical:responsive.setHeight(2.8),horizontal: responsive.setWidth(4) ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(()=>MyText(
                                      title:
                                          '${helpController.res.value.result![index].question}',
                                      clr: helpController.selectedIndex.value==index?colors.secondaryColor:colors.helpColor,
                                      size: responsive.setTextScale(15),
                                      weight: 'Bold',
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: responsive.setHeight(1.3),
                                  // ),
                                  Obx(()=>helpController.selectedIndex == index? Padding(
                                    padding: EdgeInsets.symmetric(vertical:responsive.setHeight(1.3) ),
                                    child: MyText(
                                        title: '${helpController.res.value.result![index].answer}',
                                        size: responsive.setTextScale(14),
                                        clr: colors.helpColor,
                                      ),
                                  ):Container(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

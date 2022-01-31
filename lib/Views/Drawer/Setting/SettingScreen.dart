import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/setting_screens_controller.dart';
import 'package:pawndr/Views/BaseScreens/BaseComponent/CustomSettingContainer.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class SettingScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  SettingScreenController cont = Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);

    return BaseView(
      screenNamee: 'Settings',
      showBottomBar: false,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      titleClr: colors.blackColor,
      titleWeight: 'Semi Bold',
      titleFontSize: responsive.setTextScale(20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: responsive.setHeight(12),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: cont.itemData.length,
                        itemBuilder: (BuildContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomSettingContainer(
                              tabName: cont.itemData[index].tabName,
                              icon: cont.itemData[index].iconData,
                              isWidget: cont.itemData[index].isWidget,
                              path: cont.itemData[index].route,
                            ),
                          );
                        }))
              ],
            ),
          ),
          Positioned(
            top: responsive.setHeight(57),
            child: Image.asset('assets/icons/dohleftside.png'),
          ),
        ],
      ),
    );
  }
}

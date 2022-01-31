import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/setting_screens_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSettingContainer extends StatelessWidget {
  CustomSettingContainer({this.tabName,this.icon,this.path,this.isWidget,this.child,this.height=7});
  final IconData? icon;
  final String? path;
  final String? tabName;
  final bool? isWidget;
  final Widget? child;
  int? height;

  SettingScreenController settingScreenController = Get.put(SettingScreenController());


  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return     GestureDetector(
      onTap: (){
        print('arso');
        print('/$path');
        print('arso');
        if(path!=null) {
          Get.toNamed('/$path');
        }
      },
      child: Container(
        height: responsive.setHeight(height??7),
        width: responsive.setWidth(100),
        decoration: BoxDecoration(
          color: colors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child:
        child == null?
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon,color: colors.hintColor,size: responsive.setWidth(7),),
                    SizedBox(width:7,),
                    MyText(
                      title: '${tabName}',
                      clr: colors.hintColor,
                    )
                  ],
                ),
                isWidget != true || isWidget == null?Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: colors.hintColor,
                  size: 15,
                ):Obx(()=> FlutterSwitch(
                    width: 60.0,
                    height: 30.0,
                    valueFontSize: 12.0,
                    toggleSize: 25.0,
                    value: settingScreenController.NotificationStatus.value,
                    borderRadius: 30.0,
                    toggleColor: colors.secondaryColor,
                    padding: 3.0,
                    activeColor: colors.hintColor.withOpacity(0.5),
                    showOnOff: true,
                    onToggle: (val) {
                      // settingScreenController.NotificationStatus.value = !settingScreenController.NotificationStatus.value;
                      settingScreenController.updateStatus(context, val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ): child,
      ),
    );
  }
}

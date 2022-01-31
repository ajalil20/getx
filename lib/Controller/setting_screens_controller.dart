import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Controller/notification_coltroller.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Controller/signInController.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_controller.dart';
 ShelterHomeController shelterHomeController =Get.put(ShelterHomeController());
class SettingScreenController extends GetxController {
  static ChatController controller = Get.find();

  RxBool deleteAccount = false.obs;
  RxBool close = false.obs;
  RxInt selectedIndex = 20.obs;
  RxBool NotificationStatus = false.obs;

  List<DrawerListModel> items = [
    DrawerListModel('Notificaton', '/notification',(){
       NotificationController controller = Get.put(NotificationController());
       controller.getUserNotification(true);
    }),
    DrawerListModel('Shelter', '/shelter',()async{
      shelterHomeController.loading.value=true;
     await shelterHomeController.getData();
    }),
    DrawerListModel('Chat', '/chat',()async{
      controller.chatList();
    }),
    DrawerListModel('Favorites', '/favorite',(){}),
    DrawerListModel('Order History', '/orderHistory',(){}),
    DrawerListModel('Help', '/help',(){}),
    DrawerListModel('Terms & Conditions', '/terms',(){}),
    DrawerListModel('Setting', '/setting',(){}),
  ];

  List<SettingScreensModel> itemData = [
    SettingScreensModel(
        iconData: Icons.manage_accounts_outlined,
        tabName: 'Profile Setting',
        isWidget: false,route:'profileSetting'),
    SettingScreensModel(
        iconData: Icons.tune_outlined, tabName: 'Perfernce', isWidget: false),
    SettingScreensModel(
        iconData: Icons.credit_card_outlined,
        tabName: 'Payment Settings',
        isWidget: false),
    SettingScreensModel(
        iconData: Icons.notifications_active_outlined,
        tabName: 'Notifications',
        isWidget: true),
    SettingScreensModel(
        iconData: Icons.system_update_outlined,
        tabName: 'Updates',
        isWidget: false),
  ];

  void SelectedItem(String) {}

  void getNotificationStatus()async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    NotificationStatus.value =(await storage.getBool(LocalDBKeys.ACTIVENOTIFICTION))!;
    print('arso status ya hai ''${NotificationStatus.value}');
  }

  void updateStatus(context,val)async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    LoginController profileController = Get.put(LoginController());
    storage.setBool(LocalDBKeys.ACTIVENOTIFICTION, val);
    getNotificationStatus();
    if(val == false){
      profileController.registerDeviceNotification(context,token: 0);
    }else{
      profileController.registerDeviceNotification(context,token: 1);
    }
  }


}

class DrawerListModel {
  DrawerListModel(this.name, this.path,this.onTap);
  String? name;
  String? path;
  Function? onTap;
}

class SettingScreensModel {
  SettingScreensModel(
      {@required this.iconData,
      @required this.tabName,
      this.isWidget,
      this.route});

  IconData? iconData;
  String? tabName;
  bool? isWidget;
  String? route;
}

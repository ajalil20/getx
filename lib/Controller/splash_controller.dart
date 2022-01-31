import 'dart:async';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pawndr/Controller/user_controller.dart';
import '../Utils/local_db_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'chat_controller.dart';
import 'finderhome_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    navigateToNextPage();
    pushNotification();
  }

  void navigateToNextPage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? rem = storage.getString(LocalDBKeys.ISREMEMBER);
    String? id = storage.getString(LocalDBKeys.USERID);
    String? token = storage.getString(LocalDBKeys.TOKEN);
    String? user = storage.getString(LocalDBKeys.SELECTPREF);

    if (token != null && id != null && user != null && rem =="true") {
      if(user=="petfinder") {
       Get.offAllNamed('/finderHome');
        EasyLoading.show(status: "Please wait...");
       UserController controller =Get.put(UserController());
       FinderHomeController finderHomeController = Get.put(FinderHomeController());
       await controller.getUser(false);
       await finderHomeController.getData(false);
       ChatController chatController = Get.put(ChatController());
       EasyLoading.dismiss();
     }
      else if(user=="volunteershelter") {
       Get.offAllNamed('/volunteerHome');
       EasyLoading.show(status: "Please wait...");
       UserController controller =Get.put(UserController());
       FinderHomeController finderHomeController = Get.put(FinderHomeController());
       await controller.getUser(false);
       await finderHomeController.getData(true);
       ChatController chatController = Get.put(ChatController());
      }
      else{log("User not found");startTimer();}
     // Get.toNamed("/login");
    } else {
      startTimer();
      // Get.offNamed("/login");
    }
  }
  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed("/intro");
    });
  }
  Future<void> pushNotification() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? notificationToken = storage.getString(LocalDBKeys.NOTIFICATIONTOKEN);

    FirebaseMessaging messaging= FirebaseMessaging.instance;
  // messaging.subscribeToTopic("dolphin");
  messaging.getToken().then((value) {
    print("User token is");
    print(value);
    storage.setString(LocalDBKeys.NOTIFICATIONTOKEN,value!);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print(event.notification!.body);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });}
}

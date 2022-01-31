import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pawndr/Controller/shelterhome_controller.dart';
import 'package:pawndr/Modals/signup_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';
import 'package:pawndr/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionController extends GetxController {
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  RxBool shelter = false.obs;
  RxBool finder = false.obs;
  // ShelterHomeController shelterHomeController = Get.put(ShelterHomeController());

  void SelectPreference(String val) async {
    if (val == 'shelter') {
      finder.value = false;
      shelter.value = true;
      Timer(Duration(milliseconds: 300), () {
        // shelterHomeController.getData();
        Get.toNamed('/shelter');
      });
    } else {
      shelter.value = false;
      finder.value = true;
      Timer(Duration(milliseconds: 100), () {
        Get.toNamed('/finderHome');
      });
    }
  }
}



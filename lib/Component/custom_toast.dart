import 'package:get/get.dart';
import '../Utils/color_config.dart';

class CustomToast{
  ColorConfig colors=ColorConfig();
  void showToast(String title,String body,bool error){
    Get.showSnackbar(GetBar(
      title: title,
      message: body,
      backgroundColor: error?colors.errorColor:colors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    ));
  }

}
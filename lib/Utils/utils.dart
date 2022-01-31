
import 'package:connectivity/connectivity.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import '../Component/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_db_keys.dart';

class Utils{

  static bool validateEmail(String email){
    if(email.isEmpty){
      CustomToast().showToast("Warning", "Email can not be empty", true);
      return false;
    }else if(!email.isEmail){
      CustomToast().showToast("Error", "Email format is not correct", true);
      return false;
    }
    return true;
  }

  static bool validatePassword(String password){
    if(password.isEmpty){
      CustomToast().showToast("Warning", "Password can not be empty", true);
      return false;
    }else if(password.length<8){
      CustomToast().showToast("Error", "Password must be 8 characters long", true);
      return false;
    }
    return true;
  }

  static Future<void> clearLocalStorage() async {
    SharedPreferences storage=await SharedPreferences.getInstance();
    storage.clear();
  }

  static Future<Map> getUserInfo() async {
    SharedPreferences storage=await SharedPreferences.getInstance();
    bool? rem=storage.getBool(LocalDBKeys.ISREMEMBER);
    String? id=storage.getString(LocalDBKeys.USERID);
    String? token=storage.getString(LocalDBKeys.TOKEN);
    String? username=storage.getString(LocalDBKeys.USERNAME);

    return {
      "username": username,
      "token": token,
      "id": id,
      "remember":rem
    };
  }
  static Future<bool> checkInternetConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      CustomToast().showToast("Error", "Please check your internet connection", true);
      return false;
    }
    return true;
  }
}
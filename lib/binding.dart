import 'package:get/get.dart';
import 'package:pawndr/Controller/user_controller.dart';

class UserBinding extends Bindings{
  @override
  void dependencies() {
    // Get.put(UserController());
    Get.lazyPut<UserController>(()=>UserController());
  }
}
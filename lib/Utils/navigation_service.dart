
import 'package:get/get.dart';

class NavigationService {

  Future<dynamic>? navigateTo(String routeName) {
    return Get.rootController.key.currentState!.pushNamed(routeName);
  }

  goBack() {
    return Get.rootController.key.currentState!.pop();
  }
}
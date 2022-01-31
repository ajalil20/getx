import 'package:get/get.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/notificaiton_model.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';

class NotificationController extends GetxController {
  UserController controller = Get.put(UserController());
  Rx<NotificationModel> notification = NotificationModel().obs;
  BaseService baseService = BaseService();

  Future<void> getUserNotification (isLoading) async {
    Map jsondata = {"user_id": controller.user.value.result!.id};
    notification.value = await NotificationModel.fromJson(await baseService.basePostAPI(
      APIEndpoints.getUserNotifications,
      jsondata,
      loading: isLoading,
    ));

  }

}


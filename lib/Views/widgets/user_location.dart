import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:photo_view/photo_view.dart';

import 'image_preview.dart';

class UserLocation extends StatelessWidget {
  HomeController _controller= Get.put(HomeController());
  ProfileSettingController profileSettingController = Get.put(ProfileSettingController());
  double size;
  UserLocation({this.size=2});
  UserController controller = Get.put(UserController());


  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return InkWell(
      onTap: (){

        profileSettingController.determinePosition(context);
        print("Abnder ha"+controller.user.value.result!.locationName!);

      controller.user.refresh();
      },
      child: controller.user.value.result == null? Container():Padding(
        padding: EdgeInsets.only(left: responsive.setWidth(1.5)),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              width:responsive.setWidth(45),
              child: MyText(
                title:
                " ${controller.user.value.result!.name }",
                size:
                responsive.setTextScale(15),
                // weight: 'Semi Bold',
                toverflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: colors.primaryColor,
                  size:
                  responsive.setWidth(5),
                ),
                Container(
                  width:responsive.setWidth(45),
                  child: MyText(
                    title: controller.user.value
                        .result!.locationName!,
                    clr: colors.secondaryColor,
                    toverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

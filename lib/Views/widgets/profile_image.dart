import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:photo_view/photo_view.dart';

import 'image_preview.dart';

class ProfileImage extends StatelessWidget {
  double size;
  ProfileImage({this.size = 2});
  UserController controller = Get.put(UserController());

  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return controller.user.value.result == null
        ? MyCircleImage(
            imgPath: 'assets/users/userImage.png',
            borderColor: Colors.transparent,
            size: responsive.setWidth(size),
          )
        : GestureDetector(
            onTap: () {
              Get.bottomSheet(
                ImagePreview(
                  network:(controller.user.value.result!.profileImage!=null)? APIEndpoints.baseURL + controller.user.value.result!.profileImage.toString():null,
                  asset: (controller.user.value.result!.profileImage==null)
                      ? 'assets/users/userImage.png'
                      : null,
                ),
                isScrollControlled: true,
              );
            },
            child: controller.user.value.result!.profileImage == null
                ?
            // MyCircleImage(
            //         imgPath: 'assets/users/userImage.png',
            //         borderColor: Colors.transparent,
            //         size: responsive.setWidth(size),
            //       )
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: responsive.setWidth(size + 14),
                height: responsive.setWidth(size + 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)),
                child: FadeInImage(
                  fit: BoxFit.contain,
                  width: responsive.setWidth(100),
                  image: AssetImage(
                      'assets/users/userImage.png'
                  ),
                  placeholder: AssetImage(ImagePath.loaderGifImage),
                ),
              ),
            )

        :
                // MyCircleImage(
                //   isNetworkImage: true,
                //   imgPath: APIEndpoints.baseURL + controller.user.value.result!.profileImage!,
                //   borderColor: Colors.transparent,
                //   size: responsive.setWidth(size),
                // ),

                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: responsive.setWidth(size + 14),
                      height: responsive.setWidth(size + 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: NetworkImage(
                          APIEndpoints.baseURL +
                              controller.user.value.result!.profileImage!,
                        ),
                        placeholder: AssetImage(ImagePath.loaderGifImage),
                      ),
                    ),
                  )
    );
  }
}

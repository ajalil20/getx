import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Modals/chat/souserschat_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';

class ChatTile extends StatelessWidget {
  Rx<SOUsersChatWithModel>? chat = SOUsersChatWithModel().obs;
  bool? active;

  ChatTile({this.active, this.chat});

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                ImagePreview(network: chat!.value.user!.profileImage !=null?  APIEndpoints.baseURL + chat!.value.user!.profileImage!:null,
                asset: chat!.value.user!.profileImage ==null? ImagePath.noUserImageFound:null,
                ),
                isScrollControlled: true,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: chat!.value.user != null ?
              chat!.value.user!.profileImage != null?
              FadeInImage(
                      fit: BoxFit.cover,
                      width: responsive.setWidth(14),
                      height: responsive.setWidth(14),
                      image: NetworkImage(
                        APIEndpoints.baseURL + chat!.value.user!.profileImage!,
                      ),
                      placeholder: AssetImage(ImagePath.loaderGifImage),
                    )
                  : Container(
                width: responsive.setWidth(14),
                height: responsive.setWidth(14),
                child: Image.asset(
                        ImagePath.noUserImageFound,
                        fit: BoxFit.contain,
                      ),
                  ): Container(
                width: responsive.setWidth(13),

                child: Image.asset(
                  ImagePath.noUserImageFound,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            width: responsive.setWidth(3),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                chat!.value.user!=null? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: chat!.value.user!.name!,
                        size: responsive.setTextScale(16),
                        weight: 'Bold',
                      ),
                      SizedBox(
                        height: responsive.setHeight(0.5),
                      ),
                      MyText(
                        title: chat!.value.chat!,
                        size: responsive.setTextScale(14),
                        clr: colors.hintColor,
                        line: 1,
                        toverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      MyText(
                        title: '09:00 Am',
                        clr: colors.hintColor,
                        size: responsive.setTextScale(12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (active == true)
                        Container(
                          height: responsive.setHeight(1.4),
                          width: responsive.setHeight(1.4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

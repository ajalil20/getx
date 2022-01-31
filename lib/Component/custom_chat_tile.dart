import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/chat_controller.dart';
import 'package:intl/intl.dart';
import 'package:pawndr/Modals/chat/ChatMessagesModel.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';

class CustomChatTile extends StatelessWidget {
  Rx<ChatMessages>? chat = ChatMessages().obs;
  ChatController controller = Get.find();
  final bool? selfMessage;

  CustomChatTile({this.selfMessage,this.chat});
  ColorConfig colors = ColorConfig();
  Responsive _responsive = Responsive();
  @override
  Widget build(BuildContext context) {
    _responsive.setContext(context);
    return selfMessage!=true?
   Obx(()=>
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.currentUser.value.user!.profileImage !=null?
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: _responsive.setWidth(12),
                  height: _responsive.setWidth(12),
                  image: NetworkImage(
                    APIEndpoints.baseURL + controller.currentUser.value.user!.profileImage!,
                  ),
                  placeholder: AssetImage(ImagePath.loaderGifImage),
                ),
              ):
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  ImagePath.noUserImageFound,
                  height: _responsive.setWidth(12),
                  width: _responsive.setWidth(12),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colors.containerChat),
                  child: MyText(
                    title:chat!.value.message!,
                    clr: colors.blackColor,
                  ),
                ),
              )
            ],
      ),
           Padding(
             padding: EdgeInsets.only(left: _responsive.setWidth(3),bottom: _responsive.setHeight(1),top:_responsive.setHeight(1), ),
             child: MyText(clr: colors.gray,title: chat!.value.createdDate=="N/A"?"N/A": DateFormat('kk:mm a, dd MMM').format(DateTime.parse(chat!.value.createdDate!)),center: false,size: _responsive.setTextScale(5),),
           ),
         ],
       ),
    )
    :Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colors.blueFb),
                child: MyText(
                  title:chat!.value.message!,
                  clr: colors.textColor,
                  line: null,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            controller.controller.user.value.result!.profileImage !=null?
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FadeInImage(
                fit: BoxFit.cover,
                width: _responsive.setWidth(12),
                height: _responsive.setWidth(12),
                image: NetworkImage(
                  APIEndpoints.baseURL + controller.controller.user.value.result!.profileImage!,
                ),
                placeholder: AssetImage(ImagePath.loaderGifImage),
              ),
            ):
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                ImagePath.noUserImageFound,
                height: _responsive.setWidth(12),
                width: _responsive.setWidth(12),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: _responsive.setWidth(3),bottom: _responsive.setHeight(1),top:_responsive.setHeight(1), ),
          child: MyText(clr: colors.gray,title: chat!.value.createdDate=="N/A"?"N/A": DateFormat('kk:mm a, dd MMM').format(DateTime.parse(chat!.value.createdDate!)),center: false,size: _responsive.setTextScale(5),),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_chat_tile.dart';
import 'package:intl/intl.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/chat_controller.dart';
import 'package:pawndr/Controller/chating_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';

class ChatingScreen extends StatelessWidget {
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  ChatController controller = Get.find();
  ChatingController chatingController = Get.put(ChatingController());
  UserController user = Get.find();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      align1Top: 67,
      align1Bottom: 83,
      showCircle2: false,
      showCircle3: false,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: false,
      child: Obx(()=> Column(
          children: [
            SizedBox(
              height: responsive.setHeight(1.5),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(4)),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(onTap:(){Get.back(); controller.chatList();},
                  child: Icon(
                    Icons.arrow_back,
                    color: colors.primaryColor,
                  ),
                ),
                SizedBox(
                  width: responsive.setWidth(5),
                ),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      ImagePreview(network: controller.currentUser.value.user!.profileImage !=null?  APIEndpoints.baseURL + controller.currentUser.value.user!.profileImage!:null,
                      asset: controller.currentUser.value.user!.profileImage !=null? ImagePath.noUserImageFound:null,
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: controller.currentUser.value.user != null
                        ? controller.currentUser.value.user!.profileImage != null ? FadeInImage(
                      fit: BoxFit.cover,
                      width: responsive.setWidth(14),
                      height: responsive.setWidth(14),
                      image: NetworkImage(
                        APIEndpoints.baseURL + controller.currentUser.value.user!.profileImage!,
                      ),
                      placeholder: AssetImage(ImagePath.loaderGifImage),
                    )
                        : Container(
                      width: responsive.setWidth(14),

                      child: Image.asset(
                        ImagePath.noUserImageFound,
                        fit: BoxFit.contain,
                      ),
                    ): Container(
                      width: responsive.setWidth(14),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: controller.currentUser.value.user!.name!,
                        size: responsive.setTextScale(16),
                        weight: 'Bold',
                        toverflow: TextOverflow.ellipsis,
                        line: 1,
                      ),
                      MyText(
                        title: controller.currentUser.value.user!.onlineStatus =='OFFLINE'?'':"Active",
                        clr: colors.hintColor,
                        size: responsive.setTextScale(12),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.call_outlined,
                  size: responsive.setTextScale(24),
                ),
                SizedBox(
                  width: responsive.setWidth(3),
                )
              ]),
            ),
            SizedBox(
              height: responsive.setHeight(2.5),
            ),
            Divider(
              color: colors.primaryColor,
              height: responsive.setHeight(0.08),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: responsive.setHeight(4),
                width: responsive.setWidth(8),
                decoration: BoxDecoration(
                    color: colors.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: colors.whiteColor,
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     child: ListView(
            //       children: [
            //         Obx(
            //               () => Column(
            //             crossAxisAlignment: chatingController.isMe == true
            //                 ? CrossAxisAlignment.start
            //                 : CrossAxisAlignment.end,
            //             children: [
            //               Material(
            //                 elevation: 5,
            //                 borderRadius: chatingController.isMe == true
            //                     ? BorderRadius.only(
            //                     bottomLeft: Radius.circular(10),
            //                     bottomRight: Radius.circular(10),
            //                     topLeft: Radius.circular(0),
            //                     topRight: Radius.circular(10))
            //                     : BorderRadius.only(
            //                     bottomLeft: Radius.circular(10),
            //                     bottomRight: Radius.circular(10),
            //                     topLeft: Radius.circular(10),
            //                     topRight: Radius.circular(0)),
            //                 color: chatingController.isMe == true
            //                     ? Colors.lightBlueAccent
            //                     : Colors.grey,
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
             Expanded(
              child:Padding(
                padding:  EdgeInsets.only(left:responsive.setWidth(5),right: responsive.setWidth(5)),
                child: ListView.separated(
                  controller: controller.scrollController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                  return CustomChatTile(selfMessage: controller.messagesList[index].senderId==user.user.value.result!.id,chat: controller.messagesList[index].obs,);
                }, separatorBuilder: (context,index){
                  return Container();
                }, itemCount: controller.messagesList.length)
              )),
            Container(
              height: responsive.setHeight(10),
              margin: EdgeInsets.only(left: responsive.setWidth(5),right:  responsive.setWidth(5)),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: MyTextField(
                        borderColor: Colors.transparent,
                      // prefixIconData: Icons.add,
                      prefixIconColor: colors.primaryColor,
                      boxShadow: true,
                      backgroundColor: colors.whiteColor,

                      hintText: "Write Something",
                      controller: controller.messageController.value,
                      // filed: false,w
                     horizontalPadding: 20,
                      suffixIconData:
                      // controller.voiceMessage.isTrue? Icons.mic:
                      Icons.send,
                      sufixIconColor: colors.primaryColor,
                      onTapSuffixIcon: () {
                          if(controller.messageController.value.text.isNotEmpty) {
                    controller.sendChatMessage(
                        controller.currentUser.value.user!.id!);
                  }
                },
                      onChanged: (val){ if (val.isNotEmpty) {
                        controller.voiceMessage.value = false;
                      } else {controller.voiceMessage.value = true;}},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}

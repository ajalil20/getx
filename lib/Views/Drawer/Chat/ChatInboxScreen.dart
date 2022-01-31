import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Component/custom_textfield.dart';
import 'package:pawndr/Controller/chat_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/Drawer/Chat/ChatTile.dart';
import 'package:pawndr/Views/Drawer/Notification/NotificationTile.dart';

class ChatInboxScreen extends StatelessWidget {
  ChatController controller = Get.put(ChatController());

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Obx(
      () => BaseView(
        showBottomBar: true,
        showAppBar: true,
        screenNamee: 'Chats ',
        titleWeight: 'Bold',
        titleClr: colors.blackColor,
        titleFontSize: responsive.setTextScale(20),
        showCircle2: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
              child: MyText(
                title: 'Search',
                weight: 'Bold',
                size: responsive.setTextScale(18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: MyTextField(
                  showBar: false,
                  borderColor: Colors.transparent,
                  prefixIconData: Icons.search,
                  prefixIconColor: colors.primaryColor,
                  hintText: 'Search users',
                  hintTextColor: colors.hintColor,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      controller.search.value = true;
                      controller.buildSearchList(val);
                    } else {
                      controller.search.value = false;
                      controller.temp.clear();
                    }
                  },
                ),
              ),
            ),
            controller.messages.isEmpty
                // || (controller.temp.isEmpty && controller.temp.length < 1)
                ? Center(
                    child: MyText(
                      title: 'No User Available',
                      size: responsive.setTextScale(16),
                      clr: colors.gray,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: (controller.temp.isNotEmpty && controller.temp.length > 0) ?
                            controller.temp.length : controller.search.isTrue?1
                          : controller.messages.length,
                      itemBuilder: (ctx, index) {
                        return (controller.temp.isNotEmpty &&
                                controller.temp.length > 0)
                            ? Slidable(
                                actionExtentRatio: 0.15,
                                child: InkWell(
                                    onTap: () {
                                      controller.chatWithAUser(
                                          controller.temp[index].user!.id);
                                      controller.currentUser.value =
                                          controller.temp[index];
                                      Get.toNamed('/chatingScreen');
                                    },
                                    child: ChatTile(
                                      active: controller.temp[index].user!.onlineStatus=="OFFLINE" ? false : true,
                                      chat: controller.temp[index].obs,
                                    )),
                                secondaryActions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      color: colors.errorColor,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        size: 30,
                                        color: colors.textColor,
                                      ),
                                    ),
                                  ),
                                ],
                                actionPane: SlidableDrawerActionPane(),
                              )
                            : controller.search.isTrue
                                ? Container(
                                    height: responsive.setHeight(50),
                                    child: Center(
                                      child: MyText(
                                        title: 'No user available',
                                        size: responsive.setTextScale(16),
                                        clr: colors.gray,
                                      ),
                                    ),
                                  )
                                : Slidable(
                                    actionExtentRatio: 0.15,
                                    child: InkWell(
                                        onTap: () {
                                          controller.chatWithAUser(controller.messages[index].user!.id);
                                          controller.currentUser.value = controller.messages[index];
                                          // controller.chatEventsListening();
                                          Get.toNamed('/chatingScreen');
                                        },
                                        child: ChatTile(
                                          active: controller.messages[index].user!=null? controller.messages[index].user!.onlineStatus=="OFFLINE" ? false : true:false,
                                          chat: controller.messages[index].obs,
                                        )),
                                    secondaryActions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          color: colors.errorColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.delete_forever_outlined,
                                            size: 30,
                                            color: colors.textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                    actionPane: SlidableDrawerActionPane(),
                                  );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(indent: responsive.setWidth(20));
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

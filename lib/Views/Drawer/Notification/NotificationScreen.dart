// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pawndr/Controller/notification_coltroller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/Drawer/Notification/NotificationTile.dart';

class NotificationScreen extends StatelessWidget {
  NotificationController controller = NotificationController();
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showBottomBar: true,
      showAppBar: true,
      screenNamee: 'Notification',
      titleWeight: 'Bold',
      titleClr: colors.blackColor,
      titleFontSize: responsive.setTextScale(20),
      showCircle2: false,
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (ctx,index){
          return Slidable(
            actionExtentRatio:0.15,
            child: NotificationTile(condition: index==0?null:index%2==0?0:1,),
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
        separatorBuilder: (ctx,index){
          return Divider(indent: responsive.setWidth(20));
        },
      ),
    );
  }
}

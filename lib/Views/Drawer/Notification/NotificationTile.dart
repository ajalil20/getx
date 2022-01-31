import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class NotificationTile extends StatelessWidget {
  NotificationTile({this.condition});

  final int? condition;

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          MyCircleImage(
            imgPath: 'assets/users/userImage.png',
            borderColor: Colors.transparent,
            size: responsive.setWidth(1.8),
          ),
          SizedBox(
            width: responsive.setWidth(3),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: 'Peter like your Laborador .'),
                    SizedBox(
                      height: responsive.setHeight(0.1),
                    ),
                    MyText(title: '15 hours ago'),
                  ],
                ),
                condition == null
                    ? Container()
                    : condition == 0
                        ? Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: responsive.setHeight(6),
                              width: responsive.setWidth(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage('assets/pets/forSheet.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : condition == 1
                            ? MyButton(
                              fontSize: responsive.setTextScale(15),
                                height: responsive.setHeight(4),
                                bgColor: colors.blackColor,
                                title: 'Accept',
                                onTap: () {
                                  print('arso');
                                },
                              )
                            : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

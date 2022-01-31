import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';

import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Modals/tags_model.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class CustomTagSelect extends StatelessWidget {
  final Tags? event;
  final int? type;
  CustomTagSelect({this.event, this.type});

   HomeController _homeController = Get.find();

  ColorConfig colors = ColorConfig();
  Responsive respons = Responsive();

  @override
  Widget build(BuildContext context) {
    respons.setContext(context);
    return InkWell(
      onTap: (){
        if(type==1){
            _homeController.setPetList(event);
        }else if(type==2){
          _homeController.setBreedList(event);
        }
        else if(type==3){
           _homeController.setCharList(event);
        } else if(type==4){
           _homeController.setColorList(event);
        }
        
      },
      child: Container(
        margin: EdgeInsets.all(respons.setWidth(1))+EdgeInsets.only(right: respons.setWidth(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              event!.selected! == true
                  ?  Icons.check_circle : Icons.circle_outlined,
              size: respons.setTextScale(16),
              color: event!.selected! == true
                  ? colors.primaryColor
                  : colors.whiteColor,
            ),
            SizedBox(
              width: respons.setWidth(2),

            ),
            MyText(
              title: '${event!.name}',
              size: respons.setTextScale(15),
              clr: colors.textColor,
            )
          ],
        ),
      ),
    );
  }
}

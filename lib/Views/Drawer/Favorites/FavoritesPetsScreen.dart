import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/favorite_tile.dart';

class FavoritePetsScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  FinderHomeController finderHomeController = Get.put(FinderHomeController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
        screenNamee: 'Favorites',
        showCircle2: false,
        titleClr: colors.blackColor,
        titleWeight: 'Semi Bold',
        titleFontSize: responsive.setTextScale(20),
        child: Obx(() =>
        finderHomeController.favorite.value.result!=null?
        finderHomeController.favorite.value.result!.isEmpty
            ? Center(
              child: MyText(
                title: 'No Favorites',
                size: responsive.setTextScale(18),
                clr: colors.gray,
              ),
            )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: finderHomeController.favorite.value.result!.length,
                itemBuilder: (context, index) {
                  return FavoriteTile(
                    index: index,
                    pet: finderHomeController.favorite.value.result![index].obs,
                  );
                }):Center(
          child: MyText(
            title: 'No Favorites',
            size: responsive.setTextScale(18),
            clr: colors.gray,
          ),
        ))
    );
  }
}

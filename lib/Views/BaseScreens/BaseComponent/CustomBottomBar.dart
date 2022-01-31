import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/BottomBarController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key}) : super(key: key);

  final BottomBarController controller = Get.put(BottomBarController());
  final ColorConfig colors = ColorConfig();
  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Obx(
      () => AnimatedBottomNavigationBar.builder(
        height: 75,
        itemCount: 4,
      
        elevation: 30,
      
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? colors.primaryColor : colors.hintColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                controller.images[index].image!,
                width: responsive.setWidth(controller.images[index].size!),
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MyText(
                  title: controller.data[index],
                  clr: colors.hintColor,
                  size: responsive.setTextScale(12),
                ),
              )
            ],
          );
        },
        // icons: controller.icons,
        // activeColor: colors.primaryColor,
        // inactiveColor: Color(0xff9C9C9C),
        activeIndex: controller.currentIndex.value,
        gapLocation: GapLocation.center,
        backgroundColor: colors.textColor,
        notchSmoothness: NotchSmoothness.sharpEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        onTap: (index) {
          controller.onTap(index, context);
        },
        //other params
      ),
    );
  }
}

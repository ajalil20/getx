// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/BottomBarController.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseComponent/CustomBottomBar.dart';
import 'package:pawndr/Views/Drawer/DrawerSideScreen.dart';

class BaseView extends StatelessWidget {
  final Color? bgColor, titleClr;
  final bool? showDrawer, showBackButton ;
  final String? screenNamee, titleWeight;
  final Widget? child;
  final bool? showBottomBar, showAppBar;
  final double? circle1Height,
      titleFontSize,
      circle1Width,
      circle2Height,
      circle2Width,
      circle3Height,
      circle3Width,
      circle4Height,
      circle4Width,
      align1Top,
      align1Bottom,
      align2Top,
      align2Bottom,
      align3Top,
      align3Bottom,
      align4Top,
      align4Bottom;
  final bool? showCircle1, showCircle2, showCircle3, showCircle4;
   Function? onTapBackButton;


  BaseView(
      {this.showAppBar,
      this.screenNamee,
      this.titleFontSize,
      this.titleClr,
      this.titleWeight,
      this.child,
        this.showDrawer,
        this.showBackButton,
      this.bgColor,
      this.showCircle1,
      this.showCircle2,
      this.showCircle3,
      this.showCircle4,
      this.circle1Height,
      this.circle1Width,
      this.circle2Height,
      this.circle2Width,
      this.circle3Height,
      this.circle3Width,
      this.circle4Height,
      this.circle4Width,
      this.align1Top,
      this.align1Bottom,
      this.align2Top,
      this.align2Bottom,
      this.align3Top,
      this.align3Bottom,
      this.align4Top,
      this.align4Bottom,
      this.showBottomBar,this.onTapBackButton

      });

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController controller =Get.put(UserController());
  BottomBarController bottomBarController = Get.put(BottomBarController());
  int currentIndex = 0;

  setBottomBarIndex(index) {
    currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:colors.primaryColor,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      floatingActionButton: showBottomBar != false
          ? FloatingActionButton(
              onPressed: () {
                if(controller.user.value.result!.userType=="petfinder") {
                  Get.toNamed('/finderHome');
                  bottomBarController.currentIndex=0.obs;
                } else if (controller.user.value.result!.userType=="volunteershelter") {
                  Get.toNamed('/volunteerHome');
                  bottomBarController.currentIndex=0.obs;
                }
              },
              backgroundColor: colors.primaryColor,
              child: Image.asset('assets/icons/drawerIcon.png',width: responsive.setWidth(8),)
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: showBottomBar != false ? CustomBottomBar() : null,
      appBar: showAppBar != false
          ? AppBar(
              elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              leading: showBackButton==false?Container() : GestureDetector(
                onTap: () {
                  Get.back();
                  onTapBackButton==null?print("s"): onTapBackButton!();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: colors.primaryColor,
                ),
              ),
              centerTitle: true,
              title: MyText(
                title: screenNamee ?? '',
                size: titleFontSize ?? null,
                center: true,
                clr: titleClr ?? colors.primaryColor,
                weight: titleWeight ?? 'Semi Bold',
              ),
              backgroundColor: Colors.transparent,
            )
          : null,
      drawer:showDrawer==false? null:Drawer(
        child: DrawerSideScreen(),
      ),
      body: Container(
        height: responsive.setHeight(100),
        width: responsive.setWidth(100),
        color: bgColor ?? colors.whiteColor,
        child: Stack(
          children: [
            if (showCircle1 ?? true)
              Positioned(
                left: responsive.setWidth(align1Top ?? 65),
                bottom: responsive.setHeight(align1Bottom ?? 78),
                child: Container(
                  height: responsive.setHeight(circle1Height ?? 35),
                  width: responsive.setHeight(circle1Width ?? 50),
                  decoration: BoxDecoration(
                    color: colors.primaryColor,
                    borderRadius: BorderRadius.circular(200),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: colors.hintColor,
                      //   ),
                      //   BoxShadow(
                      //       color: colors.primaryColor,
                      //       blurRadius: 12.0, // soften the shadow
                      //       spreadRadius: -0.5, //extend the shadow
                      //       // offset: Offset(7, 7)
                      //   )   ]
                  ),
                ),
              ),
            if (showCircle2 ?? true)
              Positioned(
                left: responsive.setWidth(align2Top ?? -15),
                bottom: responsive.setHeight(align2Bottom ?? 28),
                child: Container(
                  height: responsive.setHeight(circle2Height ?? 15),
                  width: responsive.setHeight(circle2Width ?? 15),
                  decoration: BoxDecoration(
                      color: colors.primaryColor,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            if (showCircle3 ?? true)
              Positioned(
                left: responsive.setWidth(align3Top ?? -15),
                bottom: responsive.setHeight(align3Bottom ?? -7),
                child: Container(
                  height: responsive.setHeight(circle3Height ?? 15),
                  width: responsive.setHeight(circle3Width ?? 15),
                  decoration: BoxDecoration(
                      color: colors.primaryColor,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            if (showCircle4 ?? true)
              Positioned(
                left: responsive.setWidth(align4Top ?? 85),
                bottom: responsive.setHeight(align4Bottom ?? -5),
                child: Container(
                  height: responsive.setHeight(circle4Height ?? 15),
                  width: responsive.setHeight(circle4Width ?? 15),
                  decoration: BoxDecoration(
                      color: colors.primaryColor,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            SafeArea(child: child ?? Container()),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   child: Container(
            //     width: size.width,
            //     height: 80,
            //     child: Stack(
            //       overflow: Overflow.visible,
            //       children: [
            //         CustomPaint(
            //           size: Size(size.width, 100),
            //           painter: BNBCustomPainter(),
            //         ),
            //         Center(
            //           heightFactor: 0.2,
            //           child: Container(
            //             height: responsive.setHeight(30),
            //             width: responsive.setHeight(8),
            //             child: FloatingActionButton(
            //                 backgroundColor: Colors.orange,
            //                 child: Icon(Icons.shopping_basket),
            //                 elevation: 0.1,
            //                 onPressed: () {}),
            //           ),
            //         ),
            //         Container(
            //           width: size.width,
            //           height: 80,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               IconButton(
            //                 icon: Icon(
            //                   Icons.home,
            //                   color: currentIndex == 0
            //                       ? Colors.orange
            //                       : Colors.grey.shade400,
            //                 ),
            //                 onPressed: () {
            //                   setBottomBarIndex(0);
            //                 },
            //                 splashColor: Colors.white,
            //               ),
            //               IconButton(
            //                   icon: Icon(
            //                     Icons.restaurant_menu,
            //                     color: currentIndex == 1
            //                         ? Colors.orange
            //                         : Colors.grey.shade400,
            //                   ),
            //                   onPressed: () {
            //                     setBottomBarIndex(1);
            //                   }),
            //               Container(
            //                 width: size.width * 0.20,
            //               ),
            //               IconButton(
            //                   icon: Icon(
            //                     Icons.bookmark,
            //                     color: currentIndex == 2
            //                         ? Colors.orange
            //                         : Colors.grey.shade400,
            //                   ),
            //                   onPressed: () {
            //                     setBottomBarIndex(2);
            //                   }),
            //               IconButton(
            //                   icon: Icon(
            //                     Icons.notifications,
            //                     color: currentIndex == 3
            //                         ? Colors.orange
            //                         : Colors.grey.shade400,
            //                   ),
            //                   onPressed: () {
            //                     setBottomBarIndex(3);
            //                   }),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1039397, size.height * 0.001457048);
    path_0.lineTo(size.width * 0.3941585, size.height * 0.001457048);
    path_0.cubicTo(
        size.width * 0.3941585,
        size.height * 0.001457048,
        size.width * 0.3855116,
        size.height * 0.4713334,
        size.width * 0.5063232,
        size.height * 0.4822891);
    path_0.cubicTo(
        size.width * 0.6125749,
        size.height * 0.4704591,
        size.width * 0.6104036,
        size.height * 0.001457048,
        size.width * 0.6104036,
        size.height * 0.001457048);
    path_0.lineTo(size.width * 0.8964758, size.height * 0.001457048);
    path_0.cubicTo(
        size.width * 0.9395186,
        size.height * 0.001457048,
        size.width * 0.9744301,
        size.height * 0.1629104,
        size.width * 0.9744301,
        size.height * 0.3620795);
    path_0.lineTo(size.width * 0.9744301, size.height * 0.9270546);
    path_0.lineTo(0, size.height * 0.9270546);
    path_0.lineTo(0, size.height * 0.4822891);
    path_0.cubicTo(
        0,
        size.height * 0.2167344,
        size.width * 0.04653517,
        size.height * 0.001457048,
        size.width * 0.1039397,
        size.height * 0.001457048);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.redAccent;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

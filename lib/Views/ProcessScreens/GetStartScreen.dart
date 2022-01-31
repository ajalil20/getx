// ignore_for_file: file_names

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class GettingStartScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return DoubleBack(
      message: "Press back again to close",
      child: BaseView(
        showDrawer: false,
        showAppBar: false,
        showCircle3: false,
        showBottomBar: false,
        align1Top: 60,
        align1Bottom: 73,
        align2Top: -20,
        align2Bottom: 38,
        align4Top: 85,
        align4Bottom: -9,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: responsive.setHeight(0),
              ),
              Image.asset(
                'assets/images/logo.png',
                width: responsive.setWidth(40),
              ),
              Container(
                height: responsive.setHeight(62),
                width: responsive.setWidth(100),
                child: PageView(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/getStartImg.png',
                          width: responsive.setWidth(90),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: MyText(
                            title: '${TextConstant.en['GetStart']['Detail']}',
                            center: true,
                            line: 6,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: responsive.setHeight(1),
                    width: 35,
                    decoration: BoxDecoration(
                        color: colors.secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: responsive.setHeight(1),
                    width: 10,
                    decoration: BoxDecoration(
                        color: colors.secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: responsive.setHeight(1),
                    width: 10,
                    decoration: BoxDecoration(
                        color: colors.secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              SizedBox(
                height: responsive.setHeight(6),
              ),
              MyElevatedButton(
                onTap: () {
                  Get.toNamed('/selectionPreference');
                },
                height: responsive.setHeight(7.5),
                width: responsive.setWidth(78),
                title: '${TextConstant.en['GetStart']['GetStarted']}',
                textColor: colors.whiteColor,
                bgColor: colors.primaryColor,
                isImage: true,
                imageColor: colors.blackColor.withOpacity(0.3),
              ),
              SizedBox(
                height: responsive.setHeight(1),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     height: responsive.setHeight(100),
    //     width: responsive.setWidth(100),
    //     color: colors.whiteColor,
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           left: responsive.setWidth(60),
    //           bottom: responsive.setHeight(73),
    //           child: Container(
    //             height: responsive.setHeight(35),
    //             width: responsive.setHeight(50),
    //             decoration: BoxDecoration(
    //               color: colors.primaryColor,
    //               borderRadius: BorderRadius.circular(200),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: responsive.setWidth(-20),
    //           bottom: responsive.setHeight(38),
    //           child: Container(
    //             height: responsive.setHeight(15),
    //             width: responsive.setHeight(15),
    //             decoration: BoxDecoration(
    //                 color: colors.primaryColor,
    //                 borderRadius: BorderRadius.circular(200)),
    //           ),
    //         ),
    //         Positioned(
    //           left: responsive.setWidth(85),
    //           bottom: responsive.setHeight(-9),
    //           child: Container(
    //             height: responsive.setHeight(15),
    //             width: responsive.setHeight(15),
    //             decoration: BoxDecoration(
    //                 color: colors.primaryColor,
    //                 borderRadius: BorderRadius.circular(200)),
    //           ),
    //         ),
    //         SafeArea(
    //           child: Center(
    //             child: Column(
    //               children: [
    //                 SizedBox(
    //                   height: responsive.setHeight(7),
    //                 ),
    //                 Image.asset(
    //                   'assets/images/logo.png',
    //                   width: responsive.setWidth(40),
    //                 ),
    //                 Container(
    //                   height: responsive.setHeight(62),
    //                   width: responsive.setWidth(100),
    //                   child: PageView(
    //                     children: [
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images/getStartImg.png',
    //                             width: responsive.setWidth(90),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                                 horizontal: 28.0),
    //                             child: MyText(
    //                               title:
    //                                   'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy consetetur sadipscing elitr, sed diam nonumy consetetur sadipscing elitr, sed diam nonumy  consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet..',
    //                               center: true,
    //                               line: 7,
    //                               toverflow: TextOverflow.ellipsis,
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       height: 10,
    //                       width: 35,
    //                       decoration: BoxDecoration(
    //                           color: colors.secondaryColor,
    //                           borderRadius: BorderRadius.circular(10)),
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Container(
    //                       height: 10,
    //                       width: 10,
    //                       decoration: BoxDecoration(
    //                           color: colors.secondaryColor,
    //                           borderRadius: BorderRadius.circular(10)),
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Container(
    //                       height: 10,
    //                       width: 10,
    //                       decoration: BoxDecoration(
    //                           color: colors.secondaryColor,
    //                           borderRadius: BorderRadius.circular(10)),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: responsive.setHeight(6),
    //                 ),
    //                 MyElevatedButton(
    //                   onTap: () {
    //                     Get.toNamed('/selectionPreference');
    //                   },
    //                   height: responsive.setHeight(7.5),
    //                   width: responsive.setWidth(78),
    //                   title: 'Get Started',
    //                   textColor: colors.whiteColor,
    //                   bgColor: colors.primaryColor,
    //                   isImage: true,
    //                   imageColor: colors.blackColor.withOpacity(0.3),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

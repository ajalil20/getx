// ignore_for_file: file_names
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pawndr/Controller/splash_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Utils/text_constants.dart';
import 'package:get/get.dart';
import '../../Component/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashController splashController = SplashController();
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  @override
  Widget build(BuildContext context) {
    splashController.onInit();
    responsive.setContext(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: colors.primaryColor,
            image: DecorationImage(
              image: AssetImage('assets/images/bgtop.png'),
              fit: BoxFit.cover,
            )),
        child: Container(
          decoration: BoxDecoration(
            color: colors.primaryColor.withOpacity(0.95),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/images/logo.png'),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: MyText(
                  title: '${TextConstant.en["SplashScreen"]["Description"]}',
                  size: 11.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

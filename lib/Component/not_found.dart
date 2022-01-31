
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class NotFound extends StatelessWidget {
  String title;
  NotFound({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Center(
        //     child: Icon(CupertinoIcons.),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: MyText(
            center: true,
            title: "No $title available",
            size: 14,
          ),
        )
      ],
    );
  }
}

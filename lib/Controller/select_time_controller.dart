import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
class SelectTimeController extends GetxController{
@override
  
   showTime(context)async{
     TimeOfDay time = await PlatformDatePicker.showTime(
    context: context,
    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    showCupertino: false,
 
);
  }

}
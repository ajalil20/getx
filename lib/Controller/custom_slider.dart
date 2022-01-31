import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatelessWidget {
  ColorConfig colors = ColorConfig();
  final bool? showLabel;
  final double? minValue;
  final double? maxValue;
  final bool? showTick;
  final bool? enableToolTip;
  final double? stepSize;
  final bool? rangeSlider;
  SfRangeValues? checkType;
  var singleValue;

  // final String? checkType;
  Function(SfRangeValues)? returnValue;
  Function(double)? singleReturnValue;

  // Rx<SfRangeValues>? checkType = const SfRangeValues(20.0, 80.0).obs;

  CustomSlider(
      {Key? key,
      this.checkType,
      this.rangeSlider,
      this.stepSize,
      this.showLabel,
      this.maxValue,
      this.minValue,
      this.showTick,
        this.singleValue,
      this.enableToolTip,
      this.returnValue,
      this.singleReturnValue
      })
      : super(key: key);
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return rangeSlider == true
        ?  SfRangeSliderTheme(
      data: SfRangeSliderThemeData(
            thumbRadius: 8,
              activeTrackHeight:4,
          inactiveTrackHeight: 4
      ),
          child: SfRangeSlider(
                min: minValue,
                max: maxValue,
                activeColor: colors.darkYellow,
                inactiveColor: colors.gray,
                values: checkType!,
                interval: 20,
                showTicks: showTick!,
                showLabels: showLabel!,
                enableTooltip: enableToolTip!,
                minorTicksPerInterval: 1,
                stepSize: stepSize ?? 2,
                onChanged: (dynamic value) {
                  checkType = value;
                  // checkType=="age"?controller.age.value=value:
                  // _homeController.heightRange.value=value;
                  print("Ye range ha" + value.toString());
                  print("Ye checkType ha" + checkType.toString());
                  if (returnValue != null) {
                    returnValue!(checkType!);
                  } else {}
                },
              ),
        )
        : SfSliderTheme(
      data: SfSliderThemeData(
          thumbRadius: 8,
          activeTrackHeight:4,
          inactiveTrackHeight: 4
      ),
          child: SfSlider(
                min: minValue,
                max: maxValue,
                activeColor: colors.darkYellow,
                inactiveColor: colors.gray,
                value: singleValue,
                interval: 20,
                showTicks: showTick!,
                showLabels: showLabel!,
                enableTooltip: enableToolTip!,
                minorTicksPerInterval: 1,
                stepSize: stepSize ?? 2,
                onChanged: (dynamic value) {
                  print(value);
                  singleValue=(value);
                  if (singleReturnValue != null) {
                    singleReturnValue!(singleValue!);
                  } else {}

                },
              ),
        );
    ;
  }
}

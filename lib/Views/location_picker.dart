import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:get/get.dart';
import 'package:pawndr/Controller/forgotpassword_controller.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';

class LocationPicker extends StatelessWidget {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  PickResult? selectedPlace;
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showDrawer: false,
      showCircle2: false,
      showCircle1: true,
      showCircle4: false,
      showBottomBar: false,
      showAppBar: false,
      showBackButton: false,
      child: PlacePicker(
        apiKey: 'AIzaSyA6vQvbykbNq3sOT_M5CDk0GR50xkr2d4M',
        initialPosition: LocationPicker.kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,

        //usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          print("result");
          print(result);
          selectedPlace = result;
          Navigator.of(context).pop();
        },

        //forceSearchOnZoomChanged: true,
        //automaticallyImplyAppBarLeading: false,
        //autocompleteLanguage: "ko",
        //region: 'au',
        //selectInitialPosition: true,
        // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
        //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        //   return isSearchBarFocused
        //       ? Container()
        //       : FloatingCard(
        //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
        //           leftPosition: 0.0,
        //           rightPosition: 0.0,
        //           width: 500,
        //           borderRadius: BorderRadius.circular(12.0),
        //           child: state == SearchingState.Searching
        //               ? Center(child: CircularProgressIndicator())
        //               : RaisedButton(
        //                   child: Text("Pick Here"),
        //                   onPressed: () {
        //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
        //                     //            this will override default 'Select here' Button.
        //                     print("do something with [selectedPlace] data");
        //                     Navigator.of(context).pop();
        //                   },
        //                 ),
        //         );
        // },
        // pinBuilder: (context, state) {
        //   if (state == PinState.Idle) {
        //     return Icon(Icons.favorite_border);
        //   } else {
        //     return Icon(Icons.favorite);
        //   }
        // },

      )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:pawndr/Controller/map_controller.dart';
class MapView extends StatelessWidget {
  final  lat;
  final  long;
  MapView({this.lat,this.long});

  
    MapControler _mapControler = Get.put(MapControler());
   static const LatLng _center = const LatLng(24.8688, 67.0614);

 
  @override
  Widget build(BuildContext context) {
    return Obx(()=> GoogleMap(
            onMapCreated: _mapControler.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 1.0,
            ),
            zoomControlsEnabled: false,
            markers: Set<Marker>.of(_mapControler.markers.values),
            onTap: (val){_mapControler.showInfo.value= false;},
          ),
    );
    
  }
}
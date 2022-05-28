

import 'package:eat_this/src/core/request_permission.dart';
import 'package:geolocator/geolocator.dart';

checkLocationPermission() async{
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if(isLocationServiceEnabled == true){
    await RequestPermission.requestLocationPermission();
  }
}
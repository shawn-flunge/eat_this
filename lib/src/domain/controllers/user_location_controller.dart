
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationController with ChangeNotifier{

  static final UserLocationController _instance = UserLocationController._internal();
  UserLocationController._internal();

  factory UserLocationController(){
    return _instance;
  }

  late LatLng userLocation;

  init() async{
    userLocation = await getCurrentPosition();
    notifyListeners();
  }

  Future<LatLng> getCurrentPosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }


}
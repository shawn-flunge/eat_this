

import 'dart:async';
import 'dart:io';

import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/domain/controllers/user_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenController with ChangeNotifier{

  late GoogleMapController googleMapController;
  late UserLocationController userLocationController;

  late StreamController<Offset> myLocationInScreen;

  static final HomeScreenController _instance = HomeScreenController._internal();
  HomeScreenController._internal();

  factory HomeScreenController(){
    return _instance;
  }

  late CameraPosition initCameraPosition;
  late double pixelRatio;
  // Offset myLocationInScreen = Offset(0,0);

  init(){
    userLocationController = UserLocationController();
    initCameraPosition = CameraPosition(
      target: userLocationController.userLocation,
      tilt: 0,
      zoom: 17,
      bearing: 0,
    );
    myLocationInScreen = StreamController<Offset>();
  }

  onMapCreated(GoogleMapController googleMapController, double pixelRatio){
    this.googleMapController = googleMapController;
    this.pixelRatio = pixelRatio;
    notifyListeners();
  }

  onCameraMove(cameraPosition) async{
    final ScreenCoordinate sc = await googleMapController.getScreenCoordinate(userLocationController.userLocation);

    if(Platform.isAndroid){
      myLocationInScreen.add(
          Offset(sc.x.toDouble()/pixelRatio - myLocationButtonSize.width, sc.y.toDouble()/pixelRatio - myLocationButtonSize.height)
      );
    } else{
      myLocationInScreen.add(
          Offset(sc.x.toDouble() - myLocationButtonSize.width, sc.y.toDouble() - myLocationButtonSize.height)
      );
    }
  }

  setCurrentLocation() async{
    LatLng latLng = await userLocationController.getCurrentPosition();
    googleMapController.moveCamera(CameraUpdate.newLatLng(latLng));
  }



}
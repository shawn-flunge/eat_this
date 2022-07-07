

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/core/mixin/result_popup_mixin.dart';
import 'package:eat_this/src/data/models/category.dart';
import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/domain/controllers/place_controller.dart';
import 'package:eat_this/src/domain/controllers/user_location_controller.dart';
import 'package:eat_this/src/presentation/roulette.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenController with ChangeNotifier, ResultPopUpMixin{

  late GoogleMapController googleMapController;
  late UserLocationController _userLocationController;
  late PlaceController _placeController;

  late StreamController<Offset> myLocationInScreen;
  late StreamController<List<Marker>> markerStream;

  static final HomeScreenController _instance = HomeScreenController._internal();
  HomeScreenController._internal();

  factory HomeScreenController(){
    return _instance;
  }

  late CameraPosition initCameraPosition;
  late double pixelRatio;
  int radius = 500;
  bool isSelected = false;
  StreamController<bool> isSelectedStream = StreamController<bool>();

  final markers = <Marker>[];
  late Restaurant selectedRestaurant;

  init(){
    _userLocationController = UserLocationController();
    _placeController = PlaceController();
    initCameraPosition = CameraPosition(
      target: _userLocationController.userLocation,
      tilt: 0,
      zoom: 17,
      bearing: 0,
    );
    myLocationInScreen = StreamController<Offset>();
    markerStream = StreamController<List<Marker>>();
  }

  onMapCreated(GoogleMapController googleMapController, double pixelRatio){
    this.googleMapController = googleMapController;
    this.pixelRatio = pixelRatio;
    notifyListeners();
  }

  onCameraMove(cameraPosition) async{
    final ScreenCoordinate sc = await googleMapController.getScreenCoordinate(_userLocationController.userLocation);
    _setMyLocationButton(sc);
  }

  onTap(LatLng latLng){
    isSelectedStream.add(false);
  }

  setCurrentLocation() async{
    LatLng latLng = await _userLocationController.getCurrentPosition();
    googleMapController.moveCamera(CameraUpdate.newLatLng(latLng));
  }

  callNewApi() async{
    LatLng current = await _userLocationController.getCurrentPosition();
    final List<Category> categories = await _placeController.getSortedRestaurantsByCategory(lat: current.latitude, lng: current.longitude, radius: radius);

    late AnimationController rouletteController;
    final List<RouletteContent> contents = categories.map((e){
      return RouletteContent(
        piColor: _getRandomColor(),
        label: e.categoryName,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black
        )
      );
    }).toList();
    int selectedIndex = 0;

    final destination = await category(contents, categories, selectedIndex);
    if(destination != null){
      selectedRestaurant = destination;

      final LatLng targetLatLng = LatLng(double.parse(selectedRestaurant.lat), double.parse(selectedRestaurant.lng));
      markers.clear();
      markers.add(
          Marker(
              markerId: MarkerId(selectedRestaurant.placeName),
              position: targetLatLng,

          )
      );
      markerStream.add(
          [
            Marker(
                markerId: MarkerId(selectedRestaurant.placeName),
                position: targetLatLng
            )
          ]
      );
      googleMapController.animateCamera(CameraUpdate.newLatLng(targetLatLng));
      isSelectedStream.add(true);
      notifyListeners();
    }
  }

  setRestaurants() async{
    LatLng current = await _userLocationController.getCurrentPosition();
    await _placeController.setRestaurants(lat: current.latitude, lng: current.longitude, radius: radius);

    if(_placeController.restaurants.isNotEmpty){

      final int randomIndex = math.Random().nextInt(_placeController.restaurants.length);
      selectedRestaurant = _placeController.restaurants[randomIndex];
      final destination = await basic(selectedRestaurant, _placeController);

      if(destination != null){

        final LatLng targetLatLng = LatLng(double.parse(destination.lat), double.parse(destination.lng));
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId(selectedRestaurant.placeName),
            position: targetLatLng
          )
        );
        markerStream.add(
          [
            Marker(
                markerId: MarkerId(selectedRestaurant.placeName),
                position: targetLatLng
            )
          ]
        );
        googleMapController.animateCamera(CameraUpdate.newLatLng(targetLatLng));
        notifyListeners();
      }

    }
  }

  onCurrentLocationButtonTap() async{
    final LatLng current = await _userLocationController.getCurrentPosition();
    googleMapController.moveCamera(CameraUpdate.newLatLng(current));
    final ScreenCoordinate sc = await googleMapController.getScreenCoordinate(current);
    _setMyLocationButton(sc);
  }

  _setMyLocationButton(ScreenCoordinate sc){
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

  Color _getRandomColor(){
    final math.Random random = math.Random();
    final int r = random.nextInt(255);
    final int g = random.nextInt(255);
    final int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  @override
  void dispose() {
    super.dispose();
    myLocationInScreen.close();
    markerStream.close();
    isSelectedStream.close();
  }

}
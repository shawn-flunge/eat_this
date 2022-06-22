

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/domain/controllers/place_controller.dart';
import 'package:eat_this/src/domain/controllers/user_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenController with ChangeNotifier{

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
  // Offset myLocationInScreen = Offset(0,0);

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

  setCurrentLocation() async{
    LatLng latLng = await _userLocationController.getCurrentPosition();
    googleMapController.moveCamera(CameraUpdate.newLatLng(latLng));
  }

  callNewApi() async{
    LatLng current = await _userLocationController.getCurrentPosition();
    await _placeController.getSortedRestaurantsByCategory(lat: current.latitude, lng: current.longitude, radius: radius);
  }

  final markers = <Marker>[];

  late Restaurant selectedRestaurant;
  setRestaurants() async{
    LatLng current = await _userLocationController.getCurrentPosition();
    await _placeController.setRestaurants(lat: current.latitude, lng: current.longitude, radius: radius);

    if(_placeController.restaurants.isNotEmpty){

      final int randomIndex = math.Random().nextInt(_placeController.restaurants.length);
      // showDialog(
      //   context: homeScreenScaffoldKey.currentContext!,
      //   builder: (context){
      //     return Dialog(
      //       child: Text('sex'),
      //     );
      //   }
      // );
      selectedRestaurant = _placeController.restaurants[randomIndex];

      final destination = await showDialog<Restaurant>(
          context: homeScreenScaffoldKey.currentContext!,
          builder: (BuildContext dialogueContext){

            return Dialog(
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (builderContext, setStateDialogue){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          selectedRestaurant.placeName,
                          style: const TextStyle(
                            fontSize: 24
                          ),
                        ),
                        Text(
                          selectedRestaurant.roadAddress + ' (${selectedRestaurant.distance}m)',
                        ),
                        Text(
                          selectedRestaurant.placeCategory.fullName,
                        ),
                        Text(
                          selectedRestaurant.placeName,
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                setStateDialogue(() {
                                  final int random = math.Random().nextInt(_placeController.restaurants.length);
                                  selectedRestaurant = _placeController.restaurants[random];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)
                                ),
                                child: const Icon(
                                  Icons.refresh,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                Navigator.pop(builderContext, selectedRestaurant);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                                decoration: const BoxDecoration(
                                    color: Colors.black
                                ),
                                child: const Text(
                                  '선택',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          }
      );

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
    final ScreenCoordinate sc = await googleMapController.getScreenCoordinate(current);

    googleMapController.moveCamera(CameraUpdate.newLatLng(current));
    _setMyLocationButton(sc);
    // googleMapController.mo
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

  @override
  void dispose() {
    super.dispose();
    myLocationInScreen.close();
    markerStream.close();
  }

}
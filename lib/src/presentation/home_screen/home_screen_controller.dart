

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/data/models/category.dart';
import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/domain/controllers/place_controller.dart';
import 'package:eat_this/src/domain/controllers/user_location_controller.dart';
import 'package:eat_this/src/presentation/roulette.dart';
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

  onTap(LatLng latLng){
    isSelectedSteam.add(false);
  }

  setCurrentLocation() async{
    LatLng latLng = await _userLocationController.getCurrentPosition();
    googleMapController.moveCamera(CameraUpdate.newLatLng(latLng));
  }

  Color getRandomColor(){
    final math.Random random = math.Random();
    final int r = random.nextInt(255);
    final int g = random.nextInt(255);
    final int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  callNewApi() async{
    LatLng current = await _userLocationController.getCurrentPosition();
    final List<Category> categories = await _placeController.getSortedRestaurantsByCategory(lat: current.latitude, lng: current.longitude, radius: radius);

    late AnimationController rouletteController;
    final List<RouletteContent> contents = categories.map((e){
      return RouletteContent(
        piColor: getRandomColor(),
        label: e.categoryName,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black
        )
      );
    }).toList();
    int selectedIndex = 0;

    final destination = await showDialog<Restaurant>(
      context: homeScreenScaffoldKey.currentContext!,
      builder: (context){
        return AlertDialog(

          content: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: RouletteWidget(
                    contents: contents,
                    onCreated: (controller){
                        rouletteController = controller;
                    },
                    hand: Container(width: 40, height: 10, color: Colors.black,),
                    onFinish: (index){
                      selectedIndex = index;
                      print(selectedIndex);
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        rouletteController.reset();
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
                    InkWell(
                      onTap: (){

                        List<Restaurant> restaurants = [];
                        categories[selectedIndex].kakaoSearchResponseDtos.map((e) => restaurants.add(e)).toList();

                        if(categories[selectedIndex].subSteps.isNotEmpty){
                          categories[selectedIndex].subSteps.map((e){
                            restaurants.addAll(e.kakaoSearchResponseDtos);
                          }).toList();
                        }
                        Navigator.pop(homeScreenScaffoldKey.currentContext!, restaurants[math.Random().nextInt(restaurants.length)]);
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
                ),



              ],
            ),
          ),
        );
      }
    );

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
      // isSelected = true;
      isSelectedSteam.add(true);
      notifyListeners();
    }
  }
  bool isSelected = false;
  StreamController<bool> isSelectedSteam = StreamController<bool>();



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
    googleMapController.moveCamera(CameraUpdate.newLatLng(current));
    final ScreenCoordinate sc = await googleMapController.getScreenCoordinate(current);
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
    isSelectedSteam.close();
  }

}
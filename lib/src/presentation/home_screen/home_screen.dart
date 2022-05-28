
import 'dart:async';
import 'dart:io';

import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/data/repositories/restaurant_repository_impl.dart';
import 'package:eat_this/src/presentation/home_screen/home_screen_controller.dart';
import 'package:eat_this/src/presentation/home_screen/widgets/my_location_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    temp();
    _setTextField();
    controller = HomeScreenController();
  }

  late HomeScreenController controller;

  temp() async{
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    print(isLocationServiceEnabled);
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    // bool enabled = await Geolocator.isLocationServiceEnabled();
    // if(!enabled){
    //   print('service disabled');
    //   Geolocator.requestPermission();
    // }
    // LocationPermission permission = await Geolocator.checkPermission();
    // if(permission == LocationPermission.denied){
    //   print('permission denied');
    // }

  }

  _degreeToRadian(double degree){
    return degree * math.pi / 180;
  }
  _radianToDegree(double radian){
    return radian * 180 / math.pi;
  }


  double distanceBetween(double startLatitude, double startLongitude, double endLatitude, double endLongitude,) {
    var earthRadius = 6378137.0;
    var dLat = _degreeToRadian(endLatitude - startLatitude);
    var dLon = _degreeToRadian(endLongitude - startLongitude);

    var a = math.pow(math.sin(dLat / 2), 2) +
        math.pow(math.sin(dLon / 2), 2) *
            math.cos(_degreeToRadian(startLatitude)) *
            math.cos(_degreeToRadian(endLatitude));

    var c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }


  LatLng latLng = const LatLng(37.52627236692194, 126.93512036745244);
  GoogleMapController? _googleMapController;


  Restaurant? selectedRestaurant;
  List<Restaurant> restaurantsAroundMe = [];

  getRestaurant() async{
    RestaurantRepositoryImpl repositoryImpl = RestaurantRepositoryImpl();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Restaurant> restaurants = await repositoryImpl.getRestaurantsWithinCircle(lat: position.latitude, lng: position.longitude, radius: 500);

    if(restaurants.isNotEmpty){
      restaurantsAroundMe = restaurants;

      final int random = math.Random().nextInt(restaurants.length);

      final target = restaurantsAroundMe[random];

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => IntroducingRestaurantScreen(restaurant: target,)),
      // );

      final destination = await showDialog<Restaurant>(
        context: context,
        builder: (dialogueContext){
          final int random = math.Random().nextInt(restaurants.length);
          selectedRestaurant = restaurantsAroundMe[random];
          return Dialog(

            child: SizedBox(
              height: 200,
              child: StatefulBuilder(
                builder: (builderContext, setStateDialogue) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        selectedRestaurant!.placeName,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                          selectedRestaurant!.roadAddress + ' (${selectedRestaurant!.distance}m)'
                      ),
                      Text(
                        selectedRestaurant!.placeCategory.fullName,
                      ),
                      Text(
                          selectedRestaurant!.phoneNumber
                      ),
                      const Expanded(child: SizedBox()),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              setStateDialogue(() {
                                final int random = math.Random().nextInt(restaurants.length);
                                selectedRestaurant = restaurantsAroundMe[random];
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
                              Navigator.pop(context, target);
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
                }
              ),
            ),
          );
        }
      );

      if(destination != null){

        final LatLng targetLatLng = LatLng(double.parse(destination.lat), double.parse(destination.lng));
        setState(() {
          markers.clear();
          markers.add(
              Marker(
                  markerId: MarkerId(target.placeName),
                  position: targetLatLng
              )
          );
        });
        _googleMapController!.animateCamera(
          CameraUpdate.newLatLng(
            targetLatLng
          )
        );
      }
      String a = 'ff';

      if(a == 'Sring'){

      }





    }
  }

  final markers = <Marker>[];

  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();


  _setTextField(){
    textEditingController.text = '100';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenScaffoldKey,
      body: Stack(
        children: <Widget>[
          // GoogleMap(
          //   initialCameraPosition: controller.initCameraPosition,
          //   zoomControlsEnabled: false,
          //   myLocationButtonEnabled: false,
          //   mapToolbarEnabled: false,
          //   compassEnabled: false,
          //   liteModeEnabled: false,
          //   buildingsEnabled: false,
          //   myLocationEnabled: false,
          //   markers: controller.markers.toSet(),
          //   onMapCreated: (googleMapController){
          //     final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
          //     controller.onMapCreated(googleMapController, pixelRatio);
          //   },
          //   onCameraMove: controller.onCameraMove,
          // ),
          StreamBuilder<List<Marker>>(
            stream: controller.markerStream.stream,
            initialData: const [],
            builder: (context, snapShot){
              return GoogleMap(
                initialCameraPosition: controller.initCameraPosition,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                liteModeEnabled: false,
                buildingsEnabled: false,
                myLocationEnabled: false,
                markers: snapShot.data!.toSet(),
                onMapCreated: (googleMapController){
                  final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
                  controller.onMapCreated(googleMapController, pixelRatio);
                },
                onCameraMove: controller.onCameraMove,
              );
            }
          ),
          const MyLocationInScreen(),
          Positioned(
            right: 10,
            bottom: 100,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10
                  )
                ]
              ),
              child: InkWell(
                onTap: controller.onCurrentLocationButtonTap,
                child: const Icon(
                  Icons.my_location,
                ),
              )
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10
                  )
                ]
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.directions_walk
                  ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      // showDialog(
                      //   context: context,
                      //   builder: builder
                      // );
                    },
                    child: Text(
                      '500'
                    ),
                  ),
                  const Expanded(child: SizedBox()),

                  InkWell(
                    // onTap: getRestaurant,
                    onTap: controller.setRestaurants,
                    child: const Icon(
                      Icons.search
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

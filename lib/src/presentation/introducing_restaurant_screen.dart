

import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IntroducingRestaurantScreen extends StatefulWidget {
  const IntroducingRestaurantScreen({
    Key? key,
    required this.restaurant
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  _IntroducingRestaurantScreenState createState() => _IntroducingRestaurantScreenState();
}

class _IntroducingRestaurantScreenState extends State<IntroducingRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.restaurant.placeName
        ),
      ),
      body: Column(
        children: [
          // Text(
          //   widget.restaurant.toString()
          // ),

          Text(
            widget.restaurant.placeName + ' ${widget.restaurant.placeCategory.fullName}'
          ),
          Text(
              widget.restaurant.roadAddress + ' (${widget.restaurant.distance}m)'
          ),
          Text(
            widget.restaurant.phoneNumber
          ),
          
          SizedBox(
            width: 300,
            height: 400,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.restaurant.lat), double.parse(widget.restaurant.lng)),
                  tilt: 0,
                  zoom: 17,
                  bearing: 0,
                )
            ),
          )

        ],
      ),
    );
  }
}



import 'dart:async';

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
    // TODO: implement initState
    super.initState();
    temp();
  }

  temp() async{
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if(!enabled){
      print('service disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      print('permission denied');
    }

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

  getLatLngsByDistance(double distance){

    const double angle1 = 315;
    const double angle2 = 135;
  }


  temp1() async{
    LatLngBounds? latLng = await _googleMapController?.getVisibleRegion();

    print('bdfbdfbdfbdf $latLng');
    print(distanceBetween(37.524570661913515, 126.93301364779471, 37.527973900886344, 126.93722706288098));
  }


  getCurrentPosition() async{
    // Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());

    
    setState(() {
      LatLng newLatLng = LatLng(position.latitude, position.longitude);
      _googleMapController?.moveCamera(CameraUpdate.newLatLng(newLatLng));
    });
  }

  LatLng latLng = const LatLng(37.52627236692194, 126.93512036745244);
  GoogleMapController? _googleMapController;

  void _onMapCreated(GoogleMapController controller){
    _googleMapController = controller;
  }

  void _onTap(LatLng latLng) async{

    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //
    // final double distance = distanceBetween(position.latitude, position.longitude, latLng.latitude, latLng.longitude);
    // print(distance);
    // temp1();
    temp();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이거 먹어'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // temp();
          getCurrentPosition();
        },
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: latLng,
                tilt: 0,
                zoom: 17,
                bearing: 0,
              ),
              buildingsEnabled: false,
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              onTap: _onTap,
            ),
          )

        ],
      ),
    );
  }
}

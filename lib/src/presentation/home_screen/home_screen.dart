

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

  Offset my = Offset(0,0);

  temp() async{
    // LocationPermission permission =  await Geolocator.requestPermission();

    // LocationPermission permission = await Geolocator.checkPermission();
    // print(permission);


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


  temp1() async{
    LatLngBounds? latLng = await _googleMapController?.getVisibleRegion();

    print('bdfbdfbdfbdf $latLng');
    print(distanceBetween(37.524570661913515, 126.93301364779471, 37.527973900886344, 126.93722706288098));
  }


  getCurrentPosition() async{
    // Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());

    print(await _googleMapController!.getVisibleRegion());


    
    setState(() {
      LatLng newLatLng = LatLng(position.latitude, position.longitude);
      _googleMapController?.moveCamera(CameraUpdate.newLatLng(newLatLng));
    });
  }

  LatLng latLng = const LatLng(37.52627236692194, 126.93512036745244);
  GoogleMapController? _googleMapController;

  void _onMapCreated(GoogleMapController controller) async{
    _googleMapController = controller;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());



    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;

    final ScreenCoordinate sc = await _googleMapController!.getScreenCoordinate(latLng);
    print('${sc} // $pixelRatio');

    my = Offset(sc.x.toDouble() / 10, sc.y.toDouble() / 10);

    setState(() {
      LatLng newLatLng = LatLng(position.latitude, position.longitude);
      _googleMapController?.moveCamera(CameraUpdate.newLatLng(newLatLng));
    });
  }

  void _onTap(LatLng latLng) async{

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final newLatlng = LatLng(position.latitude, position.longitude);
    final ScreenCoordinate sc = await _googleMapController!.getScreenCoordinate(newLatlng);


    print('$position // $pixelRatio');

    my = Offset(sc.x.toDouble() - 15, sc.y.toDouble()-15);

    setState(() {
      LatLng newLatLng = LatLng(position.latitude, position.longitude);
      // _googleMapController?.moveCamera(CameraUpdate.newLatLng(newLatLng));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     '이거 먹어'
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // temp();
          getCurrentPosition();
        },
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: latLng,
              tilt: 0,
              zoom: 17,
              bearing: 0,
            ),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            liteModeEnabled: false,
            buildingsEnabled: false,


            // 핀 위젯 만들면 이거 false로
            myLocationEnabled: true,


            onMapCreated: _onMapCreated,
            onTap: _onTap,
          ),

          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              'Eat this!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              ),
            ),
          ),
          Positioned(
            left: my.dx,
            top: my.dy,
            child: Container(width: 30, height: 30, color: Colors.red,)
          )




        ],
      ),
    );
  }
}

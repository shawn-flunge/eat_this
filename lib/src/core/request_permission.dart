

import 'package:geolocator/geolocator.dart';

abstract class RequestPermission{

  static Future<void> requestLocationPermission() async{

    final locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever){
      final requestPermission = await Geolocator.requestPermission();
    }

  }


}
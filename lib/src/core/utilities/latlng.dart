import 'dart:math' as math;

_degreeToRadian(double degree){
  return degree * math.pi / 180;
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

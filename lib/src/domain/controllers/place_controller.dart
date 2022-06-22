

import 'dart:async';

import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/data/repositories/restaurant_repository_impl.dart';

class PlaceController{

  static final PlaceController _instance = PlaceController._internal();
  PlaceController._internal();

  factory PlaceController(){
    return _instance;
  }

  late RestaurantRepositoryImpl _restaurantRepositoryImpl;

  init() async{
    _restaurantRepositoryImpl = RestaurantRepositoryImpl();
    // restaurants = StreamController<List<Restaurant>>();
  }

  // late StreamController<List<Restaurant>> restaurants;
  List<Restaurant> restaurants = [];

  Future<List<Restaurant>> getRestaurants({required double lat, required double lng, int radius = 500}) async{
    return await _restaurantRepositoryImpl.getRestaurantsWithinCircle(lat: lat, lng: lng, radius: radius);
  }

  Future<void> setRestaurants ({required double lat, required double lng, int radius = 500}) async{
    restaurants = await _restaurantRepositoryImpl.getRestaurantsWithinCircle(lat: lat, lng: lng, radius: radius);
  }

  Future<void> getSortedRestaurantsByCategory({required double lat, required double lng, int radius = 500}) async{
    _restaurantRepositoryImpl.getRestaurantsSortedByCategory(lat: lat, lng: lng, radius: radius);
  }



}
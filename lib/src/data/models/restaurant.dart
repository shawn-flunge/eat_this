import 'package:eat_this/src/data/models/place_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
class Restaurant with _$Restaurant{

  factory Restaurant({
    required String placeId,
    required String placeName,
    required String roadAddress,
    required String lng,
    required String lat,
    required String distance,
    required String phoneNumber,
    required PlaceCategory placeCategory
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>_$RestaurantFromJson(json);
}
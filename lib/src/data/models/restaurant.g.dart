// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Restaurant _$$_RestaurantFromJson(Map<String, dynamic> json) =>
    _$_Restaurant(
      placeId: json['placeId'] as String,
      placeName: json['placeName'] as String,
      roadAddress: json['roadAddress'] as String,
      lng: json['lng'] as String,
      lat: json['lat'] as String,
      distance: json['distance'] as String,
      phoneNumber: json['phoneNumber'] as String,
      placeCategory:
          PlaceCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RestaurantToJson(_$_Restaurant instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'placeName': instance.placeName,
      'roadAddress': instance.roadAddress,
      'lng': instance.lng,
      'lat': instance.lat,
      'distance': instance.distance,
      'phoneNumber': instance.phoneNumber,
      'category': instance.placeCategory,
    };

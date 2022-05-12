// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaceCategory _$$_PlaceCategoryFromJson(Map<String, dynamic> json) =>
    _$_PlaceCategory(
      groupCode: json['groupCode'] as String,
      groupName: json['groupName'] as String,
      fullName: json['fullName'] as String,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$_PlaceCategoryToJson(_$_PlaceCategory instance) =>
    <String, dynamic>{
      'groupCode': instance.groupCode,
      'groupName': instance.groupName,
      'fullName': instance.fullName,
      'name': instance.name,
    };

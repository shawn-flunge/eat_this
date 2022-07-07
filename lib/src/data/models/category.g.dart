// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      categoryName: json['categoryName'] as String,
      step: json['step'] as int,
      kakaoSearchResponseDtos:
          (json['kakaoSearchResponseDtos'] as List<dynamic>?)
                  ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
      subSteps: (json['subSteps'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'step': instance.step,
      'kakaoSearchResponseDtos': instance.kakaoSearchResponseDtos,
      'subSteps': instance.subSteps,
    };

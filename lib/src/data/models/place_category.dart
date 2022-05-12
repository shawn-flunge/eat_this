import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_category.freezed.dart';
part 'place_category.g.dart';

@freezed
class PlaceCategory with _$PlaceCategory{

  factory PlaceCategory({
    required String groupCode,
    required String groupName,
    required String fullName,
    @Default('') String name
  }) = _PlaceCategory;

  factory PlaceCategory.fromJson(Map<String, dynamic> json) =>_$PlaceCategoryFromJson(json);
}

import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category{

  factory Category({
    required String categoryName,
    required int step,
    @Default([]) List<Restaurant> kakaoSearchResponseDtos,
    @Default([]) List<Category> subSteps
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>_$CategoryFromJson(json);
}
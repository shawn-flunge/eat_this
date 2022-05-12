// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return _Restaurant.fromJson(json);
}

/// @nodoc
mixin _$Restaurant {
  String get placeId => throw _privateConstructorUsedError;
  String get placeName => throw _privateConstructorUsedError;
  String get roadAddress => throw _privateConstructorUsedError;
  String get lng => throw _privateConstructorUsedError;
  String get lat => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  PlaceCategory get placeCategory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
          Restaurant value, $Res Function(Restaurant) then) =
      _$RestaurantCopyWithImpl<$Res>;
  $Res call(
      {String placeId,
      String placeName,
      String roadAddress,
      String lng,
      String lat,
      String distance,
      String phoneNumber,
      PlaceCategory placeCategory});

  $PlaceCategoryCopyWith<$Res> get placeCategory;
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res> implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  final Restaurant _value;
  // ignore: unused_field
  final $Res Function(Restaurant) _then;

  @override
  $Res call({
    Object? placeId = freezed,
    Object? placeName = freezed,
    Object? roadAddress = freezed,
    Object? lng = freezed,
    Object? lat = freezed,
    Object? distance = freezed,
    Object? phoneNumber = freezed,
    Object? placeCategory = freezed,
  }) {
    return _then(_value.copyWith(
      placeId: placeId == freezed
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: placeName == freezed
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
      roadAddress: roadAddress == freezed
          ? _value.roadAddress
          : roadAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeCategory: placeCategory == freezed
          ? _value.placeCategory
          : placeCategory // ignore: cast_nullable_to_non_nullable
              as PlaceCategory,
    ));
  }

  @override
  $PlaceCategoryCopyWith<$Res> get placeCategory {
    return $PlaceCategoryCopyWith<$Res>(_value.placeCategory, (value) {
      return _then(_value.copyWith(placeCategory: value));
    });
  }
}

/// @nodoc
abstract class _$$_RestaurantCopyWith<$Res>
    implements $RestaurantCopyWith<$Res> {
  factory _$$_RestaurantCopyWith(
          _$_Restaurant value, $Res Function(_$_Restaurant) then) =
      __$$_RestaurantCopyWithImpl<$Res>;
  @override
  $Res call(
      {String placeId,
      String placeName,
      String roadAddress,
      String lng,
      String lat,
      String distance,
      String phoneNumber,
      PlaceCategory placeCategory});

  @override
  $PlaceCategoryCopyWith<$Res> get placeCategory;
}

/// @nodoc
class __$$_RestaurantCopyWithImpl<$Res> extends _$RestaurantCopyWithImpl<$Res>
    implements _$$_RestaurantCopyWith<$Res> {
  __$$_RestaurantCopyWithImpl(
      _$_Restaurant _value, $Res Function(_$_Restaurant) _then)
      : super(_value, (v) => _then(v as _$_Restaurant));

  @override
  _$_Restaurant get _value => super._value as _$_Restaurant;

  @override
  $Res call({
    Object? placeId = freezed,
    Object? placeName = freezed,
    Object? roadAddress = freezed,
    Object? lng = freezed,
    Object? lat = freezed,
    Object? distance = freezed,
    Object? phoneNumber = freezed,
    Object? placeCategory = freezed,
  }) {
    return _then(_$_Restaurant(
      placeId: placeId == freezed
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      placeName: placeName == freezed
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String,
      roadAddress: roadAddress == freezed
          ? _value.roadAddress
          : roadAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeCategory: placeCategory == freezed
          ? _value.placeCategory
          : placeCategory // ignore: cast_nullable_to_non_nullable
              as PlaceCategory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Restaurant implements _Restaurant {
  _$_Restaurant(
      {required this.placeId,
      required this.placeName,
      required this.roadAddress,
      required this.lng,
      required this.lat,
      required this.distance,
      required this.phoneNumber,
      required this.placeCategory});

  factory _$_Restaurant.fromJson(Map<String, dynamic> json) =>
      _$$_RestaurantFromJson(json);

  @override
  final String placeId;
  @override
  final String placeName;
  @override
  final String roadAddress;
  @override
  final String lng;
  @override
  final String lat;
  @override
  final String distance;
  @override
  final String phoneNumber;
  @override
  final PlaceCategory placeCategory;

  @override
  String toString() {
    return 'Restaurant(placeId: $placeId, placeName: $placeName, roadAddress: $roadAddress, lng: $lng, lat: $lat, distance: $distance, phoneNumber: $phoneNumber, placeCategory: $placeCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Restaurant &&
            const DeepCollectionEquality().equals(other.placeId, placeId) &&
            const DeepCollectionEquality().equals(other.placeName, placeName) &&
            const DeepCollectionEquality()
                .equals(other.roadAddress, roadAddress) &&
            const DeepCollectionEquality().equals(other.lng, lng) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.distance, distance) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other.placeCategory, placeCategory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(placeId),
      const DeepCollectionEquality().hash(placeName),
      const DeepCollectionEquality().hash(roadAddress),
      const DeepCollectionEquality().hash(lng),
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(distance),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(placeCategory));

  @JsonKey(ignore: true)
  @override
  _$$_RestaurantCopyWith<_$_Restaurant> get copyWith =>
      __$$_RestaurantCopyWithImpl<_$_Restaurant>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RestaurantToJson(this);
  }
}

abstract class _Restaurant implements Restaurant {
  factory _Restaurant(
      {required final String placeId,
      required final String placeName,
      required final String roadAddress,
      required final String lng,
      required final String lat,
      required final String distance,
      required final String phoneNumber,
      required final PlaceCategory placeCategory}) = _$_Restaurant;

  factory _Restaurant.fromJson(Map<String, dynamic> json) =
      _$_Restaurant.fromJson;

  @override
  String get placeId => throw _privateConstructorUsedError;
  @override
  String get placeName => throw _privateConstructorUsedError;
  @override
  String get roadAddress => throw _privateConstructorUsedError;
  @override
  String get lng => throw _privateConstructorUsedError;
  @override
  String get lat => throw _privateConstructorUsedError;
  @override
  String get distance => throw _privateConstructorUsedError;
  @override
  String get phoneNumber => throw _privateConstructorUsedError;
  @override
  PlaceCategory get placeCategory => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RestaurantCopyWith<_$_Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

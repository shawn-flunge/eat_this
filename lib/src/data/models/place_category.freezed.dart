// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'place_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaceCategory _$PlaceCategoryFromJson(Map<String, dynamic> json) {
  return _PlaceCategory.fromJson(json);
}

/// @nodoc
mixin _$PlaceCategory {
  String get groupCode => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaceCategoryCopyWith<PlaceCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCategoryCopyWith<$Res> {
  factory $PlaceCategoryCopyWith(
          PlaceCategory value, $Res Function(PlaceCategory) then) =
      _$PlaceCategoryCopyWithImpl<$Res>;
  $Res call({String groupCode, String groupName, String fullName, String name});
}

/// @nodoc
class _$PlaceCategoryCopyWithImpl<$Res>
    implements $PlaceCategoryCopyWith<$Res> {
  _$PlaceCategoryCopyWithImpl(this._value, this._then);

  final PlaceCategory _value;
  // ignore: unused_field
  final $Res Function(PlaceCategory) _then;

  @override
  $Res call({
    Object? groupCode = freezed,
    Object? groupName = freezed,
    Object? fullName = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      groupCode: groupCode == freezed
          ? _value.groupCode
          : groupCode // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_PlaceCategoryCopyWith<$Res>
    implements $PlaceCategoryCopyWith<$Res> {
  factory _$$_PlaceCategoryCopyWith(
          _$_PlaceCategory value, $Res Function(_$_PlaceCategory) then) =
      __$$_PlaceCategoryCopyWithImpl<$Res>;
  @override
  $Res call({String groupCode, String groupName, String fullName, String name});
}

/// @nodoc
class __$$_PlaceCategoryCopyWithImpl<$Res>
    extends _$PlaceCategoryCopyWithImpl<$Res>
    implements _$$_PlaceCategoryCopyWith<$Res> {
  __$$_PlaceCategoryCopyWithImpl(
      _$_PlaceCategory _value, $Res Function(_$_PlaceCategory) _then)
      : super(_value, (v) => _then(v as _$_PlaceCategory));

  @override
  _$_PlaceCategory get _value => super._value as _$_PlaceCategory;

  @override
  $Res call({
    Object? groupCode = freezed,
    Object? groupName = freezed,
    Object? fullName = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_PlaceCategory(
      groupCode: groupCode == freezed
          ? _value.groupCode
          : groupCode // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaceCategory implements _PlaceCategory {
  _$_PlaceCategory(
      {required this.groupCode,
      required this.groupName,
      required this.fullName,
      this.name = ''});

  factory _$_PlaceCategory.fromJson(Map<String, dynamic> json) =>
      _$$_PlaceCategoryFromJson(json);

  @override
  final String groupCode;
  @override
  final String groupName;
  @override
  final String fullName;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'PlaceCategory(groupCode: $groupCode, groupName: $groupName, fullName: $fullName, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaceCategory &&
            const DeepCollectionEquality().equals(other.groupCode, groupCode) &&
            const DeepCollectionEquality().equals(other.groupName, groupName) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(groupCode),
      const DeepCollectionEquality().hash(groupName),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_PlaceCategoryCopyWith<_$_PlaceCategory> get copyWith =>
      __$$_PlaceCategoryCopyWithImpl<_$_PlaceCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaceCategoryToJson(this);
  }
}

abstract class _PlaceCategory implements PlaceCategory {
  factory _PlaceCategory(
      {required final String groupCode,
      required final String groupName,
      required final String fullName,
      final String name}) = _$_PlaceCategory;

  factory _PlaceCategory.fromJson(Map<String, dynamic> json) =
      _$_PlaceCategory.fromJson;

  @override
  String get groupCode => throw _privateConstructorUsedError;
  @override
  String get groupName => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PlaceCategoryCopyWith<_$_PlaceCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

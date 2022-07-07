// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  String get categoryName => throw _privateConstructorUsedError;
  int get step => throw _privateConstructorUsedError;
  List<Restaurant> get kakaoSearchResponseDtos =>
      throw _privateConstructorUsedError;
  List<Category> get subSteps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res>;
  $Res call(
      {String categoryName,
      int step,
      List<Restaurant> kakaoSearchResponseDtos,
      List<Category> subSteps});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res> implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  final Category _value;
  // ignore: unused_field
  final $Res Function(Category) _then;

  @override
  $Res call({
    Object? categoryName = freezed,
    Object? step = freezed,
    Object? kakaoSearchResponseDtos = freezed,
    Object? subSteps = freezed,
  }) {
    return _then(_value.copyWith(
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      step: step == freezed
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      kakaoSearchResponseDtos: kakaoSearchResponseDtos == freezed
          ? _value.kakaoSearchResponseDtos
          : kakaoSearchResponseDtos // ignore: cast_nullable_to_non_nullable
              as List<Restaurant>,
      subSteps: subSteps == freezed
          ? _value.subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc
abstract class _$$_CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$$_CategoryCopyWith(
          _$_Category value, $Res Function(_$_Category) then) =
      __$$_CategoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String categoryName,
      int step,
      List<Restaurant> kakaoSearchResponseDtos,
      List<Category> subSteps});
}

/// @nodoc
class __$$_CategoryCopyWithImpl<$Res> extends _$CategoryCopyWithImpl<$Res>
    implements _$$_CategoryCopyWith<$Res> {
  __$$_CategoryCopyWithImpl(
      _$_Category _value, $Res Function(_$_Category) _then)
      : super(_value, (v) => _then(v as _$_Category));

  @override
  _$_Category get _value => super._value as _$_Category;

  @override
  $Res call({
    Object? categoryName = freezed,
    Object? step = freezed,
    Object? kakaoSearchResponseDtos = freezed,
    Object? subSteps = freezed,
  }) {
    return _then(_$_Category(
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      step: step == freezed
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      kakaoSearchResponseDtos: kakaoSearchResponseDtos == freezed
          ? _value._kakaoSearchResponseDtos
          : kakaoSearchResponseDtos // ignore: cast_nullable_to_non_nullable
              as List<Restaurant>,
      subSteps: subSteps == freezed
          ? _value._subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Category implements _Category {
  _$_Category(
      {required this.categoryName,
      required this.step,
      final List<Restaurant> kakaoSearchResponseDtos = const [],
      final List<Category> subSteps = const []})
      : _kakaoSearchResponseDtos = kakaoSearchResponseDtos,
        _subSteps = subSteps;

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryFromJson(json);

  @override
  final String categoryName;
  @override
  final int step;
  final List<Restaurant> _kakaoSearchResponseDtos;
  @override
  @JsonKey()
  List<Restaurant> get kakaoSearchResponseDtos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kakaoSearchResponseDtos);
  }

  final List<Category> _subSteps;
  @override
  @JsonKey()
  List<Category> get subSteps {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subSteps);
  }

  @override
  String toString() {
    return 'Category(categoryName: $categoryName, step: $step, kakaoSearchResponseDtos: $kakaoSearchResponseDtos, subSteps: $subSteps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Category &&
            const DeepCollectionEquality()
                .equals(other.categoryName, categoryName) &&
            const DeepCollectionEquality().equals(other.step, step) &&
            const DeepCollectionEquality().equals(
                other._kakaoSearchResponseDtos, _kakaoSearchResponseDtos) &&
            const DeepCollectionEquality().equals(other._subSteps, _subSteps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(categoryName),
      const DeepCollectionEquality().hash(step),
      const DeepCollectionEquality().hash(_kakaoSearchResponseDtos),
      const DeepCollectionEquality().hash(_subSteps));

  @JsonKey(ignore: true)
  @override
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      __$$_CategoryCopyWithImpl<_$_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryToJson(this);
  }
}

abstract class _Category implements Category {
  factory _Category(
      {required final String categoryName,
      required final int step,
      final List<Restaurant> kakaoSearchResponseDtos,
      final List<Category> subSteps}) = _$_Category;

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  String get categoryName => throw _privateConstructorUsedError;
  @override
  int get step => throw _privateConstructorUsedError;
  @override
  List<Restaurant> get kakaoSearchResponseDtos =>
      throw _privateConstructorUsedError;
  @override
  List<Category> get subSteps => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      throw _privateConstructorUsedError;
}

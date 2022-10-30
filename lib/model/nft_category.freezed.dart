// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'nft_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NftCategory _$NftCategoryFromJson(Map<String, dynamic> json) {
  return _NftCategory.fromJson(json);
}

/// @nodoc
mixin _$NftCategory {
  int get id => throw _privateConstructorUsedError;
  dynamic get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NftCategoryCopyWith<NftCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftCategoryCopyWith<$Res> {
  factory $NftCategoryCopyWith(
          NftCategory value, $Res Function(NftCategory) then) =
      _$NftCategoryCopyWithImpl<$Res, NftCategory>;
  @useResult
  $Res call({int id, dynamic name, String image});
}

/// @nodoc
class _$NftCategoryCopyWithImpl<$Res, $Val extends NftCategory>
    implements $NftCategoryCopyWith<$Res> {
  _$NftCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NftCategoryCopyWith<$Res>
    implements $NftCategoryCopyWith<$Res> {
  factory _$$_NftCategoryCopyWith(
          _$_NftCategory value, $Res Function(_$_NftCategory) then) =
      __$$_NftCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, dynamic name, String image});
}

/// @nodoc
class __$$_NftCategoryCopyWithImpl<$Res>
    extends _$NftCategoryCopyWithImpl<$Res, _$_NftCategory>
    implements _$$_NftCategoryCopyWith<$Res> {
  __$$_NftCategoryCopyWithImpl(
      _$_NftCategory _value, $Res Function(_$_NftCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_$_NftCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name ? _value.name : name,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NftCategory extends _NftCategory {
  const _$_NftCategory({this.id = 0, this.name = '', this.image = ''})
      : super._();

  factory _$_NftCategory.fromJson(Map<String, dynamic> json) =>
      _$$_NftCategoryFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final dynamic name;
  @override
  @JsonKey()
  final String image;

  @override
  String toString() {
    return 'NftCategory(id: $id, name: $name, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NftCategory &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(name), image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NftCategoryCopyWith<_$_NftCategory> get copyWith =>
      __$$_NftCategoryCopyWithImpl<_$_NftCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NftCategoryToJson(
      this,
    );
  }
}

abstract class _NftCategory extends NftCategory {
  const factory _NftCategory(
      {final int id, final dynamic name, final String image}) = _$_NftCategory;
  const _NftCategory._() : super._();

  factory _NftCategory.fromJson(Map<String, dynamic> json) =
      _$_NftCategory.fromJson;

  @override
  int get id;
  @override
  dynamic get name;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_NftCategoryCopyWith<_$_NftCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

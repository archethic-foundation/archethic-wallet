// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenDTO _$TokenDTOFromJson(Map<String, dynamic> json) {
  return _TokenDTO.fromJson(json);
}

/// @nodoc
mixin _$TokenDTO {
// required String transactionLastAddress,
// required String accountSelectedName,
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  double get initialSupply => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenDTOCopyWith<TokenDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDTOCopyWith<$Res> {
  factory $TokenDTOCopyWith(TokenDTO value, $Res Function(TokenDTO) then) =
      _$TokenDTOCopyWithImpl<$Res, TokenDTO>;
  @useResult
  $Res call({String name, String symbol, double initialSupply, String type});
}

/// @nodoc
class _$TokenDTOCopyWithImpl<$Res, $Val extends TokenDTO>
    implements $TokenDTOCopyWith<$Res> {
  _$TokenDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? initialSupply = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      initialSupply: null == initialSupply
          ? _value.initialSupply
          : initialSupply // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenDTOCopyWith<$Res> implements $TokenDTOCopyWith<$Res> {
  factory _$$_TokenDTOCopyWith(
          _$_TokenDTO value, $Res Function(_$_TokenDTO) then) =
      __$$_TokenDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String symbol, double initialSupply, String type});
}

/// @nodoc
class __$$_TokenDTOCopyWithImpl<$Res>
    extends _$TokenDTOCopyWithImpl<$Res, _$_TokenDTO>
    implements _$$_TokenDTOCopyWith<$Res> {
  __$$_TokenDTOCopyWithImpl(
      _$_TokenDTO _value, $Res Function(_$_TokenDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? initialSupply = null,
    Object? type = null,
  }) {
    return _then(_$_TokenDTO(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      initialSupply: null == initialSupply
          ? _value.initialSupply
          : initialSupply // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenDTO extends _TokenDTO {
  const _$_TokenDTO(
      {required this.name,
      required this.symbol,
      required this.initialSupply,
      required this.type})
      : super._();

  factory _$_TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$$_TokenDTOFromJson(json);

// required String transactionLastAddress,
// required String accountSelectedName,
  @override
  final String name;
  @override
  final String symbol;
  @override
  final double initialSupply;
  @override
  final String type;

  @override
  String toString() {
    return 'TokenDTO(name: $name, symbol: $symbol, initialSupply: $initialSupply, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenDTO &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.initialSupply, initialSupply) ||
                other.initialSupply == initialSupply) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, symbol, initialSupply, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenDTOCopyWith<_$_TokenDTO> get copyWith =>
      __$$_TokenDTOCopyWithImpl<_$_TokenDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenDTOToJson(
      this,
    );
  }
}

abstract class _TokenDTO extends TokenDTO {
  const factory _TokenDTO(
      {required final String name,
      required final String symbol,
      required final double initialSupply,
      required final String type}) = _$_TokenDTO;
  const _TokenDTO._() : super._();

  factory _TokenDTO.fromJson(Map<String, dynamic> json) = _$_TokenDTO.fromJson;

  @override // required String transactionLastAddress,
// required String accountSelectedName,
  String get name;
  @override
  String get symbol;
  @override
  double get initialSupply;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_TokenDTOCopyWith<_$_TokenDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RPCUnsubscribeCommandDTO _$RPCUnsubscribeCommandDTOFromJson(
    Map<String, dynamic> json) {
  return _RPCUnsubscribeCommandDTO.fromJson(json);
}

/// @nodoc
mixin _$RPCUnsubscribeCommandDTO {
  String get subscriptionId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RPCUnsubscribeCommandDTOCopyWith<RPCUnsubscribeCommandDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCUnsubscribeCommandDTOCopyWith<$Res> {
  factory $RPCUnsubscribeCommandDTOCopyWith(RPCUnsubscribeCommandDTO value,
          $Res Function(RPCUnsubscribeCommandDTO) then) =
      _$RPCUnsubscribeCommandDTOCopyWithImpl<$Res, RPCUnsubscribeCommandDTO>;
  @useResult
  $Res call({String subscriptionId});
}

/// @nodoc
class _$RPCUnsubscribeCommandDTOCopyWithImpl<$Res,
        $Val extends RPCUnsubscribeCommandDTO>
    implements $RPCUnsubscribeCommandDTOCopyWith<$Res> {
  _$RPCUnsubscribeCommandDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
  }) {
    return _then(_value.copyWith(
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCUnsubscribeCommandDTOCopyWith<$Res>
    implements $RPCUnsubscribeCommandDTOCopyWith<$Res> {
  factory _$$_RPCUnsubscribeCommandDTOCopyWith(
          _$_RPCUnsubscribeCommandDTO value,
          $Res Function(_$_RPCUnsubscribeCommandDTO) then) =
      __$$_RPCUnsubscribeCommandDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subscriptionId});
}

/// @nodoc
class __$$_RPCUnsubscribeCommandDTOCopyWithImpl<$Res>
    extends _$RPCUnsubscribeCommandDTOCopyWithImpl<$Res,
        _$_RPCUnsubscribeCommandDTO>
    implements _$$_RPCUnsubscribeCommandDTOCopyWith<$Res> {
  __$$_RPCUnsubscribeCommandDTOCopyWithImpl(_$_RPCUnsubscribeCommandDTO _value,
      $Res Function(_$_RPCUnsubscribeCommandDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
  }) {
    return _then(_$_RPCUnsubscribeCommandDTO(
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RPCUnsubscribeCommandDTO extends _RPCUnsubscribeCommandDTO {
  const _$_RPCUnsubscribeCommandDTO({required this.subscriptionId}) : super._();

  factory _$_RPCUnsubscribeCommandDTO.fromJson(Map<String, dynamic> json) =>
      _$$_RPCUnsubscribeCommandDTOFromJson(json);

  @override
  final String subscriptionId;

  @override
  String toString() {
    return 'RPCUnsubscribeCommandDTO(subscriptionId: $subscriptionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCUnsubscribeCommandDTO &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, subscriptionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCUnsubscribeCommandDTOCopyWith<_$_RPCUnsubscribeCommandDTO>
      get copyWith => __$$_RPCUnsubscribeCommandDTOCopyWithImpl<
          _$_RPCUnsubscribeCommandDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RPCUnsubscribeCommandDTOToJson(
      this,
    );
  }
}

abstract class _RPCUnsubscribeCommandDTO extends RPCUnsubscribeCommandDTO {
  const factory _RPCUnsubscribeCommandDTO(
      {required final String subscriptionId}) = _$_RPCUnsubscribeCommandDTO;
  const _RPCUnsubscribeCommandDTO._() : super._();

  factory _RPCUnsubscribeCommandDTO.fromJson(Map<String, dynamic> json) =
      _$_RPCUnsubscribeCommandDTO.fromJson;

  @override
  String get subscriptionId;
  @override
  @JsonKey(ignore: true)
  _$$_RPCUnsubscribeCommandDTOCopyWith<_$_RPCUnsubscribeCommandDTO>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCSubscriptionDTO {
  String get id => throw _privateConstructorUsedError;
  Stream<Map<String, dynamic>> get updates =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSubscriptionDTOCopyWith<RPCSubscriptionDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSubscriptionDTOCopyWith<$Res> {
  factory $RPCSubscriptionDTOCopyWith(
          RPCSubscriptionDTO value, $Res Function(RPCSubscriptionDTO) then) =
      _$RPCSubscriptionDTOCopyWithImpl<$Res, RPCSubscriptionDTO>;
  @useResult
  $Res call({String id, Stream<Map<String, dynamic>> updates});
}

/// @nodoc
class _$RPCSubscriptionDTOCopyWithImpl<$Res, $Val extends RPCSubscriptionDTO>
    implements $RPCSubscriptionDTOCopyWith<$Res> {
  _$RPCSubscriptionDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updates = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Stream<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSubscriptionDTOCopyWith<$Res>
    implements $RPCSubscriptionDTOCopyWith<$Res> {
  factory _$$_RPCSubscriptionDTOCopyWith(_$_RPCSubscriptionDTO value,
          $Res Function(_$_RPCSubscriptionDTO) then) =
      __$$_RPCSubscriptionDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Stream<Map<String, dynamic>> updates});
}

/// @nodoc
class __$$_RPCSubscriptionDTOCopyWithImpl<$Res>
    extends _$RPCSubscriptionDTOCopyWithImpl<$Res, _$_RPCSubscriptionDTO>
    implements _$$_RPCSubscriptionDTOCopyWith<$Res> {
  __$$_RPCSubscriptionDTOCopyWithImpl(
      _$_RPCSubscriptionDTO _value, $Res Function(_$_RPCSubscriptionDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updates = null,
  }) {
    return _then(_$_RPCSubscriptionDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Stream<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$_RPCSubscriptionDTO extends _RPCSubscriptionDTO {
  const _$_RPCSubscriptionDTO({required this.id, required this.updates})
      : super._();

  @override
  final String id;
  @override
  final Stream<Map<String, dynamic>> updates;

  @override
  String toString() {
    return 'RPCSubscriptionDTO(id: $id, updates: $updates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSubscriptionDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updates, updates) || other.updates == updates));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, updates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSubscriptionDTOCopyWith<_$_RPCSubscriptionDTO> get copyWith =>
      __$$_RPCSubscriptionDTOCopyWithImpl<_$_RPCSubscriptionDTO>(
          this, _$identity);
}

abstract class _RPCSubscriptionDTO extends RPCSubscriptionDTO {
  const factory _RPCSubscriptionDTO(
          {required final String id,
          required final Stream<Map<String, dynamic>> updates}) =
      _$_RPCSubscriptionDTO;
  const _RPCSubscriptionDTO._() : super._();

  @override
  String get id;
  @override
  Stream<Map<String, dynamic>> get updates;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSubscriptionDTOCopyWith<_$_RPCSubscriptionDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

RPCSubscriptionUpdateDTO _$RPCSubscriptionUpdateDTOFromJson(
    Map<String, dynamic> json) {
  return _RPCSubscriptionUpdateDTO.fromJson(json);
}

/// @nodoc
mixin _$RPCSubscriptionUpdateDTO {
  String get subscriptionId => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RPCSubscriptionUpdateDTOCopyWith<RPCSubscriptionUpdateDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSubscriptionUpdateDTOCopyWith<$Res> {
  factory $RPCSubscriptionUpdateDTOCopyWith(RPCSubscriptionUpdateDTO value,
          $Res Function(RPCSubscriptionUpdateDTO) then) =
      _$RPCSubscriptionUpdateDTOCopyWithImpl<$Res, RPCSubscriptionUpdateDTO>;
  @useResult
  $Res call({String subscriptionId, Map<String, dynamic> data});
}

/// @nodoc
class _$RPCSubscriptionUpdateDTOCopyWithImpl<$Res,
        $Val extends RPCSubscriptionUpdateDTO>
    implements $RPCSubscriptionUpdateDTOCopyWith<$Res> {
  _$RPCSubscriptionUpdateDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSubscriptionUpdateDTOCopyWith<$Res>
    implements $RPCSubscriptionUpdateDTOCopyWith<$Res> {
  factory _$$_RPCSubscriptionUpdateDTOCopyWith(
          _$_RPCSubscriptionUpdateDTO value,
          $Res Function(_$_RPCSubscriptionUpdateDTO) then) =
      __$$_RPCSubscriptionUpdateDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subscriptionId, Map<String, dynamic> data});
}

/// @nodoc
class __$$_RPCSubscriptionUpdateDTOCopyWithImpl<$Res>
    extends _$RPCSubscriptionUpdateDTOCopyWithImpl<$Res,
        _$_RPCSubscriptionUpdateDTO>
    implements _$$_RPCSubscriptionUpdateDTOCopyWith<$Res> {
  __$$_RPCSubscriptionUpdateDTOCopyWithImpl(_$_RPCSubscriptionUpdateDTO _value,
      $Res Function(_$_RPCSubscriptionUpdateDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? data = null,
  }) {
    return _then(_$_RPCSubscriptionUpdateDTO(
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RPCSubscriptionUpdateDTO extends _RPCSubscriptionUpdateDTO {
  const _$_RPCSubscriptionUpdateDTO(
      {required this.subscriptionId, required final Map<String, dynamic> data})
      : _data = data,
        super._();

  factory _$_RPCSubscriptionUpdateDTO.fromJson(Map<String, dynamic> json) =>
      _$$_RPCSubscriptionUpdateDTOFromJson(json);

  @override
  final String subscriptionId;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'RPCSubscriptionUpdateDTO(subscriptionId: $subscriptionId, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSubscriptionUpdateDTO &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, subscriptionId, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSubscriptionUpdateDTOCopyWith<_$_RPCSubscriptionUpdateDTO>
      get copyWith => __$$_RPCSubscriptionUpdateDTOCopyWithImpl<
          _$_RPCSubscriptionUpdateDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RPCSubscriptionUpdateDTOToJson(
      this,
    );
  }
}

abstract class _RPCSubscriptionUpdateDTO extends RPCSubscriptionUpdateDTO {
  const factory _RPCSubscriptionUpdateDTO(
      {required final String subscriptionId,
      required final Map<String, dynamic> data}) = _$_RPCSubscriptionUpdateDTO;
  const _RPCSubscriptionUpdateDTO._() : super._();

  factory _RPCSubscriptionUpdateDTO.fromJson(Map<String, dynamic> json) =
      _$_RPCSubscriptionUpdateDTO.fromJson;

  @override
  String get subscriptionId;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSubscriptionUpdateDTOCopyWith<_$_RPCSubscriptionUpdateDTO>
      get copyWith => throw _privateConstructorUsedError;
}

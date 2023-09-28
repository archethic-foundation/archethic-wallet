// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationsSetup {
  @HiveField(0, defaultValue: [])
  List<String> get listenedAddresses => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get lastFcmToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationsSetupCopyWith<NotificationsSetup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsSetupCopyWith<$Res> {
  factory $NotificationsSetupCopyWith(
          NotificationsSetup value, $Res Function(NotificationsSetup) then) =
      _$NotificationsSetupCopyWithImpl<$Res, NotificationsSetup>;
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: []) List<String> listenedAddresses,
      @HiveField(1) String? lastFcmToken});
}

/// @nodoc
class _$NotificationsSetupCopyWithImpl<$Res, $Val extends NotificationsSetup>
    implements $NotificationsSetupCopyWith<$Res> {
  _$NotificationsSetupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listenedAddresses = null,
    Object? lastFcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      listenedAddresses: null == listenedAddresses
          ? _value.listenedAddresses
          : listenedAddresses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastFcmToken: freezed == lastFcmToken
          ? _value.lastFcmToken
          : lastFcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsSetupImplCopyWith<$Res>
    implements $NotificationsSetupCopyWith<$Res> {
  factory _$$NotificationsSetupImplCopyWith(_$NotificationsSetupImpl value,
          $Res Function(_$NotificationsSetupImpl) then) =
      __$$NotificationsSetupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: []) List<String> listenedAddresses,
      @HiveField(1) String? lastFcmToken});
}

/// @nodoc
class __$$NotificationsSetupImplCopyWithImpl<$Res>
    extends _$NotificationsSetupCopyWithImpl<$Res, _$NotificationsSetupImpl>
    implements _$$NotificationsSetupImplCopyWith<$Res> {
  __$$NotificationsSetupImplCopyWithImpl(_$NotificationsSetupImpl _value,
      $Res Function(_$NotificationsSetupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listenedAddresses = null,
    Object? lastFcmToken = freezed,
  }) {
    return _then(_$NotificationsSetupImpl(
      listenedAddresses: null == listenedAddresses
          ? _value._listenedAddresses
          : listenedAddresses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastFcmToken: freezed == lastFcmToken
          ? _value.lastFcmToken
          : lastFcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.notificationsSetup)
class _$NotificationsSetupImpl extends _NotificationsSetup {
  const _$NotificationsSetupImpl(
      {@HiveField(0, defaultValue: [])
      required final List<String> listenedAddresses,
      @HiveField(1) this.lastFcmToken})
      : _listenedAddresses = listenedAddresses,
        super._();

  final List<String> _listenedAddresses;
  @override
  @HiveField(0, defaultValue: [])
  List<String> get listenedAddresses {
    if (_listenedAddresses is EqualUnmodifiableListView)
      return _listenedAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listenedAddresses);
  }

  @override
  @HiveField(1)
  final String? lastFcmToken;

  @override
  String toString() {
    return 'NotificationsSetup(listenedAddresses: $listenedAddresses, lastFcmToken: $lastFcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsSetupImpl &&
            const DeepCollectionEquality()
                .equals(other._listenedAddresses, _listenedAddresses) &&
            (identical(other.lastFcmToken, lastFcmToken) ||
                other.lastFcmToken == lastFcmToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_listenedAddresses), lastFcmToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsSetupImplCopyWith<_$NotificationsSetupImpl> get copyWith =>
      __$$NotificationsSetupImplCopyWithImpl<_$NotificationsSetupImpl>(
          this, _$identity);
}

abstract class _NotificationsSetup extends NotificationsSetup {
  const factory _NotificationsSetup(
      {@HiveField(0, defaultValue: [])
      required final List<String> listenedAddresses,
      @HiveField(1) final String? lastFcmToken}) = _$NotificationsSetupImpl;
  const _NotificationsSetup._() : super._();

  @override
  @HiveField(0, defaultValue: [])
  List<String> get listenedAddresses;
  @override
  @HiveField(1)
  String? get lastFcmToken;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsSetupImplCopyWith<_$NotificationsSetupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

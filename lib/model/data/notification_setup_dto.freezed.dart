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
  List<String> get listenedTxChains => throw _privateConstructorUsedError;
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
      {@HiveField(0, defaultValue: []) List<String> listenedTxChains,
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
    Object? listenedTxChains = null,
    Object? lastFcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      listenedTxChains: null == listenedTxChains
          ? _value.listenedTxChains
          : listenedTxChains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastFcmToken: freezed == lastFcmToken
          ? _value.lastFcmToken
          : lastFcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotificationsSetupCopyWith<$Res>
    implements $NotificationsSetupCopyWith<$Res> {
  factory _$$_NotificationsSetupCopyWith(_$_NotificationsSetup value,
          $Res Function(_$_NotificationsSetup) then) =
      __$$_NotificationsSetupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: []) List<String> listenedTxChains,
      @HiveField(1) String? lastFcmToken});
}

/// @nodoc
class __$$_NotificationsSetupCopyWithImpl<$Res>
    extends _$NotificationsSetupCopyWithImpl<$Res, _$_NotificationsSetup>
    implements _$$_NotificationsSetupCopyWith<$Res> {
  __$$_NotificationsSetupCopyWithImpl(
      _$_NotificationsSetup _value, $Res Function(_$_NotificationsSetup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listenedTxChains = null,
    Object? lastFcmToken = freezed,
  }) {
    return _then(_$_NotificationsSetup(
      listenedTxChains: null == listenedTxChains
          ? _value._listenedTxChains
          : listenedTxChains // ignore: cast_nullable_to_non_nullable
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
class _$_NotificationsSetup extends _NotificationsSetup {
  const _$_NotificationsSetup(
      {@HiveField(0, defaultValue: [])
          required final List<String> listenedTxChains,
      @HiveField(1)
          this.lastFcmToken})
      : _listenedTxChains = listenedTxChains,
        super._();

  final List<String> _listenedTxChains;
  @override
  @HiveField(0, defaultValue: [])
  List<String> get listenedTxChains {
    if (_listenedTxChains is EqualUnmodifiableListView)
      return _listenedTxChains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listenedTxChains);
  }

  @override
  @HiveField(1)
  final String? lastFcmToken;

  @override
  String toString() {
    return 'NotificationsSetup(listenedTxChains: $listenedTxChains, lastFcmToken: $lastFcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationsSetup &&
            const DeepCollectionEquality()
                .equals(other._listenedTxChains, _listenedTxChains) &&
            (identical(other.lastFcmToken, lastFcmToken) ||
                other.lastFcmToken == lastFcmToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_listenedTxChains), lastFcmToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationsSetupCopyWith<_$_NotificationsSetup> get copyWith =>
      __$$_NotificationsSetupCopyWithImpl<_$_NotificationsSetup>(
          this, _$identity);
}

abstract class _NotificationsSetup extends NotificationsSetup {
  const factory _NotificationsSetup(
      {@HiveField(0, defaultValue: [])
          required final List<String> listenedTxChains,
      @HiveField(1)
          final String? lastFcmToken}) = _$_NotificationsSetup;
  const _NotificationsSetup._() : super._();

  @override
  @HiveField(0, defaultValue: [])
  List<String> get listenedTxChains;
  @override
  @HiveField(1)
  String? get lastFcmToken;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationsSetupCopyWith<_$_NotificationsSetup> get copyWith =>
      throw _privateConstructorUsedError;
}

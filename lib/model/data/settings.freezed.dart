// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Settings {
  AuthMethod get authenticationMethod => throw _privateConstructorUsedError;
  AvailableCurrencyEnum get currency => throw _privateConstructorUsedError;
  AvailablePrimaryCurrency get primaryCurrency =>
      throw _privateConstructorUsedError;
  AvailableLanguage get language => throw _privateConstructorUsedError;
  AvailableNetworks get networks => throw _privateConstructorUsedError;
  String get languageSeed => throw _privateConstructorUsedError;
  bool get firstLaunch => throw _privateConstructorUsedError;
  bool get pinPadShuffle => throw _privateConstructorUsedError;
  bool get showBalances => throw _privateConstructorUsedError;
  bool get showBlog => throw _privateConstructorUsedError;
  bool get activeVibrations => throw _privateConstructorUsedError;
  bool get activeNotifications => throw _privateConstructorUsedError;
  int get mainScreenCurrentPage =>
      throw _privateConstructorUsedError; // TODO(Chralu): not shure it belongs here
  bool get showPriceChart => throw _privateConstructorUsedError;
  UnlockOption get lock =>
      throw _privateConstructorUsedError; // TODO(Chralu): create a notifier dedicated to Lock management
  LockTimeoutOption get lockTimeout => throw _privateConstructorUsedError;
  int get lockAttempts => throw _privateConstructorUsedError;
  DateTime? get pinLockUntil => throw _privateConstructorUsedError;
  ThemeOptions get theme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
  $Res call(
      {AuthMethod authenticationMethod,
      AvailableCurrencyEnum currency,
      AvailablePrimaryCurrency primaryCurrency,
      AvailableLanguage language,
      AvailableNetworks networks,
      String languageSeed,
      bool firstLaunch,
      bool pinPadShuffle,
      bool showBalances,
      bool showBlog,
      bool activeVibrations,
      bool activeNotifications,
      int mainScreenCurrentPage,
      bool showPriceChart,
      UnlockOption lock,
      LockTimeoutOption lockTimeout,
      int lockAttempts,
      DateTime? pinLockUntil,
      ThemeOptions theme});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  final Settings _value;
  // ignore: unused_field
  final $Res Function(Settings) _then;

  @override
  $Res call({
    Object? authenticationMethod = freezed,
    Object? currency = freezed,
    Object? primaryCurrency = freezed,
    Object? language = freezed,
    Object? networks = freezed,
    Object? languageSeed = freezed,
    Object? firstLaunch = freezed,
    Object? pinPadShuffle = freezed,
    Object? showBalances = freezed,
    Object? showBlog = freezed,
    Object? activeVibrations = freezed,
    Object? activeNotifications = freezed,
    Object? mainScreenCurrentPage = freezed,
    Object? showPriceChart = freezed,
    Object? lock = freezed,
    Object? lockTimeout = freezed,
    Object? lockAttempts = freezed,
    Object? pinLockUntil = freezed,
    Object? theme = freezed,
  }) {
    return _then(_value.copyWith(
      authenticationMethod: authenticationMethod == freezed
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as AvailableCurrencyEnum,
      primaryCurrency: primaryCurrency == freezed
          ? _value.primaryCurrency
          : primaryCurrency // ignore: cast_nullable_to_non_nullable
              as AvailablePrimaryCurrency,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as AvailableLanguage,
      networks: networks == freezed
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as AvailableNetworks,
      languageSeed: languageSeed == freezed
          ? _value.languageSeed
          : languageSeed // ignore: cast_nullable_to_non_nullable
              as String,
      firstLaunch: firstLaunch == freezed
          ? _value.firstLaunch
          : firstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      pinPadShuffle: pinPadShuffle == freezed
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      showBalances: showBalances == freezed
          ? _value.showBalances
          : showBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      showBlog: showBlog == freezed
          ? _value.showBlog
          : showBlog // ignore: cast_nullable_to_non_nullable
              as bool,
      activeVibrations: activeVibrations == freezed
          ? _value.activeVibrations
          : activeVibrations // ignore: cast_nullable_to_non_nullable
              as bool,
      activeNotifications: activeNotifications == freezed
          ? _value.activeNotifications
          : activeNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      mainScreenCurrentPage: mainScreenCurrentPage == freezed
          ? _value.mainScreenCurrentPage
          : mainScreenCurrentPage // ignore: cast_nullable_to_non_nullable
              as int,
      showPriceChart: showPriceChart == freezed
          ? _value.showPriceChart
          : showPriceChart // ignore: cast_nullable_to_non_nullable
              as bool,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as UnlockOption,
      lockTimeout: lockTimeout == freezed
          ? _value.lockTimeout
          : lockTimeout // ignore: cast_nullable_to_non_nullable
              as LockTimeoutOption,
      lockAttempts: lockAttempts == freezed
          ? _value.lockAttempts
          : lockAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      pinLockUntil: pinLockUntil == freezed
          ? _value.pinLockUntil
          : pinLockUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeOptions,
    ));
  }
}

/// @nodoc
abstract class _$$_SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$_SettingsCopyWith(
          _$_Settings value, $Res Function(_$_Settings) then) =
      __$$_SettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {AuthMethod authenticationMethod,
      AvailableCurrencyEnum currency,
      AvailablePrimaryCurrency primaryCurrency,
      AvailableLanguage language,
      AvailableNetworks networks,
      String languageSeed,
      bool firstLaunch,
      bool pinPadShuffle,
      bool showBalances,
      bool showBlog,
      bool activeVibrations,
      bool activeNotifications,
      int mainScreenCurrentPage,
      bool showPriceChart,
      UnlockOption lock,
      LockTimeoutOption lockTimeout,
      int lockAttempts,
      DateTime? pinLockUntil,
      ThemeOptions theme});
}

/// @nodoc
class __$$_SettingsCopyWithImpl<$Res> extends _$SettingsCopyWithImpl<$Res>
    implements _$$_SettingsCopyWith<$Res> {
  __$$_SettingsCopyWithImpl(
      _$_Settings _value, $Res Function(_$_Settings) _then)
      : super(_value, (v) => _then(v as _$_Settings));

  @override
  _$_Settings get _value => super._value as _$_Settings;

  @override
  $Res call({
    Object? authenticationMethod = freezed,
    Object? currency = freezed,
    Object? primaryCurrency = freezed,
    Object? language = freezed,
    Object? networks = freezed,
    Object? languageSeed = freezed,
    Object? firstLaunch = freezed,
    Object? pinPadShuffle = freezed,
    Object? showBalances = freezed,
    Object? showBlog = freezed,
    Object? activeVibrations = freezed,
    Object? activeNotifications = freezed,
    Object? mainScreenCurrentPage = freezed,
    Object? showPriceChart = freezed,
    Object? lock = freezed,
    Object? lockTimeout = freezed,
    Object? lockAttempts = freezed,
    Object? pinLockUntil = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_Settings(
      authenticationMethod: authenticationMethod == freezed
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as AvailableCurrencyEnum,
      primaryCurrency: primaryCurrency == freezed
          ? _value.primaryCurrency
          : primaryCurrency // ignore: cast_nullable_to_non_nullable
              as AvailablePrimaryCurrency,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as AvailableLanguage,
      networks: networks == freezed
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as AvailableNetworks,
      languageSeed: languageSeed == freezed
          ? _value.languageSeed
          : languageSeed // ignore: cast_nullable_to_non_nullable
              as String,
      firstLaunch: firstLaunch == freezed
          ? _value.firstLaunch
          : firstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      pinPadShuffle: pinPadShuffle == freezed
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      showBalances: showBalances == freezed
          ? _value.showBalances
          : showBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      showBlog: showBlog == freezed
          ? _value.showBlog
          : showBlog // ignore: cast_nullable_to_non_nullable
              as bool,
      activeVibrations: activeVibrations == freezed
          ? _value.activeVibrations
          : activeVibrations // ignore: cast_nullable_to_non_nullable
              as bool,
      activeNotifications: activeNotifications == freezed
          ? _value.activeNotifications
          : activeNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      mainScreenCurrentPage: mainScreenCurrentPage == freezed
          ? _value.mainScreenCurrentPage
          : mainScreenCurrentPage // ignore: cast_nullable_to_non_nullable
              as int,
      showPriceChart: showPriceChart == freezed
          ? _value.showPriceChart
          : showPriceChart // ignore: cast_nullable_to_non_nullable
              as bool,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as UnlockOption,
      lockTimeout: lockTimeout == freezed
          ? _value.lockTimeout
          : lockTimeout // ignore: cast_nullable_to_non_nullable
              as LockTimeoutOption,
      lockAttempts: lockAttempts == freezed
          ? _value.lockAttempts
          : lockAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      pinLockUntil: pinLockUntil == freezed
          ? _value.pinLockUntil
          : pinLockUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeOptions,
    ));
  }
}

/// @nodoc

class _$_Settings extends _Settings {
  const _$_Settings(
      {required this.authenticationMethod,
      required this.currency,
      required this.primaryCurrency,
      required this.language,
      required this.networks,
      required this.languageSeed,
      required this.firstLaunch,
      required this.pinPadShuffle,
      required this.showBalances,
      required this.showBlog,
      required this.activeVibrations,
      required this.activeNotifications,
      required this.mainScreenCurrentPage,
      required this.showPriceChart,
      required this.lock,
      required this.lockTimeout,
      required this.lockAttempts,
      this.pinLockUntil,
      required this.theme})
      : super._();

  @override
  final AuthMethod authenticationMethod;
  @override
  final AvailableCurrencyEnum currency;
  @override
  final AvailablePrimaryCurrency primaryCurrency;
  @override
  final AvailableLanguage language;
  @override
  final AvailableNetworks networks;
  @override
  final String languageSeed;
  @override
  final bool firstLaunch;
  @override
  final bool pinPadShuffle;
  @override
  final bool showBalances;
  @override
  final bool showBlog;
  @override
  final bool activeVibrations;
  @override
  final bool activeNotifications;
  @override
  final int mainScreenCurrentPage;
// TODO(Chralu): not shure it belongs here
  @override
  final bool showPriceChart;
  @override
  final UnlockOption lock;
// TODO(Chralu): create a notifier dedicated to Lock management
  @override
  final LockTimeoutOption lockTimeout;
  @override
  final int lockAttempts;
  @override
  final DateTime? pinLockUntil;
  @override
  final ThemeOptions theme;

  @override
  String toString() {
    return 'Settings(authenticationMethod: $authenticationMethod, currency: $currency, primaryCurrency: $primaryCurrency, language: $language, networks: $networks, languageSeed: $languageSeed, firstLaunch: $firstLaunch, pinPadShuffle: $pinPadShuffle, showBalances: $showBalances, showBlog: $showBlog, activeVibrations: $activeVibrations, activeNotifications: $activeNotifications, mainScreenCurrentPage: $mainScreenCurrentPage, showPriceChart: $showPriceChart, lock: $lock, lockTimeout: $lockTimeout, lockAttempts: $lockAttempts, pinLockUntil: $pinLockUntil, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Settings &&
            const DeepCollectionEquality()
                .equals(other.authenticationMethod, authenticationMethod) &&
            const DeepCollectionEquality().equals(other.currency, currency) &&
            const DeepCollectionEquality()
                .equals(other.primaryCurrency, primaryCurrency) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            const DeepCollectionEquality()
                .equals(other.languageSeed, languageSeed) &&
            const DeepCollectionEquality()
                .equals(other.firstLaunch, firstLaunch) &&
            const DeepCollectionEquality()
                .equals(other.pinPadShuffle, pinPadShuffle) &&
            const DeepCollectionEquality()
                .equals(other.showBalances, showBalances) &&
            const DeepCollectionEquality().equals(other.showBlog, showBlog) &&
            const DeepCollectionEquality()
                .equals(other.activeVibrations, activeVibrations) &&
            const DeepCollectionEquality()
                .equals(other.activeNotifications, activeNotifications) &&
            const DeepCollectionEquality()
                .equals(other.mainScreenCurrentPage, mainScreenCurrentPage) &&
            const DeepCollectionEquality()
                .equals(other.showPriceChart, showPriceChart) &&
            const DeepCollectionEquality().equals(other.lock, lock) &&
            const DeepCollectionEquality()
                .equals(other.lockTimeout, lockTimeout) &&
            const DeepCollectionEquality()
                .equals(other.lockAttempts, lockAttempts) &&
            const DeepCollectionEquality()
                .equals(other.pinLockUntil, pinLockUntil) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(authenticationMethod),
        const DeepCollectionEquality().hash(currency),
        const DeepCollectionEquality().hash(primaryCurrency),
        const DeepCollectionEquality().hash(language),
        const DeepCollectionEquality().hash(networks),
        const DeepCollectionEquality().hash(languageSeed),
        const DeepCollectionEquality().hash(firstLaunch),
        const DeepCollectionEquality().hash(pinPadShuffle),
        const DeepCollectionEquality().hash(showBalances),
        const DeepCollectionEquality().hash(showBlog),
        const DeepCollectionEquality().hash(activeVibrations),
        const DeepCollectionEquality().hash(activeNotifications),
        const DeepCollectionEquality().hash(mainScreenCurrentPage),
        const DeepCollectionEquality().hash(showPriceChart),
        const DeepCollectionEquality().hash(lock),
        const DeepCollectionEquality().hash(lockTimeout),
        const DeepCollectionEquality().hash(lockAttempts),
        const DeepCollectionEquality().hash(pinLockUntil),
        const DeepCollectionEquality().hash(theme)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      __$$_SettingsCopyWithImpl<_$_Settings>(this, _$identity);
}

abstract class _Settings extends Settings {
  const factory _Settings(
      {required final AuthMethod authenticationMethod,
      required final AvailableCurrencyEnum currency,
      required final AvailablePrimaryCurrency primaryCurrency,
      required final AvailableLanguage language,
      required final AvailableNetworks networks,
      required final String languageSeed,
      required final bool firstLaunch,
      required final bool pinPadShuffle,
      required final bool showBalances,
      required final bool showBlog,
      required final bool activeVibrations,
      required final bool activeNotifications,
      required final int mainScreenCurrentPage,
      required final bool showPriceChart,
      required final UnlockOption lock,
      required final LockTimeoutOption lockTimeout,
      required final int lockAttempts,
      final DateTime? pinLockUntil,
      required final ThemeOptions theme}) = _$_Settings;
  const _Settings._() : super._();

  @override
  AuthMethod get authenticationMethod;
  @override
  AvailableCurrencyEnum get currency;
  @override
  AvailablePrimaryCurrency get primaryCurrency;
  @override
  AvailableLanguage get language;
  @override
  AvailableNetworks get networks;
  @override
  String get languageSeed;
  @override
  bool get firstLaunch;
  @override
  bool get pinPadShuffle;
  @override
  bool get showBalances;
  @override
  bool get showBlog;
  @override
  bool get activeVibrations;
  @override
  bool get activeNotifications;
  @override
  int get mainScreenCurrentPage;
  @override // TODO(Chralu): not shure it belongs here
  bool get showPriceChart;
  @override
  UnlockOption get lock;
  @override // TODO(Chralu): create a notifier dedicated to Lock management
  LockTimeoutOption get lockTimeout;
  @override
  int get lockAttempts;
  @override
  DateTime? get pinLockUntil;
  @override
  ThemeOptions get theme;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

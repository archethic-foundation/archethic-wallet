import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required AuthMethod authenticationMethod,
    required AvailableCurrencyEnum currency,
    required AvailablePrimaryCurrency primaryCurrency,
    required AvailableLanguage language,
    required AvailableNetworks networks,
    required String languageSeed,
    required bool firstLaunch,
    required bool pinPadShuffle,
    required bool showBalances,
    required bool showBlog,
    required bool activeVibrations,
    required bool activeNotifications,
    required int mainScreenCurrentPage, // TODO(Chralu): not shure it belongs here
    required bool showPriceChart,
    required UnlockOption lock, // TODO(Chralu): create a notifier dedicated to Lock management
    required LockTimeoutOption lockTimeout,
    required int lockAttempts,
    DateTime? pinLockUntil,
    required ThemeOptions theme,
  }) = _Settings;

  const Settings._();
}

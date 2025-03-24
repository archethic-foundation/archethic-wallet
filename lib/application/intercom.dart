import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intercom.g.dart';

@riverpod
bool isIntercomEnabled(Ref ref) {
  return UniversalPlatform.isAndroid || UniversalPlatform.isIOS;
}

@riverpod
Future<bool> isIntercomConnected(Ref ref) async {
  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    return Intercom.instance.isUserLoggedIn();
  }
  return false;
}

@riverpod
Future<void> connectIntercom(Ref ref) async {
  final isIntercomConnected =
      await ref.watch(isIntercomConnectedProvider.future);
  if (isIntercomConnected) return;

  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    const appId = String.fromEnvironment('INTERCOM_APP_ID');
    const androidKey = String.fromEnvironment('INTERCOM_ANDROID_KEY');
    const iOSKey = String.fromEnvironment('INTERCOM_IOS_KEY');

    await Intercom.instance
        .initialize(appId, iosApiKey: iOSKey, androidApiKey: androidKey);
    await Intercom.instance.setLauncherVisibility(IntercomVisibility.gone);
    await Intercom.instance.loginUnidentifiedUser();
  }
}

@riverpod
Future<void> disconnectIntercom(Ref ref) async {
  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    await Intercom.instance.logout();
  }
}

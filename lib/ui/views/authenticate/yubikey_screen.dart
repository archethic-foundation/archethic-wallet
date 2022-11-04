/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/bus/otp_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yubidart/yubidart.dart';

class YubikeyScreen extends ConsumerStatefulWidget {
  const YubikeyScreen({
    super.key,
    required this.canNavigateBack,
  });

  final bool canNavigateBack;

  @override
  ConsumerState<YubikeyScreen> createState() => _YubikeyScreenState();
}

class _YubikeyScreenState extends ConsumerState<YubikeyScreen> {
  StreamSubscription<OTPReceiveEvent>? _otpReceiveSub;

  double buttonSize = 100;

  VerificationResponse verificationResponse = VerificationResponse();

  FocusNode? enterOTPFocusNode;
  TextEditingController? enterOTPController;
  String buttonNFCLabel = 'get my OTP via NFC';
  bool isNFCAvailable = false;

  @override
  void initState() {
    super.initState();
    _registerBus();

    enterOTPFocusNode = FocusNode();
    enterOTPController = TextEditingController();

    sl.get<NFCUtil>().hasNFC().then((bool hasNFC) {
      setState(() {
        isNFCAvailable = hasNFC;
      });
    });
  }

  void _registerBus() {
    _otpReceiveSub = EventTaxiImpl.singleton()
        .registerTo<OTPReceiveEvent>()
        .listen((OTPReceiveEvent event) {
      setState(() {
        buttonNFCLabel = 'get my OTP via NFC';
      });
      _verifyOTP(event.otp!);
    });
  }

  @override
  void dispose() {
    _otpReceiveSub?.cancel();

    super.dispose();
  }

  Future<void> _verifyOTP(String otp) async {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    // TODO(chralu): utilisation provider ?
    final preferences = await Preferences.getInstance();
    final vault = await Vault.getInstance();
    final yubikeyClientAPIKey = vault.getYubikeyClientAPIKey();
    final yubikeyClientID = vault.getYubikeyClientID();
    verificationResponse = await YubicoService()
        .verifyYubiCloudOTP(otp, yubikeyClientAPIKey, yubikeyClientID);
    switch (verificationResponse.status) {
      case 'BAD_OTP':
        UIUtil.showSnackbar(
          localizations.yubikeyError_BAD_OTP,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'BACKEND_ERROR':
        UIUtil.showSnackbar(
          localizations.yubikeyError_BACKEND_ERROR,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'BAD_SIGNATURE':
        UIUtil.showSnackbar(
          localizations.yubikeyError_BAD_SIGNATURE,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'MISSING_PARAMETER':
        UIUtil.showSnackbar(
          localizations.yubikeyError_MISSING_PARAMETER,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'NOT_ENOUGH_ANSWERS':
        UIUtil.showSnackbar(
          localizations.yubikeyError_NOT_ENOUGH_ANSWERS,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'NO_SUCH_CLIENT':
        UIUtil.showSnackbar(
          localizations.yubikeyError_NO_SUCH_CLIENT,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'OPERATION_NOT_ALLOWED':
        UIUtil.showSnackbar(
          localizations.yubikeyError_OPERATION_NOT_ALLOWED,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'REPLAYED_OTP':
        UIUtil.showSnackbar(
          localizations.yubikeyError_REPLAYED_OTP,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'REPLAYED_REQUEST':
        UIUtil.showSnackbar(
          localizations.yubikeyError_REPLAYED_REQUEST,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'RESPONSE_KO':
        UIUtil.showSnackbar(
          localizations.yubikeyError_RESPONSE_KO,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
      case 'OK':
        UIUtil.showSnackbar(
          verificationResponse.status,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        preferences.resetLockAttempts();
        Navigator.of(context).pop(true);
        break;
      default:
        UIUtil.showSnackbar(
          verificationResponse.status,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return WillPopScope(
      onWillPop: () async => widget.canNavigateBack,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                theme.background5Small!,
              ),
              fit: BoxFit.fitHeight,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[theme.backgroundDark!, theme.background!],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.06,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 15),
                            height: 50,
                            width: 50,
                            child: widget.canNavigateBack
                                ? BackButton(
                                    key: const Key('back'),
                                    color: theme.text,
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: AutoSizeText(
                    'OTP',
                    style: theme.textStyleSize16W400Primary,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                ),
                if (isNFCAvailable)
                  ElevatedButton(
                    child: Text(
                      buttonNFCLabel,
                      style: theme.textStyleSize16W200Primary,
                    ),
                    onPressed: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      setState(() {
                        buttonNFCLabel =
                            localizations.yubikeyConnectHoldNearDevice;
                      });
                      await _tagRead();
                    },
                  )
                else
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: AutoSizeText(
                      localizations.yubikeyConnectInvite,
                      style: theme.textStyleSize16W200Primary,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ),
                if (isNFCAvailable)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  )
                else
                  AppTextField(
                    topMargin: 30,
                    maxLines: 3,
                    padding: const EdgeInsetsDirectional.only(
                      start: 16,
                      end: 16,
                    ),
                    focusNode: enterOTPFocusNode,
                    controller: enterOTPController,
                    textInputAction: TextInputAction.go,
                    autofocus: true,
                    onSubmitted: (value) async {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (String value) async {
                      if (value.trim().length == 44) {
                        EventTaxiImpl.singleton()
                            .fire(OTPReceiveEvent(otp: value));
                      }
                    },
                    inputFormatters: <LengthLimitingTextInputFormatter>[
                      LengthLimitingTextInputFormatter(45),
                    ],
                    keyboardType: TextInputType.text,
                    style: theme.textStyleSize16W600Primary,
                    suffixButton: TextFieldButton(
                      icon: FontAwesomeIcons.paste,
                      onPressed: () {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        Clipboard.getData('text/plain')
                            .then((ClipboardData? data) async {
                          if (data == null || data.text == null) {
                            return;
                          }
                          enterOTPController!.text = data.text!;
                          EventTaxiImpl.singleton().fire(
                            OTPReceiveEvent(
                              otp: enterOTPController!.text,
                            ),
                          );
                        });
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tagRead() async {
    await sl.get<NFCUtil>().authenticateWithNFCYubikey(context);
  }
}

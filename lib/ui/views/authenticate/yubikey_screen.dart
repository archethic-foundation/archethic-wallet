/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

// Project imports:
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/bus/otp_event.dart';
import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class YubikeyScreen extends ConsumerStatefulWidget {
  const YubikeyScreen({
    super.key,
    required this.canNavigateBack,
  });

  static const name = 'YubikeyScreen';
  static const routerPage = '/yubikey';
  final bool canNavigateBack;

  @override
  ConsumerState<YubikeyScreen> createState() => _YubikeyScreenState();
}

class _YubikeyScreenState extends ConsumerState<YubikeyScreen> {
  StreamSubscription<OTPReceiveEvent>? _otpReceiveSub;

  double buttonSize = 100;

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
    if (!mounted) return;
    final result = await ref
        .read(
          AuthenticationProviders.yubikeyAuthentication.notifier,
        )
        .authenticateWithYubikey(
          YubikeyCredentials(
            otp: otp,
          ),
        );

    final localizations = AppLocalizations.of(context)!;

    await result.maybeMap(
      success: (_) async {
        await ref
            .read(
              AuthenticationProviders.settings.notifier,
            )
            .setAuthMethod(AuthMethod.yubikeyWithYubicloud);
        context.pop(true);
        return;
      },
      orElse: () async {
        UIUtil.showSnackbar(
          localizations.yubikeyError_BAD_OTP,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
        );
        context.pop(false);
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final preferences = ref.watch(SettingsProviders.settings);

    return WillPopScope(
      onWillPop: () async => widget.canNavigateBack,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ArchethicTheme.backgroundSmall,
              ),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                ArchethicTheme.backgroundDark,
                ArchethicTheme.background,
              ],
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
                                    color: ArchethicTheme.text,
                                    onPressed: () {
                                      context.pop(false);
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
                    style: ArchethicThemeStyles.textStyleSize16W400Primary,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                ),
                if (isNFCAvailable)
                  ElevatedButton(
                    child: Text(
                      buttonNFCLabel,
                      style: ArchethicThemeStyles.textStyleSize16W200Primary,
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
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ),
                if (isNFCAvailable)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            width: 0.5,
                                          ),
                                          gradient: ArchethicThemeBase
                                              .gradientInputFormBackground,
                                        ),
                                        child: TextField(
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          autocorrect: false,
                                          controller: enterOTPController,
                                          textInputAction: TextInputAction.go,
                                          autofocus: true,
                                          onSubmitted: (value) async {
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) async {
                                            if (value.trim().length == 44) {
                                              EventTaxiImpl.singleton().fire(
                                                OTPReceiveEvent(otp: value),
                                              );
                                            }
                                          },
                                          focusNode: enterOTPFocusNode,
                                          keyboardType: TextInputType.text,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(
                                              45,
                                            ),
                                          ],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            PasteIcon(
                              onPaste: (String value) {
                                enterOTPController!.text = value;
                                EventTaxiImpl.singleton().fire(
                                  OTPReceiveEvent(
                                    otp: enterOTPController!.text,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 200))
                      .scale(duration: const Duration(milliseconds: 200)),
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

// ignore_for_file: cancel_subscriptions, avoid_unnecessary_containers

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/bus/nft_add_event.dart';
import 'package:bin/ui/views/pin_screen.dart';
import 'package:bin/ui/views/yubikey_screen.dart';
import 'package:core/appstate_container.dart';
import 'package:core/bus/authenticated_event.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/service/app_service.dart';
import 'package:core/ui/util/dimens.dart';
import 'package:core/ui/util/routes.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/util/ui_util.dart';
import 'package:core/ui/widgets/components/buttons.dart';
import 'package:core/ui/widgets/components/dialog.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/global_var.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/preferences.dart';
import 'package:core/util/service_locator.dart';
import 'package:core/util/vault.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show TransactionStatus;

class AddNFTConfirm extends StatefulWidget {
  const AddNFTConfirm(
      {Key? key,
      this.nftName,
      this.nftInitialSupply,
      required this.feeEstimation})
      : super(key: key);

  final String? nftName;
  final int? nftInitialSupply;
  final double? feeEstimation;

  @override
  _AddNFTConfirmState createState() => _AddNFTConfirmState();
}

class _AddNFTConfirmState extends State<AddNFTConfirm> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<NFTAddEvent>? _addNFTSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.send) {
        _doAdd();
      }
    });

    _addNFTSub = EventTaxiImpl.singleton()
        .registerTo<NFTAddEvent>()
        .listen((NFTAddEvent event) {
      if (event.response!.toUpperCase() != 'OK') {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.sendError +
                ' (' +
                event.response! +
                ')',
            context);
        Navigator.of(context).pop();
      } else {
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.transferSuccess, context,
            duration: const Duration(milliseconds: 5000));
        setState(() {
          StateContainer.of(context).requestUpdate(
              account: StateContainer.of(context).selectedAccount);
        });
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    animationOpen = false;
  }

  @override
  void dispose() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_addNFTSub != null) {
      _addNFTSub!.cancel();
    }
    super.dispose();
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // Sheet handle
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.primary60,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context)!.addNFTHeader,
                          style: AppStyles.textStyleSize24W700Primary(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: '',
                        children: <InlineSpan>[
                          TextSpan(
                            text: '(',
                            style:
                                AppStyles.textStyleSize14W100Primary(context),
                          ),
                          TextSpan(
                              text: StateContainer.of(context)
                                  .wallet!
                                  .getAccountBalanceUCODisplay(),
                              style: AppStyles.textStyleSize14W700Primary(
                                  context)),
                          TextSpan(
                              text: ' UCO)',
                              style: AppStyles.textStyleSize14W100Primary(
                                  context)),
                        ],
                      ),
                    ),
                  ),
                  Text(
                      AppLocalization.of(context)!.estimatedFees +
                          ': ' +
                          widget.feeEstimation.toString() +
                          ' UCO',
                      style: AppStyles.textStyleSize14W100Primary(context)),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                          AppLocalization.of(context)!
                              .addNFTConfirmationMessage,
                          style:
                              AppStyles.textStyleSize14W600Primary(context))),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalization.of(context)!.nftName,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                        Text(widget.nftName!,
                            style:
                                AppStyles.textStyleSize14W100Primary(context)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalization.of(context)!.nftInitialSupply,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                        Text(widget.nftInitialSupply!.toString(),
                            style:
                                AppStyles.textStyleSize14W100Primary(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //A container for CONFIRM and CANCEL buttons
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 0),
              child: Column(
                children: <Widget>[
                  // A row for CONFIRM Button
                  Row(
                    children: <Widget>[
                      // CONFIRM Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.confirm,
                          Dimens.buttonTopDimens, onPressed: () async {
                        // Authenticate
                        final Preferences preferences =
                            await Preferences.getInstance();
                        final AuthenticationMethod authMethod =
                            preferences.getAuthMethod();
                        final bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();
                        if (authMethod.method == AuthMethod.biometrics &&
                            hasBiometrics) {
                          try {
                            final bool authenticated = await sl
                                .get<BiometricUtil>()
                                .authenticateWithBiometrics(
                                    context,
                                    AppLocalization.of(context)!
                                        .confirmBiometrics);
                            if (authenticated) {
                              sl
                                  .get<HapticUtil>()
                                  .feedback(FeedbackType.success);
                              EventTaxiImpl.singleton().fire(
                                  AuthenticatedEvent(AUTH_EVENT_TYPE.send));
                            }
                          } catch (e) {
                            await authenticateWithPin();
                          }
                        } else {
                          if (authMethod.method ==
                              AuthMethod.yubikeyWithYubicloud) {
                            await authenticateWithYubikey();
                          } else {
                            await authenticateWithPin();
                          }
                        }
                      })
                    ],
                  ),
                  // A row for CANCEL Button
                  Row(
                    children: <Widget>[
                      // CANCEL Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.cancel,
                          Dimens.buttonBottomDimens, onPressed: () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _doAdd() async {
    try {
      _showSendingAnimation(context);
      final String transactionChainSeed =
          await StateContainer.of(context).getSeed();
      final TransactionStatus transactionStatus = await sl
          .get<AppService>()
          .addNFT(
              globalVarOriginPrivateKey,
              transactionChainSeed,
              StateContainer.of(context).selectedAccount.lastAddress!,
              widget.nftName!,
              widget.nftInitialSupply!);
      EventTaxiImpl.singleton()
          .fire(NFTAddEvent(response: transactionStatus.status));
    } catch (e) {
      EventTaxiImpl.singleton().fire(NFTAddEvent(response: e.toString()));
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    final Vault _vault = await Vault.getInstance();
    final String? expectedPin = _vault.getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.enterPin,
        expectedPin: expectedPin!,
        description: '',
      );
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
    }
  }

  Future<void> authenticateWithYubikey() async {
    // Yubikey Authentication
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const YubikeyScreen();
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
    }
  }
}

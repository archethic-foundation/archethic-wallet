// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/global_var.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/authentication_method.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_complete_sheet.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/util/biometrics.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show TransactionStatus;

class AddNFTConfirm extends StatefulWidget {
  const AddNFTConfirm({this.nftName, this.nftInitialSupply}) : super();

  final String? nftName;
  final int? nftInitialSupply;

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
      if (event.authType == AUTH_EVENT_TYPE.SEND) {
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
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        setState(() {
          StateContainer.of(context)
              .requestUpdate(StateContainer.of(context).selectedAccount, null);
        });
        Sheets.showAppHeightNineSheet(
            context: context,
            closeOnTap: true,
            removeUntilHome: true,
            widget: const TransferCompleteSheet(
              title: 'NFT Created',
            ));
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_addNFTSub != null) {
      _addNFTSub!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    animationOpen = false;
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.SEND,
        StateContainer.of(context).curTheme.animationOverlayStrong,
        StateContainer.of(context).curTheme.animationOverlayMedium,
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
                color: StateContainer.of(context).curTheme.primary10,
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
                                  .wallet
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
                      AppLocalization.of(context)!.fees +
                          ': ' +
                          sl
                              .get<AppService>()
                              .getFeesEstimation()
                              .toStringAsFixed(5) +
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
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context)!.confirm,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                        // Authenticate
                        final AuthenticationMethod authMethod =
                            await sl.get<SharedPrefsUtil>().getAuthMethod();
                        final bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();
                        if (authMethod.method == AuthMethod.BIOMETRICS &&
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
                                  AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
                            }
                          } catch (e) {
                            await authenticateWithPin();
                          }
                        } else {
                          await authenticateWithPin();
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
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context)!.cancel,
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
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
    final String? expectedPin = await sl.get<Vault>().getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: '',
      );
    })) as bool;
    if (auth) {
      await Future<Duration>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
    }
  }
}

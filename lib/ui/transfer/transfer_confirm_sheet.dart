// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show UcoTransfer, NftTransfer;
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/authentication_method.dart';
import 'package:archethic_mobile_wallet/model/db/contact.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/nft_transfer_list.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_complete_sheet.dart';
import 'package:archethic_mobile_wallet/ui/transfer/uco_transfer_list.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/util/biometrics.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

class TransferConfirmSheet extends StatefulWidget {
  const TransferConfirmSheet(
      {this.typeTransfer,
      this.localCurrency,
      this.contactsRef,
      this.title,
      this.ucoTransferList,
      this.nftTransferList})
      : super();

  final String? typeTransfer;
  final String? localCurrency;
  final String? title;
  final List<Contact>? contactsRef;
  final List<UcoTransfer>? ucoTransferList;
  final List<NftTransfer>? nftTransferList;

  @override
  _TransferConfirmSheetState createState() => _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends State<TransferConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.SEND) {
        _doSend();
      }
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) {
      if (event.response != 'Success') {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }
        UIUtil.showSnackbar(
            AppLocalization.of(context).sendError +
                ' (' +
                event.response! +
                ')',
            context);
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        StateContainer.of(context).requestUpdate();
        Sheets.showAppHeightNineSheet(
            context: context,
            closeOnTap: true,
            removeUntilHome: true,
            widget: TransferCompleteSheet(
              title: widget.title,
            ));
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_sendTxSub != null) {
      _sendTxSub!.cancel();
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
                color: StateContainer.of(context).curTheme.text10,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          (widget.title ??
                              AppLocalization.of(context).transfering)!,
                          style: AppStyles.textStyleHeader(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.105,
                        right: MediaQuery.of(context).size.width * 0.105),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundDarkest,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            AppLocalization.of(context).fees +
                                ': ' +
                                sl
                                    .get<AppService>()
                                    .getFeesEstimation()
                                    .toStringAsFixed(5) +
                                ' UCO',
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.primary60,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: widget.typeTransfer == 'UCO'
                        ? UcoTransferListWidget(
                            listUcoTransfer: widget.ucoTransferList,
                            contacts: widget.contactsRef,
                            displayContextMenu: false,
                          )
                        : widget.typeTransfer == 'NFT'
                            ? NftTransferListWidget(
                                listNftTransfer: widget.nftTransferList,
                                contacts: widget.contactsRef,
                                displayContextMenu: false,
                              )
                            : const SizedBox(),
                  )
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
                          AppLocalization.of(context).confirm,
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
                                .authenticateWithBiometrics(context, '');
                            if (authenticated) {
                              sl.get<HapticUtil>().fingerprintSucess();
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
                          AppLocalization.of(context).cancel,
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

  Future<void> _doSend() async {
    try {
      _showSendingAnimation(context);

      final String seed = await StateContainer.of(context).getSeed();
      final int index = StateContainer.of(context).selectedAccount.index!;
      const String publicKeyBase64 = '';

      const String privateKey = '';
      //print("send tx");
      /*sl.get<AppService>().sendUCO(originPrivateKey, transactionChainSeed, address, endpoint, listUcoTransfer)
          StateContainer.of(context).wallet.address,
          widget.amountRaw,
          destinationAltered,
          "",
          "",
          publicKeyBase64,
          privateKey);*/
      EventTaxiImpl.singleton().fire(TransactionSendEvent(response: 'Success'));
    } catch (e) {
      // Send failed
      //print("send failed" + e.toString());
      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: e.toString()));
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    final String expectedPin = await sl.get<Vault>().getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: '',
      );
    }));
    //print("authenticateWithPin - auth : " + auth.toString());
    if (auth != null && auth) {
      await Future<Duration>.delayed(const Duration(milliseconds: 200));
      //print("authenticateWithPin - fire AuthenticatedEvent");
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
    }
  }
}

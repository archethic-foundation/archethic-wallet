// @dart=2.9

import 'dart:async';

import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/service/app_service.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/ui/send/send_complete_sheet.dart';
import 'package:uniris_mobile_wallet/ui/util/routes.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/ui/widgets/dialog.dart';
import 'package:uniris_mobile_wallet/ui/util/ui_util.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:uniris_mobile_wallet/util/numberutil.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';
import 'package:uniris_mobile_wallet/util/biometrics.dart';
import 'package:uniris_mobile_wallet/util/hapticutil.dart';
import 'package:uniris_mobile_wallet/model/authentication_method.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/ui/widgets/security.dart';

class SendConfirmSheet extends StatefulWidget {
  final String amountRaw;
  final String destination;
  final String contactName;
  final String localCurrency;
  final bool maxSend;
  final String title;

  SendConfirmSheet(
      {this.amountRaw,
      this.destination,
      this.contactName,
      this.localCurrency,
      this.maxSend = false,
      this.title})
      : super();

  _SendConfirmSheetState createState() => _SendConfirmSheetState();
}

class _SendConfirmSheetState extends State<SendConfirmSheet> {
  String amount;
  String destinationAltered;
  bool animationOpen;

  StreamSubscription<AuthenticatedEvent> _authSub;
  StreamSubscription<TransactionSendEvent> _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((event) {
      if (event.authType == AUTH_EVENT_TYPE.SEND) {
        _doSend();
      }
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((event) {
      //print("listen TransactionSendEvent");
      //print("result : " + event.response);
      if (event.response != "Success") {
        // Send failed
        if (animationOpen) {
          Navigator.of(context).pop();
        }
        UIUtil.showSnackbar(
            AppLocalization.of(context).sendError + " (" + event.response + ")",
            context);
        Navigator.of(context).pop();
      } else {
        StateContainer.of(context).wallet.accountBalance.uco -=
            double.parse(widget.amountRaw);

        // Show complete
        Contact contact;
        sl
            .get<DBHelper>()
            .getContactWithAddress(widget.destination)
            .then((value) => contact);
        String contactName = contact == null ? null : contact.name;
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        StateContainer.of(context).requestUpdate();
        Sheets.showAppHeightNineSheet(
            context: context,
            closeOnTap: true,
            removeUntilHome: true,
            widget: SendCompleteSheet(
                title: widget.title,
                amountRaw: widget.amountRaw,
                destination: destinationAltered,
                contactName: contactName,
                localAmount: widget.localCurrency));
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub.cancel();
    }
    if (_sendTxSub != null) {
      _sendTxSub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    this.animationOpen = false;
    // Derive amount from raw amount
    if (NumberUtil.getRawAsUsableString(widget.amountRaw).replaceAll(",", "") ==
        NumberUtil.getRawAsUsableDecimal(widget.amountRaw).toString()) {
      amount = NumberUtil.getRawAsUsableString(widget.amountRaw);
    } else {
      amount = NumberUtil.truncateDecimal(
                  NumberUtil.getRawAsUsableDecimal(widget.amountRaw),
                  digits: 6)
              .toStringAsFixed(6) +
          "~";
    }
    destinationAltered = widget.destination;
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
              margin: EdgeInsets.only(top: 10),
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
                    margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.title == null
                              ? AppLocalization.of(context).transfering
                              : widget.title,
                          style: AppStyles.textStyleHeader(context),
                        ),
                      ],
                    ),
                  ),
                  // Container for the amount text
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.105,
                        right: MediaQuery.of(context).size.width * 0.105),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundDarkest,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // Amount text

                    child: Column(
                      children: [
                        double.tryParse(amount.replaceAll(",", "")) > 0
                            ? RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: '',
                                  children: [
                                    TextSpan(
                                      text: "$amount",
                                      style: TextStyle(
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: " UCO",
                                      style: TextStyle(
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w100,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.localCurrency != null
                                          ? " (${widget.localCurrency})"
                                          : "",
                                      style: TextStyle(
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "+ " +
                                AppLocalization.of(context).fees +
                                ": " +
                                sl
                                    .get<AppService>()
                                    .getFeesEstimation()
                                    .toStringAsFixed(5) +
                                " UCO",
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
                  // "TO" text
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).to,
                          style: TextStyle(
                            color: StateContainer.of(context).curTheme.text60,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Address text
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 15.0,
                      ),
                      margin: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10,
                          left: MediaQuery.of(context).size.width * 0.105,
                          right: MediaQuery.of(context).size.width * 0.105),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: UIUtil.threeLineAddressText(
                          context, destinationAltered,
                          contactName: widget.contactName)),
                ],
              ),
            ),

            //A container for CONFIRM and CANCEL buttons
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 0),
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
                        AuthenticationMethod authMethod =
                            await sl.get<SharedPrefsUtil>().getAuthMethod();
                        bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();
                        if (authMethod.method == AuthMethod.BIOMETRICS &&
                            hasBiometrics) {
                          try {
                            bool authenticated = await sl
                                .get<BiometricUtil>()
                                .authenticateWithBiometrics(
                                    context,
                                    AppLocalization.of(context)
                                        .sendAmountConfirm
                                        .replaceAll("%1", amount));
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

      String seed = await StateContainer.of(context).getSeed();
      int index = StateContainer.of(context).selectedAccount.index;
      String publicKeyBase64 = "";

      String privateKey = "";
      //print("send tx");
      /*sl.get<AppService>().sendUCO(originPrivateKey, transactionChainSeed, address, endpoint, listUcoTransfer)
          StateContainer.of(context).wallet.address,
          widget.amountRaw,
          destinationAltered,
          "",
          "",
          publicKeyBase64,
          privateKey);*/
    } catch (e) {
      // Send failed
      //print("send failed" + e.toString());
      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: e.toString()));
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    String expectedPin = await sl.get<Vault>().getPin();
    bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: AppLocalization.of(context)
            .transferAmountConfirmPin
            .replaceAll("%1", amount),
      );
    }));
    //print("authenticateWithPin - auth : " + auth.toString());
    if (auth != null && auth) {
      await Future.delayed(Duration(milliseconds: 200));
      //print("authenticateWithPin - fire AuthenticatedEvent");
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
    }
  }
}

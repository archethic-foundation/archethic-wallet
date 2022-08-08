// ignore_for_file: cancel_subscriptions, avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:core/util/confirmations/subscription_channel.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/views/authenticate/auth_factory.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/bus/authenticated_event.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:

import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class AddTokenConfirm extends StatefulWidget {
  const AddTokenConfirm(
      {super.key,
      this.tokenName,
      this.tokenSymbol,
      this.tokenInitialSupply,
      required this.feeEstimation});

  final String? tokenName;
  final String? tokenSymbol;
  final int? tokenInitialSupply;
  final double? feeEstimation;

  @override
  State<AddTokenConfirm> createState() => _AddTokenConfirmState();
}

class _AddTokenConfirmState extends State<AddTokenConfirm> {
  bool? animationOpen;

  SubscriptionChannel subscriptionChannel = SubscriptionChannel();

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.send) {
        _doAdd();
      }
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }

        UIUtil.showSnackbar(
            '${AppLocalization.of(context)!.sendError} (${event.response!})',
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!);
        Navigator.of(context).pop();
      } else {
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.transferSuccess,
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000));
        setState(() {
          StateContainer.of(context).requestUpdate();
        });
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
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
    subscriptionChannel.close();
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
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.text60,
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
                          AppLocalization.of(context)!.createToken,
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                              context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      '${AppLocalization.of(context)!.estimatedFees}: ${widget.feeEstimation} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                      style: AppStyles.textStyleSize14W100Primary(context)),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                          AppLocalization.of(context)!
                              .addTokenConfirmationMessage,
                          style:
                              AppStyles.textStyleSize14W600Primary(context))),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalization.of(context)!.tokenName,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                        Text(widget.tokenName!,
                            style:
                                AppStyles.textStyleSize14W100Primary(context)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalization.of(context)!.tokenSymbol,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                        Text(widget.tokenSymbol!,
                            style:
                                AppStyles.textStyleSize14W100Primary(context)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalization.of(context)!.tokenInitialSupply,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                        Text(widget.tokenInitialSupply!.toString(),
                            style:
                                AppStyles.textStyleSize14W100Primary(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          const Key('confirm'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.confirm,
                          Dimens.buttonTopDimens, onPressed: () async {
                        // Authenticate
                        final Preferences preferences =
                            await Preferences.getInstance();
                        final AuthenticationMethod authMethod =
                            preferences.getAuthMethod();
                        bool auth = await AuthFactory.authenticate(
                            context, authMethod,
                            activeVibrations:
                                StateContainer.of(context).activeVibrations);
                        if (auth) {
                          EventTaxiImpl.singleton()
                              .fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
                        }
                      })
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          const Key('cancel'),
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
      final String? seed = await StateContainer.of(context).getSeed();
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);
      final String service =
          'archethic-wallet-${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.name!}';
      final int index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service, index: 0))))
          .chainLength!;

      final Transaction transaction =
          Transaction(type: 'token', data: Transaction.initData());
      String content = tokenToJsonForTxDataContent(Token(
          name: widget.tokenName,
          supply: widget.tokenInitialSupply! * 100000000,
          type: 'fungible',
          tokenId: 0,
          symbol: widget.tokenSymbol));
      transaction.setContent(content);
      Transaction signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      TransactionStatus transactionStatus = TransactionStatus();

      final Preferences preferences = await Preferences.getInstance();
      await subscriptionChannel.connect(
          await preferences.getNetwork().getPhoenixHttpLink(),
          await preferences.getNetwork().getWebsocketUri());

      subscriptionChannel.addSubscriptionTransactionConfirmed(
          transaction.address!, waitConfirmations);

      transactionStatus = await sl.get<ApiService>().sendTx(signedTx);
    } catch (e) {
      EventTaxiImpl.singleton().fire(
          TransactionSendEvent(response: e.toString(), nbConfirmations: 0));
      subscriptionChannel.close();
    }
  }

  void waitConfirmations(QueryResult event) {
    if (event.data != null &&
        event.data!['transactionConfirmed'] != null &&
        event.data!['transactionConfirmed']['nbConfirmations'] != null) {
      EventTaxiImpl.singleton().fire(TransactionSendEvent(
          response: 'ok',
          nbConfirmations: event.data!['transactionConfirmed']
              ['nbConfirmations']));
    } else {
      // TODO: Mettre un libellé plus clair
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(nbConfirmations: 0, response: 'ko'),
      );
    }
    subscriptionChannel.close();
  }
}

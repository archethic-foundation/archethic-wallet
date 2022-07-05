// ignore_for_file: cancel_subscriptions, always_specify_types

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

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
import 'package:graphql_flutter/graphql_flutter.dart';

// Project imports:
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/views/tokens/token_transfer_list.dart';
import 'package:aewallet/ui/views/uco/subscription_channel.dart';
import 'package:aewallet/ui/views/uco/uco_transfer_list.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        TransactionStatus,
        ApiService,
        Transaction,
        UCOTransfer,
        Keychain,
        uint8ListToHex;

class TransferConfirmSheet extends StatefulWidget {
  const TransferConfirmSheet(
      {super.key,
      required this.lastAddress,
      required this.typeTransfer,
      required this.feeEstimation,
      this.title,
      this.ucoTransferList,
      this.tokenTransferList});

  final String? lastAddress;
  final String? typeTransfer;
  final String? title;
  final double? feeEstimation;
  final List<UCOTransferWallet>? ucoTransferList;
  final List<TokenTransferWallet>? tokenTransferList;

  @override
  State<TransferConfirmSheet> createState() => _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends State<TransferConfirmSheet> {
  bool? animationOpen;

  SubscriptionChannel subscriptionChannel = SubscriptionChannel();

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.send) {
        _doSend();
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
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.title ??
                            AppLocalization.of(context)!.transfering,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: widget.typeTransfer == 'UCO'
                      ? UCOTransferListWidget(
                          listUcoTransfer: widget.ucoTransferList,
                          feeEstimation: widget.feeEstimation,
                        )
                      : widget.typeTransfer == 'TOKEN'
                          ? TokenTransferListWidget(
                              listTokenTransfer: widget.tokenTransferList,
                            )
                          : const SizedBox(),
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
                      Dimens.buttonTopDimens,
                      onPressed: () async {
                        final Preferences preferences =
                            await Preferences.getInstance();
                        // Authenticate
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
                      },
                    ),
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
      ),
    );
  }

  Future<void> _doSend() async {
    try {
      _showSendingAnimation(context);
      final String? seed = await StateContainer.of(context).getSeed();
      List<UCOTransferWallet> ucoTransferList = widget.ucoTransferList!;
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();

      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);
      final String service =
          'archethic-wallet-${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.name!}';
      final int index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service, index: 0))))
          .chainLength!;

      final Transaction transaction =
          Transaction(type: 'transfer', data: Transaction.initData());
      for (UCOTransfer transfer in ucoTransferList) {
        transaction.addUCOTransfer(transfer.to, transfer.amount!);
      }

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

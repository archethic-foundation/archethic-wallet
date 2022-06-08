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
import 'package:aewallet/model/nft_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/views/nft/nft_transfer_list.dart';
import 'package:aewallet/ui/views/tokens/subscription_channel.dart';
import 'package:aewallet/ui/views/tokens/tokens_transfer_list.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show TransactionStatus, ApiService, Transaction, UCOTransfer;

class TransferConfirmSheet extends StatefulWidget {
  const TransferConfirmSheet(
      {super.key,
      required this.lastAddress,
      required this.typeTransfer,
      required this.feeEstimation,
      this.title,
      this.ucoTransferList,
      this.nftTransferList});

  final String? lastAddress;
  final String? typeTransfer;
  final String? title;
  final double? feeEstimation;
  final List<UCOTransferWallet>? ucoTransferList;
  final List<NFTTransferWallet>? nftTransferList;

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
      Navigator.of(context).pop();

      if (event.response != 'pending') {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }

        UIUtil.showSnackbar(
            AppLocalization.of(context)!.sendError +
                ' (' +
                event.response! +
                ')',
            context,
            StateContainer.of(context).curTheme.primary!,
            StateContainer.of(context).curTheme.overlay80!);
        Navigator.of(context).pop();
      } else {
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.transferSuccess,
            context,
            StateContainer.of(context).curTheme.primary!,
            StateContainer.of(context).curTheme.overlay80!,
            duration: const Duration(milliseconds: 5000));
        setState(() {
          StateContainer.of(context).requestUpdate(
              account: StateContainer.of(context).selectedAccount);
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
    try {
      subscriptionChannel.connect();
    } catch (e) {
      setState(() => print('error: $e'));
    }

    _registerBus();
    animationOpen = false;
  }

  void _onEvent(Map event) {
    if (event != null) {
      if (event["status"] == "ok") {
        print('ok');
      }
    }
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
              color: StateContainer.of(context).curTheme.primary60,
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
                        style: AppStyles.textStyleSize24W700Primary(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: widget.typeTransfer == 'TOKEN'
                      ? TokensTransferListWidget(
                          listUcoTransfer: widget.ucoTransferList,
                          feeEstimation: widget.feeEstimation,
                        )
                      : widget.typeTransfer == 'NFT'
                          ? NftTransferListWidget(
                              listNftTransfer: widget.nftTransferList,
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
                        bool auth =
                            await AuthFactory.authenticate(context, authMethod);
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
      final String? transactionChainSeed =
          await StateContainer.of(context).getSeed();
      List<UCOTransferWallet> ucoTransferList = widget.ucoTransferList!;
      final String originPrivateKey = await sl.get<ApiService>().getOriginKey();

/*
      final TransactionStatus transactionStatus = await sl
          .get<AppService>()
          .sendUCO(
              originPrivateKey,
              transactionChainSeed,
              StateContainer.of(context).selectedAccount.lastAddress!,
              _ucoTransferList);*/

      final Transaction lastTransaction =
          await sl.get<ApiService>().getLastTransaction(widget.lastAddress!);
      final Transaction transaction =
          Transaction(type: 'transfer', data: Transaction.initData());
      for (UCOTransfer transfer in ucoTransferList) {
        transaction.addUCOTransfer(transfer.to, transfer.amount!);
      }
      TransactionStatus transactionStatus = TransactionStatus();
      transaction
          .build(transactionChainSeed!, lastTransaction.chainLength!)
          .originSign(originPrivateKey);

      /*Stream<QueryResult> subscription = subscriptionChannel.client!.subscribe(
        SubscriptionOptions(
            document: gql('subscription { transactionConfirmed(address: "' +
                transaction.address! +
                '") { nbConfirmations } }')),
      );
      subscription.listen(reactToPostCreated);
*/
      transactionStatus = await sl.get<ApiService>().sendTx(transaction);

      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: transactionStatus.status));
    } catch (e) {
      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: e.toString()));
    }
  }

  void reactToPostCreated(QueryResult event) {
    print("Received event =>");
    print(event);
  }
}

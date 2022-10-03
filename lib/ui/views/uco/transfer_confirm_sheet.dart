// ignore_for_file: cancel_subscriptions, always_specify_types

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/tokens_fungibles/token_transfer_list.dart';
import 'package:aewallet/ui/views/uco/uco_transfer_list.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/confirmations/confirmations_util.dart';
import 'package:aewallet/util/confirmations/subscription_channel.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';

class TransferConfirmSheet extends StatefulWidget {
  const TransferConfirmSheet({
    super.key,
    required this.lastAddress,
    required this.typeTransfer,
    required this.feeEstimation,
    required this.symbol,
    this.title,
    this.ucoTransferList,
    this.tokenTransferList,
    this.message,
  });

  final String? lastAddress;
  final String? typeTransfer;
  final String? title;
  final double? feeEstimation;
  final String? message;
  final String? symbol;
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
      _doSend();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }

        UIUtil.showSnackbar(
          event.response!,
          context,
          StateContainer.of(context).curTheme.text!,
          StateContainer.of(context).curTheme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
        Navigator.of(context).pop();
      } else {
        if (event.response == 'ok' &&
            ConfirmationsUtil.isEnoughConfirmations(
              event.nbConfirmations!,
              event.maxConfirmations!,
            )) {
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? AppLocalization.of(context)!
                    .transferConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : AppLocalization.of(context)!
                    .transferConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );
          if (widget.typeTransfer == 'TOKEN') {
            final Transaction transaction = await sl
                .get<ApiService>()
                .getLastTransaction(event.transactionAddress!);

            final Token token = await sl.get<ApiService>().getToken(
                  transaction.data!.ledger!.token!.transfers![0].tokenAddress!,
                  request: 'id',
                );
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .removeftInfosOffChain(token.id);
          }
          setState(() {
            StateContainer.of(context).requestUpdate();
          });
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        } else {
          UIUtil.showSnackbar(
            AppLocalization.of(context)!.notEnoughConfirmations,
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!,
          );
          Navigator.of(context).pop();
        }
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
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: widget.title ?? AppLocalization.of(context)!.transfering,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
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
                              feeEstimation: widget.feeEstimation,
                              symbol: widget.symbol,
                            )
                          : const SizedBox(),
                ),
                if (widget.message!.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context)!.sendMessageConfirmHeader,
                          style: AppStyles.textStyleSize14W600Primary(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.message!,
                          style: AppStyles.textStyleSize14W600Primary(context),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
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
                        final bool auth = await AuthFactory.authenticate(
                          context,
                          authMethod,
                          activeVibrations:
                              StateContainer.of(context).activeVibrations,
                        );
                        if (auth) {
                          EventTaxiImpl.singleton().fire(AuthenticatedEvent());
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
                      Dimens.buttonBottomDimens,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
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
      final List<UCOTransferWallet> ucoTransferList = widget.ucoTransferList!;
      final List<TokenTransferWallet> tokenTransferList =
          widget.tokenTransferList!;
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();

      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);
      final String nameEncoded = Uri.encodeFull(
        StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .name!,
      );
      final String service = 'archethic-wallet-$nameEncoded';
      final int index = (await sl.get<ApiService>().getTransactionIndex(
                uint8ListToHex(keychain.deriveAddress(service)),
              ))
          .chainLength!;

      final Transaction transaction =
          Transaction(type: 'transfer', data: Transaction.initData());
      for (final UCOTransfer transfer in ucoTransferList) {
        transaction.addUCOTransfer(transfer.to, transfer.amount!);
      }
      for (final TokenTransfer transfer in tokenTransferList) {
        transaction.addTokenTransfer(
          transfer.to,
          transfer.amount!,
          transfer.tokenAddress,
          tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!,
        );
      }

      if (widget.message!.isNotEmpty) {
        final String aesKey = uint8ListToHex(
          Uint8List.fromList(
            List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
          ),
        );

        final KeyPair walletKeyPair = keychain.deriveKeypair(service);

        final List<String> authorizedPublicKeys =
            List<String>.empty(growable: true);
        authorizedPublicKeys.add(uint8ListToHex(walletKeyPair.publicKey));

        for (final UCOTransfer transfer in ucoTransferList) {
          final List<Transaction> firstTxListRecipient = await sl
              .get<ApiService>()
              .getTransactionChain(transfer.to!, request: 'previousPublicKey');
          if (firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys
                .add(firstTxListRecipient.first.previousPublicKey!);
          }
        }

        for (final TokenTransfer transfer in tokenTransferList) {
          final List<Transaction> firstTxListRecipient = await sl
              .get<ApiService>()
              .getTransactionChain(transfer.to!, request: 'previousPublicKey');
          if (firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys
                .add(firstTxListRecipient.first.previousPublicKey!);
          }
        }

        final List<AuthorizedKey> authorizedKeys =
            List<AuthorizedKey>.empty(growable: true);
        for (final String key in authorizedPublicKeys) {
          authorizedKeys.add(
            AuthorizedKey(
              encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
              publicKey: key,
            ),
          );
        }

        transaction.addOwnership(
          aesEncrypt(widget.message, aesKey),
          authorizedKeys,
        );
      }

      final Transaction signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      TransactionStatus transactionStatus = TransactionStatus();

      final Preferences preferences = await Preferences.getInstance();
      await subscriptionChannel.connect(
        await preferences.getNetwork().getPhoenixHttpLink(),
        await preferences.getNetwork().getWebsocketUri(),
      );

      void waitConfirmationsTrf(QueryResult event) {
        waitConfirmations(event, transactionAddress: signedTx.address);
      }

      subscriptionChannel.addSubscriptionTransactionConfirmed(
        transaction.address!,
        waitConfirmationsTrf,
      );

      await Future.delayed(const Duration(seconds: 1));

      transactionStatus = await sl.get<ApiService>().sendTx(signedTx);

      if (transactionStatus.status == 'invalid') {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.transfer,
            response: '',
            nbConfirmations: 0,
          ),
        );
        subscriptionChannel.close();
      }
    } on ArchethicConnectionException {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: AppLocalization.of(context)!.noConnection,
          nbConfirmations: 0,
        ),
      );
      subscriptionChannel.close();
    } on Exception {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: AppLocalization.of(context)!.keychainNotExistWarning,
          nbConfirmations: 0,
        ),
      );
      subscriptionChannel.close();
    }
  }

  void waitConfirmations(QueryResult event, {String? transactionAddress}) {
    int nbConfirmations = 0;
    int maxConfirmations = 0;
    if (event.data != null && event.data!['transactionConfirmed'] != null) {
      if (event.data!['transactionConfirmed']['nbConfirmations'] != null) {
        nbConfirmations =
            event.data!['transactionConfirmed']['nbConfirmations'];
      }
      if (event.data!['transactionConfirmed']['maxConfirmations'] != null) {
        maxConfirmations =
            event.data!['transactionConfirmed']['maxConfirmations'];
      }
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.transfer,
          response: 'ok',
          nbConfirmations: nbConfirmations,
          transactionAddress: transactionAddress,
          maxConfirmations: maxConfirmations,
        ),
      );
    } else {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.transfer,
          nbConfirmations: 0,
          maxConfirmations: 0,
          response: 'ko',
        ),
      );
    }
    subscriptionChannel.close();
  }
}

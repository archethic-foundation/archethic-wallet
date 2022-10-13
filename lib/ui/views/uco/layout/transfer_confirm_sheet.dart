// ignore_for_file: cancel_subscriptions, always_specify_types

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layout/token_transfer_list.dart';
import 'package:aewallet/ui/views/uco/bloc/transaction_builder.dart';
import 'package:aewallet/ui/views/uco/layout/uco_transfer_list.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferConfirmSheet extends ConsumerStatefulWidget {
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
  ConsumerState<TransferConfirmSheet> createState() =>
      _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends ConsumerState<TransferConfirmSheet> {
  bool? animationOpen;

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
      final theme = ref.read(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok' &&
          TransactionConfirmation.isEnoughConfirmations(
            event.nbConfirmations!,
            event.maxConfirmations!,
          )) {
        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalization.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) async {
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
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );
    if (widget.typeTransfer == 'TOKEN') {
      final transaction = await sl
          .get<ApiService>()
          .getLastTransaction(event.transactionAddress!);

      final token = await sl.get<ApiService>().getToken(
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
  }

  void _showSendFailed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) {
    // Send failed
    if (animationOpen!) {
      Navigator.of(context).pop();
    }
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
    Navigator.of(context).pop();
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    animationOpen = true;
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        theme.animationOverlayStrong!,
        theme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: widget.title ?? localizations.transfering,
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
                          localizations.sendMessageConfirmHeader,
                          style: theme.textStyleSize14W600Primary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.message!,
                          style: theme.textStyleSize14W600Primary,
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
                      ref,
                      AppButtonType.primary,
                      localizations.confirm,
                      Dimens.buttonTopDimens,
                      onPressed: () async {
                        final preferences = await Preferences.getInstance();
                        // Authenticate
                        final authMethod = preferences.getAuthMethod();
                        final auth = await AuthFactory.authenticate(
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
                      ref,
                      AppButtonType.primary,
                      localizations.cancel,
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
    _showSendingAnimation(context);
    final seed = await StateContainer.of(context).getSeed();
    final ucoTransferList = widget.ucoTransferList!;
    final tokenTransferList = widget.tokenTransferList!;
    final originPrivateKey = sl.get<ApiService>().getOriginKey();

    final keychain = await sl.get<ApiService>().getKeychain(seed!);
    final nameEncoded = Uri.encodeFull(
      StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .name!,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service)),
            ))
        .chainLength!;

    final transaction = await TransferTransactionBuilder.build(
      message: widget.message!,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenTransferList: tokenTransferList,
      ucoTransferList: ucoTransferList,
    );

    final preferences = await Preferences.getInstance();

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: await preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: await preferences.getNetwork().getWebsocketUri(),
    );

    transactionSender.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.transfer,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            transactionAddress: transaction.address,
            maxConfirmations: confirmation.maxConfirmations,
          ),
        );
      },
      onError: (error) async {
        error.maybeMap(
          connectivity: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType
                    .token, // TODO(reddwarf03): is it the right type ?
                response: AppLocalization.of(context)!.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          other: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType
                    .token, // TODO(reddwarf03): is it the right type ?
                response: AppLocalization.of(context)!.keychainNotExistWarning,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
                response: '',
                nbConfirmations: 0,
              ),
            );
          },
        );
      },
    );
  }
}

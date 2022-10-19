// ignore_for_file: cancel_subscriptions, avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
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

// Project imports:

class AddNFTCollectionConfirm extends ConsumerStatefulWidget {
  const AddNFTCollectionConfirm({
    super.key,
    required this.token,
    required this.feeEstimation,
  });

  final Token? token;
  final double? feeEstimation;

  @override
  ConsumerState<AddNFTCollectionConfirm> createState() =>
      _AddNFTCollectionConfirmState();
}

class _AddNFTCollectionConfirmState
    extends ConsumerState<AddNFTCollectionConfirm> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      _doAdd();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
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
      } else {
        if (event.response == 'ok' &&
            TransactionConfirmation.isEnoughConfirmations(
              event.nbConfirmations ?? 0,
              event.maxConfirmations ?? 0,
            )) {
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? AppLocalization.of(context)!
                    .transactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : AppLocalization.of(context)!
                    .transactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            ref,
            theme.text!,
            theme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );
          setState(() {
            StateContainer.of(context).requestUpdate();
          });
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        } else {
          UIUtil.showSnackbar(
            AppLocalization.of(context)!.notEnoughConfirmations,
            context,
            ref,
            theme.text!,
            theme.snackBarShadow!,
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
            title: localizations.createNFTCollection,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  '${localizations.estimatedFees}: ${widget.feeEstimation} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                  style: theme.textStyleSize14W100Primary,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    localizations.addNFTCollectionConfirmationMessage,
                    style: theme.textStyleSize14W600Primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        localizations.tokenName,
                        style: theme.textStyleSize14W600Primary,
                      ),
                      Text(
                        widget.token!.name!,
                        style: theme.textStyleSize14W100Primary,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        localizations.tokenSymbol,
                        style: theme.textStyleSize14W600Primary,
                      ),
                      Text(
                        widget.token!.symbol!,
                        style: theme.textStyleSize14W100Primary,
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
                    AppButton(
                      AppButtonType.primary,
                      localizations.confirm,
                      Dimens.buttonTopDimens,
                      key: const Key('confirm'),
                      onPressed: () async {
                        // Authenticate
                        final preferences = await Preferences.getInstance();
                        final authMethod = preferences.getAuthMethod();
                        final auth = await AuthFactory.authenticate(
                          context,
                          ref,
                          authMethod: authMethod,
                          activeVibrations: ref
                              .watch(SettingsProviders.settings)
                              .activeVibrations,
                        );
                        if (auth) {
                          EventTaxiImpl.singleton().fire(AuthenticatedEvent());
                        }
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    AppButton(
                      AppButtonType.primary,
                      localizations.cancel,
                      Dimens.buttonBottomDimens,
                      key: const Key('cancel'),
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

  Future<void> _doAdd() async {
    _showSendingAnimation(context);
    final seed = await StateContainer.of(context).getSeed();
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

    final transaction = Transaction(
      type: 'token',
      data: Transaction.initData(),
    );
    final content = tokenToJsonForTxDataContent(
      Token(
        name: widget.token!.name,
        supply: toBigInt(widget.token!.tokenProperties!.length),
        symbol: widget.token!.symbol,
        tokenProperties: widget.token!.tokenProperties,
        type: 'non-fungible',
      ),
    );
    transaction.setContent(content);

    final signedTx = keychain
        .buildTransaction(transaction, service, index)
        .originSign(originPrivateKey);

    final preferences = await Preferences.getInstance();
    final transactionSender = ArchethicTransactionSender(
      phoenixHttpEndpoint: preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: preferences.getNetwork().getWebsocketUri(),
    );

    transactionSender.send(
      transaction: signedTx,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            maxConfirmations: confirmation.maxConfirmations,
          ),
        );
      },
      onError: (error) async {
        error.maybeMap(
          connectivity: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: AppLocalization.of(context)!.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          other: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: AppLocalization.of(context)!.keychainNotExistWarning,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
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

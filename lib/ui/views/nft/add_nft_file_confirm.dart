/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'dart:async';
import 'dart:convert';

import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/confirmations/confirmations_util.dart';
import 'package:aewallet/util/confirmations/subscription_channel.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddNFTFileConfirm extends StatefulWidget {
  const AddNFTFileConfirm({
    required this.token,
    super.key,
  });

  final Token token;

  @override
  State<AddNFTFileConfirm> createState() => _AddNFTFileState();
}

class _AddNFTFileState extends State<AddNFTFileConfirm> {
  bool? animationOpen;

  SubscriptionChannel subscriptionChannel = SubscriptionChannel();

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
        if (event.response == 'ok' &&
            ConfirmationsUtil.isEnoughConfirmations(
                event.nbConfirmations!, event.maxConfirmations!)) {
          UIUtil.showSnackbar(
              event.nbConfirmations == 1
                  ? AppLocalization.of(context)!
                      .nftCreationTransactionConfirmed1
                      .replaceAll('%1', event.nbConfirmations.toString())
                      .replaceAll('%2', event.maxConfirmations.toString())
                  : AppLocalization.of(context)!
                      .nftCreationTransactionConfirmed
                      .replaceAll('%1', event.nbConfirmations.toString())
                      .replaceAll('%2', event.maxConfirmations.toString()),
              context,
              StateContainer.of(context).curTheme.text!,
              StateContainer.of(context).curTheme.snackBarShadow!,
              duration: const Duration(milliseconds: 5000));

          StateContainer.of(context).requestUpdate();

          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        } else {
          UIUtil.showSnackbar(
              AppLocalization.of(context)!.notEnoughConfirmations,
              context,
              StateContainer.of(context).curTheme.text!,
              StateContainer.of(context).curTheme.snackBarShadow!);
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 60,
              ),
              Column(
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
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140),
                    child: Column(
                      children: <Widget>[
                        AutoSizeText(
                          AppLocalization.of(context)!.addNFTFile,
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                              context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 60,
                height: 40,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalization.of(context)!.nftAddPreview,
                          style: AppStyles.textStyleSize14W600Primary(context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    NFTPreviewWidget(
                        nftName: widget.token.name,
                        context: context,
                        nftDescription: widget.token.tokenProperties![0]
                            .where((element) => element.name == 'description')
                            .first
                            .value,
                        nftTypeMime: widget.token.tokenProperties![0]
                            .where((element) => element.name == 'type/mime')
                            .first
                            .value,
                        nftFile: base64Decode(widget.token.tokenProperties![0]
                            .where((element) => element.name == 'file')
                            .first
                            .value!),
                        nftProperties: widget.token.tokenProperties![0]),
                  ],
                ),
              ),
            ),
          ),
          Container(
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
                          EventTaxiImpl.singleton().fire(AuthenticatedEvent());
                        }
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
    try {
      _showSendingAnimation(context);
      final String? seed = await StateContainer.of(context).getSeed();
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);
      String nameEncoded = Uri.encodeFull(StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .name!);
      final String service = 'archethic-wallet-$nameEncoded';
      final int index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service, index: 0))))
          .chainLength!;

      final Transaction transaction =
          Transaction(type: 'token', data: Transaction.initData());
      String content = tokenToJsonForTxDataContent(Token(
          name: widget.token.name,
          supply: widget.token.supply,
          type: widget.token.type,
          symbol: widget.token.symbol,
          tokenProperties: widget.token.tokenProperties));
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

      if (transactionStatus.status == 'invalid') {
        EventTaxiImpl.singleton().fire(TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: '',
            nbConfirmations: 0));
        subscriptionChannel.close();
      }
    } catch (e) {
      EventTaxiImpl.singleton().fire(TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: e.toString(),
          nbConfirmations: 0));
      subscriptionChannel.close();
    }
  }

  void waitConfirmations(QueryResult event) {
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
      EventTaxiImpl.singleton().fire(TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: 'ok',
          nbConfirmations: nbConfirmations,
          maxConfirmations: maxConfirmations));
    } else {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            nbConfirmations: 0,
            maxConfirmations: 0,
            response: 'ko'),
      );
    }
    subscriptionChannel.close();
  }
}

// ignore_for_file: cancel_subscriptions, avoid_unnecessary_containers

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
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/bus/nft_add_event.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show TransactionStatus, ApiService;

class AddNFTConfirm extends StatefulWidget {
  const AddNFTConfirm(
      {super.key,
      this.nftName,
      this.nftInitialSupply,
      required this.feeEstimation});

  final String? nftName;
  final int? nftInitialSupply;
  final double? feeEstimation;

  @override
  State<AddNFTConfirm> createState() => _AddNFTConfirmState();
}

class _AddNFTConfirmState extends State<AddNFTConfirm> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<NFTAddEvent>? _addNFTSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.send) {
        _doAdd();
      }
    });

    _addNFTSub = EventTaxiImpl.singleton()
        .registerTo<NFTAddEvent>()
        .listen((NFTAddEvent event) {
      if (event.response! != 'pending') {
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
          duration: const Duration(milliseconds: 5000),
        );
        setState(() {
          StateContainer.of(context).requestUpdate(
              account: StateContainer.of(context).selectedAccount);
        });
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    animationOpen = false;
  }

  @override
  void dispose() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_addNFTSub != null) {
      _addNFTSub!.cancel();
    }
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
                          AppLocalization.of(context)!.addNFTHeader,
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                              context),
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
                                  .wallet!
                                  .accountBalance
                                  .getNetworkAccountBalanceDisplay(
                                      networkCryptoCurrencyLabel:
                                          StateContainer.of(context)
                                              .curNetwork
                                              .getNetworkCryptoCurrencyLabel()),
                              style: AppStyles.textStyleSize14W700Primary(
                                  context)),
                          TextSpan(
                              text: ')',
                              style: AppStyles.textStyleSize14W100Primary(
                                  context)),
                        ],
                      ),
                    ),
                  ),
                  Text(
                      '${AppLocalization.of(context)!.estimatedFees}: ${widget.feeEstimation} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
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
                        bool auth =
                            await AuthFactory.authenticate(context, authMethod);
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
      final String? transactionChainSeed =
          await StateContainer.of(context).getSeed();
      final String originPrivateKey = await sl.get<ApiService>().getOriginKey();
      final TransactionStatus transactionStatus = await sl
          .get<AppService>()
          .addNFT(
              originPrivateKey,
              transactionChainSeed!,
              StateContainer.of(context).selectedAccount.lastAddress!,
              widget.nftName!,
              widget.nftInitialSupply!,
              StateContainer.of(context).selectedAccount.name!);
      EventTaxiImpl.singleton()
          .fire(NFTAddEvent(response: transactionStatus.status));
    } catch (e) {
      EventTaxiImpl.singleton().fire(NFTAddEvent(response: e.toString()));
    }
  }
}

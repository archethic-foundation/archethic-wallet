// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/styles.dart';

// ignore: avoid_classes_with_only_static_members
class BalanceDisplay {
  static Widget buildBalanceUCODisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 185,
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: StateContainer.of(context).curTheme.backgroundDarkest!,
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0.0, 3.0),
                )
              ],
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 0, end: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 225),
                          child: AutoSizeText(
                            StateContainer.of(context)
                                        .wallet!
                                        .accountBalance
                                        .uco ==
                                    0
                                ? StateContainer.of(context)
                                        .localWallet!
                                        .getAccountBalanceUCODisplay() +
                                    ' UCO'
                                : StateContainer.of(context)
                                        .wallet!
                                        .getAccountBalanceUCODisplay() +
                                    ' UCO',
                            style:
                                AppStyles.textStyleSize28W900Primary(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            minFontSize: 1,
                            maxFontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Text(
                        StateContainer.of(context).wallet!.accountBalance.uco ==
                                0
                            ? StateContainer.of(context)
                                .localWallet!
                                .getLocalCurrencyPrice(
                                    StateContainer.of(context).curCurrency,
                                    locale: StateContainer.of(context)
                                        .currencyLocale!)
                            : StateContainer.of(context)
                                .wallet!
                                .getLocalCurrencyPrice(
                                    StateContainer.of(context).curCurrency,
                                    locale: StateContainer.of(context)
                                        .currencyLocale!),
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize14W600Text60(context)),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.btc,
                            color:
                                StateContainer.of(context).curTheme.primary60,
                            size: 14),
                        Text(
                            StateContainer.of(context)
                                        .wallet!
                                        .accountBalance
                                        .uco ==
                                    0
                                ? StateContainer.of(context)
                                    .localWallet!
                                    .btcPrice
                                : StateContainer.of(context).wallet!.btcPrice,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize14W600Text60(context)),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Text(
                      StateContainer.of(context).wallet!.accountBalance.uco == 0
                          ? '1 UCO = ' +
                              StateContainer.of(context)
                                  .localWallet!
                                  .getLocalPrice(
                                      StateContainer.of(context).curCurrency,
                                      locale: StateContainer.of(context)
                                          .currencyLocale!)
                          : '1 UCO = ' +
                              StateContainer.of(context).wallet!.getLocalPrice(
                                  StateContainer.of(context).curCurrency,
                                  locale: StateContainer.of(context)
                                      .currencyLocale!),
                      style: AppStyles.textStyleSize12W100Primary(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: Text(
              'Balance',
              style: AppStyles.textStyleSize12W100Primary(context),
            ),
          ),
        ),
      ],
    );
  }
}

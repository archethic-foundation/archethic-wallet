// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_uco_sheet.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';

class BalanceDisplay {
  static Widget buildBalanceUCODisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).wallet == null ||
            StateContainer.of(context).wallet.transactionChainLoading == true
        ? Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  StateContainer.of(context).curTheme.primary60,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Text(
                              '1234567',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: AppFontSizes.size14 - 3,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.transparent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 10, end: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            205),
                                child: Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Text(
                                      '123456789.00 UCO',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: AppFontSizes.size14 - 3,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Opacity(
                              opacity: _opacityAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary60,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text(
                                  '1234567',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: AppFontSizes.size14 - 3,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.transparent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 165.0, top: 90.0),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Sheets.showAppHeightNineSheet(
                            context: context,
                            widget: TransferUcoSheet(
                                contactsRef:
                                    StateContainer.of(context).contactsRef,
                                title: AppLocalization.of(context).transferUCO,
                                localCurrency:
                                    StateContainer.of(context).curCurrency));
                      },
                      child: FaIcon(FontAwesomeIcons.arrowCircleUp,
                          color: StateContainer.of(context).curTheme.primary),
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
          )
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            StateContainer.of(context)
                                .wallet
                                .getLocalCurrencyPrice(
                                    StateContainer.of(context).curCurrency,
                                    locale: StateContainer.of(context)
                                        .currencyLocale),
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize14W600Text60(context)),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 10, end: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            205),
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      // Main balance text
                                      TextSpan(
                                        text: StateContainer.of(context)
                                                .wallet
                                                .getAccountBalanceUCODisplay() +
                                            ' UCO',
                                        style: AppStyles
                                            .textStyleSize28W900Primary(
                                                context),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 24),
                                  stepGranularity: 0.1,
                                  minFontSize: 1,
                                  maxFontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.btc,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                size: 14),
                            Text(StateContainer.of(context).wallet.btcPrice,
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyleSize14W600Text60(
                                    context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 165.0, top: 90.0),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Sheets.showAppHeightNineSheet(
                            context: context,
                            widget: TransferUcoSheet(
                                contactsRef:
                                    StateContainer.of(context).contactsRef,
                                title: AppLocalization.of(context).transferUCO,
                                localCurrency:
                                    StateContainer.of(context).curCurrency));
                      },
                      child: FaIcon(FontAwesomeIcons.arrowCircleUp,
                          color: StateContainer.of(context).curTheme.primary),
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

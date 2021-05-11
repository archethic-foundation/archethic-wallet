// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/send/send_sheet.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';

class BalanceDisplay {
  static Widget buildBalanceUCODisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    if (StateContainer.of(context).wallet == null) {
      // Placeholder for balance text
      return Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: <Widget>[
                      Text(
                        "1234567",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: AppFontSizes.small,
                            fontWeight: FontWeight.w600,
                            color: Colors.transparent),
                      ),
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: StateContainer.of(context).curTheme.text20,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            "1234567",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: AppFontSizes.small - 3,
                                fontWeight: FontWeight.w600,
                                color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 225),
                  child: Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: <Widget>[
                      AutoSizeText(
                        "1234567",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: AppFontSizes.largestc,
                            fontWeight: FontWeight.w900,
                            color: Colors.transparent),
                        maxLines: 1,
                        stepGranularity: 0.1,
                        minFontSize: 1,
                      ),
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                StateContainer.of(context).curTheme.primary60,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: AutoSizeText(
                            "1234567",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: AppFontSizes.largestc - 8,
                                fontWeight: FontWeight.w900,
                                color: Colors.transparent),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            minFontSize: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: <Widget>[
                      Text(
                        "1234567",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: AppFontSizes.small,
                            fontWeight: FontWeight.w600,
                            color: Colors.transparent),
                      ),
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: StateContainer.of(context).curTheme.text20,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            "1234567",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: AppFontSizes.small - 3,
                                fontWeight: FontWeight.w600,
                                color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 185,
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDarkest,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: StateContainer.of(context).curTheme.backgroundDarkest,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: Offset(5.0, 5.0), // shadow direction: bottom right
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
                      StateContainer.of(context).wallet.getLocalCurrencyPrice(
                          StateContainer.of(context).curCurrency,
                          locale: StateContainer.of(context).currencyLocale),
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleCurrencyAlt(context)),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 205),
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                // Main balance text
                                TextSpan(
                                  text: StateContainer.of(context)
                                          .wallet
                                          .getAccountBalanceUCODisplay() +
                                      " UCO",
                                  style: AppStyles.textStyleCurrency(context),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            style: TextStyle(fontSize: 28),
                            stepGranularity: 0.1,
                            minFontSize: 1,
                            maxFontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(AppIcons.btc,
                          color: StateContainer.of(context).curTheme.text60,
                          size: 14),
                      Text(StateContainer.of(context).wallet.btcPrice,
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyleCurrencyAlt(context)),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {
                  Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: SendSheet(
                          title: AppLocalization.of(context).transferUCO,
                          localCurrency:
                              StateContainer.of(context).curCurrency));
                },
                child: Icon(FontAwesome5.arrow_circle_up,
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
              style: AppStyles.textStyleTransactionUnit(context),
            ),
          ),
        ),
      ],
    );
  }
}

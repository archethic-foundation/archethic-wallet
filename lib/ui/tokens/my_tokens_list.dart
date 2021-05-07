// @dart=2.9

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';

class MyTokensList extends StatefulWidget {
  final List<BisToken> listBisToken;

  MyTokensList(this.listBisToken) : super();

  _MyTokensListStateState createState() => _MyTokensListStateState();
}

class _MyTokensListStateState extends State<MyTokensList> {
  List<BisToken> _myBisTokenList = new List<BisToken>.empty(growable: true);
  List<BisToken> _myBisTokenListForDisplay =
      new List<BisToken>.empty(growable: true);

  @override
  void initState() {
    //

    setState(() {
      _myBisTokenList.addAll(widget.listBisToken);
      _myBisTokenList.removeWhere((element) => element.tokenName == "");
      _myBisTokenListForDisplay = _myBisTokenList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // A row for the address text and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    // Sheet handle
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text10,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ],
                ),
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 40,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalization.of(context).myTokensListHeader,
                  style: AppStyles.textStyleSettingsHeader(context),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Stack(children: <Widget>[
                  Container(
                      height: 500,
                      child: SafeArea(
                        minimum: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.035,
                          top: 60,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .searchField),
                                onChanged: (text) {
                                  text = text.toLowerCase();
                                  setState(() {
                                    _myBisTokenListForDisplay =
                                        _myBisTokenList.where((token) {
                                      var tokenId =
                                          token.tokenName.toLowerCase();
                                      return tokenId.contains(text);
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                            // list
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  //  list
                                  ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15),
                                    itemCount: _myBisTokenListForDisplay == null
                                        ? 0
                                        : _myBisTokenListForDisplay.length,
                                    itemBuilder: (context, index) {
                                      // Build
                                      return buildSingleToken(context,
                                          _myBisTokenListForDisplay[index]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ]),
              ),
            ),
          ],
        ));
  }

  Widget buildSingleToken(BuildContext context, BisToken bisToken) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Column(children: <Widget>[
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
        // Main Container
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: new EdgeInsetsDirectional.only(start: 12.0, end: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                              NumberFormat.compact(
                                          locale:
                                              Localizations.localeOf(context)
                                                  .languageCode)
                                      .format(bisToken.tokensQuantity) +
                                  " " +
                                  bisToken.tokenName,
                              style: AppStyles.textStyleSettingItemHeader(
                                  context)),
                          SizedBox(
                            width: 5,
                          ),
                          bisToken.tokenName == "egg"
                              ? Icon(
                                  FontAwesome5.egg,
                                  size: AppFontSizes.small,
                                )
                              : SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

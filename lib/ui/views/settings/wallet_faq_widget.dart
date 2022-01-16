// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';

class WalletFAQ extends StatefulWidget {
  WalletFAQ(this.tokensListController, this.tokensListOpen, {Key? key})
      : super(key: key);

  final AnimationController tokensListController;
  bool tokensListOpen;

  @override
  _WalletFAQState createState() => _WalletFAQState();
}

class _WalletFAQState extends State<WalletFAQ> {
  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    //Back button
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              widget.tokensListOpen = false;
                            });
                            widget.tokensListController.reverse();
                          },
                          child: FaIcon(FontAwesomeIcons.chevronLeft,
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              size: 24)),
                    ),
                    // Header Text
                    Text(
                      AppLocalization.of(context)!.walletFAQHeader,
                      style: AppStyles.textStyleSize28W700Primary(context),
                    ),
                  ]),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: bottom + 30),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttericon/font_awesome5_icons.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/styles.dart';


class TxListWidget {
  static Widget buildTxList(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (StateContainer.of(context).wallet == null ||
            StateContainer.of(context).wallet.history == null)
          const SizedBox()
        else
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                height: StateContainer.of(context)
                        .wallet
                        .history
                        .length *
                    100,
                padding: const EdgeInsets.only(
                    top: 23.5, left: 3.5, right: 3.5, bottom: 3.5),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:
                          StateContainer.of(context).curTheme.backgroundDark!,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(5.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 6, bottom: 6),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: StateContainer.of(context)
                        .wallet
                        .history
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return displayTxDetail(
                          context,
                          StateContainer.of(context)
                              .wallet
                              .history[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              padding: const EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.backgroundDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest!,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Transactions', style: AppStyles.textStyleSmallW100Text60(context)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {
                 // TODO
                },
                child: Icon(FontAwesome5.arrow_circle_up,
                    color: StateContainer.of(context).curTheme.primary),
              ),
            ),
          ),
        ),
       ],
    );
  }

  static Column displayTxDetail(BuildContext context, Transaction transaction) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(transaction.type!,
                        style: AppStyles.textStyleSmallW100Primary(context)),
                    Text(Address(transaction.address!).getShortString3(),
                        style: AppStyles.textStyleTinyW100Primary60(context))
                  ],
                ),
              ],
            ),
            transaction.type! != 'transfer' ? const SizedBox() :
            Text(transaction.data!.ledger!.uco!.transfers![0].toString(),
                style: AppStyles.textStyleSmallW100Primary(context)),
          ],
        ),
        const SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        const SizedBox(height: 6),
      ],
    );
  }
}

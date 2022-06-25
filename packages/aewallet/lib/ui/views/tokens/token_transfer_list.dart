// ignore_for_file: must_be_immutable
/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/model/address.dart';

// Project imports:
import 'package:aewallet/model/token_transfer_wallet.dart';

class TokenTransferListWidget extends StatefulWidget {
  TokenTransferListWidget({
    super.key,
    this.listTokenTransfer,
    this.onGet,
    this.onDelete,
  });

  List<TokenTransferWallet>? listTokenTransfer;
  final Function(TokenTransferWallet)? onGet;
  final Function()? onDelete;

  @override
  State<TokenTransferListWidget> createState() =>
      _TokenTransferListWidgetState();
}

class _TokenTransferListWidgetState extends State<TokenTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listTokenTransfer!.sort(
        (TokenTransferWallet a, TokenTransferWallet b) =>
            a.to!.compareTo(b.to!));
    return Stack(
      children: <Widget>[
        SizedBox(
          child: Container(
            height: widget.listTokenTransfer!.length * 100,
            padding: const EdgeInsets.only(left: 3.5, right: 3.5),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.background,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: StateContainer.of(context).curTheme.backgroundDark!,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: const Offset(5.0, 5.0),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
              child: ListView.builder(
                itemCount: widget.listTokenTransfer!.length,
                itemBuilder: (BuildContext context, int index) {
                  return displayTokenDetail(
                      context, widget.listTokenTransfer![index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget displayTokenDetail(
      BuildContext context, TokenTransferWallet tokenTransfer) {
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
                    Text(
                        tokenTransfer.token == null
                            ? 'Token 1....'
                            : tokenTransfer.token!,
                        style: AppStyles.textStyleSize14W100Primary(context)),
                    Text(
                        tokenTransfer.toContactName == null
                            ? Address(tokenTransfer.to!).getShortString3()
                            : '${tokenTransfer.toContactName!}\n${Address(tokenTransfer.to!).getShortString3()}',
                        style: AppStyles.textStyleSize10W100Primary60(context))
                  ],
                ),
              ],
            ),
            Text(tokenTransfer.amount!.toString(),
                style: AppStyles.textStyleSize14W100Primary(context)),
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

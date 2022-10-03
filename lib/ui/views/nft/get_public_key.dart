/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';

class GetPublicKeys extends StatefulWidget {
  const GetPublicKeys({
    super.key,
    required this.tokenPropertyWithAccessInfos,
  });

  final TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos;

  @override
  State<GetPublicKeys> createState() => _GetPublicKeysState();
}

class _GetPublicKeysState extends State<GetPublicKeys> {
  FocusNode? publicKeyAccessFocusNode;
  TextEditingController? publicKeyAccessController;
  List<String>? publicKeys;

  @override
  void initState() {
    publicKeyAccessFocusNode = FocusNode();
    publicKeyAccessController = TextEditingController();
    publicKeys = List<String>.empty(growable: true);
    if (widget.tokenPropertyWithAccessInfos.publicKeysList != null) {
      publicKeys = widget.tokenPropertyWithAccessInfos.publicKeysList;
      publicKeys!.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SheetHeader(title: AppLocalization.of(context)!.getPublicKeyHeader),
        Expanded(
          child: Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.tokenPropertyWithAccessInfos.tokenProperty!
                                .keys.first,
                          ),
                          Text(
                            widget.tokenPropertyWithAccessInfos.tokenProperty!
                                .values.first,
                          ),
                          if (publicKeys != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 10,
                                right: 10,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: publicKeys!
                                    .asMap()
                                    .entries
                                    .map((MapEntry<dynamic, String> entry) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: _buildLine(context, entry.value),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLine(BuildContext context, String publicKey) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: StateContainer.of(context)
                .curTheme
                .backgroundAccountsListCardSelected!,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        color: StateContainer.of(context)
            .curTheme
            .backgroundAccountsListCardSelected,
        child: Container(
          height: 60,
          color: StateContainer.of(context).curTheme.backgroundAccountsListCard,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  '${publicKey.substring(0, 15)}...${publicKey.substring(publicKey.length - 15)}',
                                  style: AppStyles.textStyleSize12W600Primary(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

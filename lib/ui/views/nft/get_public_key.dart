import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final localizations = AppLocalization.of(context)!;

    return Column(
      children: <Widget>[
        SheetHeader(title: localizations.getPublicKeyHeader),
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
                                children: publicKeys!
                                    .asMap()
                                    .entries
                                    .map((MapEntry<dynamic, String> entry) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: _GetPublicKeyLine(
                                      publicKey: entry.value,
                                    ),
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
}

class _GetPublicKeyLine extends ConsumerWidget {
  const _GetPublicKeyLine({required this.publicKey});

  final String publicKey;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.backgroundAccountsListCardSelected!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: theme.backgroundAccountsListCardSelected,
        child: Container(
          height: 60,
          color: theme.backgroundAccountsListCard,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                                  style: theme.textStyleSize12W600Primary,
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

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTDetailProperties extends ConsumerWidget {
  const NFTDetailProperties({
    super.key,
    required this.tokenInformations,
  });

  final TokenInformations tokenInformations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final description = tokenInformations.tokenProperties!['description'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            if (description != '')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  description,
                  style: theme.textStyleSize14W600Primary,
                ),
              ),
            if (tokenInformations.tokenProperties != null &&
                tokenInformations.tokenProperties!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Wrap(
                  children: tokenInformations.tokenProperties!.entries.map((
                    MapEntry<String, dynamic> entry,
                  ) {
                    return entry.key != 'content' &&
                            entry.key != 'description' &&
                            entry.key != 'name' &&
                            entry.key != 'type_mime'
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: _buildTokenProperty(
                              context,
                              ref,
                              {entry.key: entry.value},
                            ),
                          )
                        : const SizedBox();
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // TODO(Chralu): Extract to a [Widget] subclass (3)
  Widget _buildTokenProperty(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> property,
  ) {
    final theme = ref.read(ThemeProviders.selectedTheme);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.backgroundAccountsListCardSelected!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: theme.backgroundAccountsListCardSelected,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                property.entries.first.key,
                                style: theme.textStyleSize12W600Primary,
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                property.entries.first.value,
                                style: theme.textStyleSize12W400Primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

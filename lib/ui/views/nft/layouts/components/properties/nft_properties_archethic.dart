/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/string_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTPropertiesArchethic extends ConsumerWidget {
  const NFTPropertiesArchethic({
    super.key,
    required this.property,
  });

  final Map<String, dynamic> property;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (property.entries.first.value is String == false) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ArchethicTheme.backgroundAccountsListCardSelected,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: ArchethicTheme.backgroundAccountsListCardSelected,
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
                                property.entries.first.key.breakText(30),
                                style: ArchethicThemeStyles
                                    .textStyleSize12W600Primary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                property.entries.first.value
                                    .toString()
                                    .breakText(30),
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
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

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:typed_data';

import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTPreviewWidget extends ConsumerWidget {
  const NFTPreviewWidget({
    super.key,
    this.nftFile,
    this.nftSize = 0,
    required this.tokenInformations,
    this.nftPropertiesDeleteAction = true,
  });

  final Uint8List? nftFile;
  final int nftSize;
  final bool nftPropertiesDeleteAction;

  final TokenInformations tokenInformations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final description = tokenInformations.tokenProperties!['description'] ?? '';
    final typeMime = tokenInformations.tokenProperties!['type/mime'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            if (MimeUtil.isImage(typeMime) == true ||
                MimeUtil.isPdf(typeMime) == true)
              if (tokenInformations.address != null)
                FutureBuilder<Uint8List?>(
                  future: TokenUtil.getImageFromTokenAddress(
                    tokenInformations.address!,
                    typeMime,
                  ),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Uint8List?> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return SizedBox(
                        width: 200,
                        height: 130,
                        child: SizedBox(
                          height: 78,
                          child: Center(
                            child: Text(
                              localizations.previewNotAvailable,
                              style: theme.textStyleSize12W100Primary,
                            ),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.text,
                              border: Border.all(),
                            ),
                            child: Image.memory(
                              snapshot.data!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(snapshot.data!.length)}',
                              style: theme.textStyleSize12W400Primary,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.backgroundDark,
                          border: Border.all(),
                        ),
                        child: SizedBox(
                          width: 200,
                          height: 130,
                          child: SizedBox(
                            height: 78,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: theme.text,
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              else
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.text,
                    border: Border.all(),
                  ),
                  child: Image.memory(
                    nftFile!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
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
                    return entry.key != 'file' &&
                            entry.key != 'description' &&
                            entry.key != 'name' &&
                            entry.key != 'type/mime'
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
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

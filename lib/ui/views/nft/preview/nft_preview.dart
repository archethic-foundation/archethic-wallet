/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:filesize/filesize.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';

class NFTPreviewWidget extends StatelessWidget {
  const NFTPreviewWidget({
    super.key,
    this.nftFile,
    this.tokenPropertyWithAccessInfos,
    this.nftSize = 0,
    required this.tokenInformations,
    this.nftPropertiesDeleteAction = true,
  });

  final Uint8List? nftFile;

  final List<TokenPropertyWithAccessInfos>? tokenPropertyWithAccessInfos;
  final int nftSize;
  final bool nftPropertiesDeleteAction;

  final TokenInformations tokenInformations;

  @override
  Widget build(BuildContext context) {
    final String description =
        TokenUtil.getPropertyValue(tokenInformations, 'description');
    final String typeMime =
        TokenUtil.getPropertyValue(tokenInformations, 'type/mime');

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tokenInformations.name!,
              style: AppStyles.textStyleSize18W600Primary(context),
            ),
            const SizedBox(
              height: 10,
            ),
            if (MimeUtil.isImage(typeMime) == true ||
                MimeUtil.isPdf(typeMime) == true)
              if (tokenInformations.address != null)
                FutureBuilder<Uint8List?>(
                  future: TokenUtil.getImageFromTokenAddress(
                    tokenInformations.address!,
                    typeMime,
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Image.memory(
                          snapshot.data!,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.text,
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: Image.memory(
                    nftFile!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            if (nftSize > 0)
              Text(
                '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(nftSize)}',
                style: AppStyles.textStyleSize12W400Primary(context),
              ),
            if (description != '')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  description,
                  style: AppStyles.textStyleSize14W600Primary(context),
                ),
              ),
            if (tokenPropertyWithAccessInfos != null)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: tokenPropertyWithAccessInfos!.asMap().entries.map((
                    MapEntry<dynamic, TokenPropertyWithAccessInfos> entry,
                  ) {
                    return entry.value.tokenProperty!.keys.first != 'file' &&
                            entry.value.tokenProperty!.keys.first !=
                                'description' &&
                            entry.value.tokenProperty!.keys.first != 'name' &&
                            entry.value.tokenProperty!.keys.first != 'type/mime'
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: _buildTokenProperty(context, entry.value),
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

  Widget _buildTokenProperty(
    BuildContext context,
    TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: tokenPropertyWithAccessInfos.publicKeysList != null &&
                    tokenPropertyWithAccessInfos.publicKeysList!.isNotEmpty
                ? const BorderSide(color: Colors.redAccent, width: 2)
                : BorderSide(
                    color: StateContainer.of(context)
                        .curTheme
                        .backgroundAccountsListCardSelected!,
                    width: 1,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: StateContainer.of(context)
              .curTheme
              .backgroundAccountsListCardSelected,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.keys.first,
                                style: AppStyles.textStyleSize12W600Primary(
                                  context,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.values.first,
                                style: AppStyles.textStyleSize12W400Primary(
                                  context,
                                ),
                              ),
                            ),
                            tokenPropertyWithAccessInfos.publicKeysList !=
                                        null &&
                                    tokenPropertyWithAccessInfos
                                        .publicKeysList!.isNotEmpty
                                ? tokenPropertyWithAccessInfos
                                            .publicKeysList!.length ==
                                        1
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: AutoSizeText(
                                          'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public key',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                            context,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: AutoSizeText(
                                          'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public keys',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                            context,
                                          ),
                                        ),
                                      )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: AutoSizeText(
                                      'This property is accessible for everyone',
                                      style:
                                          AppStyles.textStyleSize12W400Primary(
                                        context,
                                      ),
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

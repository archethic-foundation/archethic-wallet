/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/blockchain/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list_detail_popup.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTListDetail extends ConsumerWidget {
  const NFTListDetail({
    super.key,
    required this.name,
    required this.address,
    required this.properties,
    required this.tokenId,
    required this.index,
    required this.symbol,
    required this.collection,
    this.roundBorder = false,
  });

  final String name;
  final String address;
  final String tokenId;
  final String symbol;
  final Map<String, dynamic> properties;
  final List<Map<String, dynamic>> collection;
  final int index;
  final bool roundBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final preferences = ref.watch(SettingsProviders.settings);

    var propertiesToCount = 0;

    properties.forEach((key, value) {
      if (key != 'name' &&
          key != 'content' &&
          key != 'type_mime' &&
          key != 'description') {
        propertiesToCount++;
      }
    });

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: theme.textStyleSize12W600Primary,
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _NFTLabelProperties(propertiesToCount: propertiesToCount),
          ),

          GestureDetector(
            onTap: () {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              Sheets.showAppHeightNineSheet(
                context: context,
                ref: ref,
                widget: NFTDetail(
                  address: address,
                  name: name,
                  properties: properties,
                  collection: collection,
                  symbol: symbol,
                  tokenId: tokenId,
                ),
              );
            },
            onLongPressEnd: (details) {
              NFTListDetailPopup.getPopup(
                context,
                ref,
                details,
                address,
                tokenId,
              );
            },
            child: Card(
              elevation: 5,
              shadowColor: Colors.black,
              margin: const EdgeInsets.only(left: 8, right: 8),
              color: theme.backgroundDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.white10),
              ),
              child: collection.isNotEmpty
                  ? const Text('Collection')
                  : NFTThumbnail(
                      address: address,
                      properties: properties,
                      roundBorder: roundBorder,
                    ),
            ),
          ),
          // TODO(reddwarf03): Implement this feature (3)
          /* NFTCardBottom(
          tokenInformations: tokenInformations,
        ),*/
        ],
      ),
    );
  }
}

class NFTCardBottom extends ConsumerWidget {
  const NFTCardBottom({
    super.key,
    required this.tokenInformations,
  });

  final TokenInformations tokenInformations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull!;
    final nftInfosOffChain = selectedAccount.getftInfosOffChain(
      // TODO(redDwarf03): we should not interact directly with Hive DTOs. Use providers instead. -> which provider / Link to NFT ? (3)
      tokenInformations.id,
    );
    final preferences = ref.watch(SettingsProviders.settings);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*InkWell(
                  onTap: (() async {
                    sl.get<HapticUtil>().feedback(FeedbackType.light,
                        StateContainer.of(context).activeVibrations);
                    await accountSelected
                        .updateNftInfosOffChain(
                            tokenAddress: widget.tokenInformations.address,
                            favorite: false);
                  }),
                  child: const Icon(
                    Symbols.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),*/
                InkWell(
                  onTap: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );

                    await selectedAccount.updateNftInfosOffChainFavorite(
                      tokenInformations.id,
                    );
                  },
                  child: nftInfosOffChain == null ||
                          nftInfosOffChain.favorite == false
                      ? Icon(
                          Symbols.favorite_border,
                          color: theme.favoriteIconColor,
                          size: 18,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                        )
                      : Icon(
                          Symbols.favorite,
                          color: theme.favoriteIconColor,
                          size: 18,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                          fill: 1,
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

class _NFTLabelProperties extends ConsumerWidget {
  const _NFTLabelProperties({
    required this.propertiesToCount,
  });

  final int propertiesToCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    return propertiesToCount == 0
        ? Text(
            localizations.noProperty,
            style: theme.textStyleSize12W100Primary,
          )
        : propertiesToCount == 1
            ? Text(
                '$propertiesToCount ${localizations.property}',
                style: theme.textStyleSize12W400Primary,
              )
            : Text(
                '$propertiesToCount ${localizations.properties}',
                style: theme.textStyleSize12W400Primary,
              );
  }
}

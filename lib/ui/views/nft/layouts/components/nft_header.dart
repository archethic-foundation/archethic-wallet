/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTHeader extends ConsumerWidget {
  const NFTHeader({
    super.key,
    required this.currentNftCategoryIndex,
    this.displayCategoryName = false,
  });
  final int currentNftCategoryIndex;
  final bool displayCategoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final nftCategories = ref
        .watch(
          NftCategoryProviders.selectedAccountNftCategories(
            context: context,
          ),
        )
        .valueOrNull;

    if (nftCategories == null) return const SizedBox();

    final nftCategory = nftCategories
        .where(
          (element) => element.id == currentNftCategoryIndex,
        )
        .first;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(
                start: smallScreen(context) ? 15 : 20,
              ),
              height: 50,
              width: 50,
              child: BackButton(
                key: const Key('back'),
                color: theme.text,
                onPressed: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const _NFTHeaderBackPopup();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const BalanceIndicatorWidget(
          displaySwitchButton: false,
        ),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning()
        else
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Column(
              children: [
                Hero(
                  tag: 'nftCategory${nftCategory.name!}',
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    color: theme.backgroundDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Colors.white10,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        nftCategory.image,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                if (displayCategoryName)
                  Text(
                    nftCategory.name!,
                    textAlign: TextAlign.center,
                    style: theme.textStyleSize12W100Primary,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _NFTHeaderBackPopup extends ConsumerWidget {
  const _NFTHeaderBackPopup();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return PopupDialog(
      title: Text(
        localizations.exitNFTCreationProcessTitle,
        style: theme.textStyleSize16W400Primary,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.exitNFTCreationProcessSubtitle,
            style: theme.textStyleSize14W200Primary,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              AppButtonTiny(
                AppButtonTinyType.primary,
                localizations.no,
                Dimens.buttonTopDimens,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              AppButtonTiny(
                AppButtonTinyType.primary,
                localizations.yes,
                Dimens.buttonTopDimens,
                onPressed: () {
                  /**
                   * Go back 2 times:
                   * - Popup
                   * - Nft form creation
                   */
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

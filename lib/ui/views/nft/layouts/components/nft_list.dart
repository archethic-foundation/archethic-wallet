/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list_detail.dart';
import 'package:aewallet/ui/widgets/components/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTList extends ConsumerWidget {
  const NFTList({super.key, required this.currentNftCategoryIndex});
  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

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

    final accountTokenList =
        accountSelected?.getAccountNFTFiltered(nftCategory.id) ?? [];

    if (accountTokenList.isEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Opacity(
                  opacity: 0.5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/nft-empty.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Symbols.info,
                  color: theme.text,
                  size: 20,
                  weight: IconSize.weightM,
                  opticalSize: IconSize.opticalSizeM,
                  grade: IconSize.gradeM,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                localizations.nftListEmptyExplanation,
                style: theme.textStyleSize12W100Primary,
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: DynamicHeightGridView(
          crossAxisCount:
              Responsive.isDesktop(context) || Responsive.isTablet(context)
                  ? 3
                  : 2,
          crossAxisSpacing: 20,
          shrinkWrap: true,
          itemCount: accountTokenList.length,
          builder: (context, index) {
            final tokenInformations =
                accountTokenList[index].tokenInformations!;
            return NFTListDetail(
              tokenInformations: tokenInformations,
              index: index,
              roundBorder: true,
            );
          },
        ),
      ),
    );
  }
}

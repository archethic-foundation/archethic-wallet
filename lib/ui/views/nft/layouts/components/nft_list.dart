/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list_detail.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTList extends ConsumerWidget {
  const NFTList({super.key, required this.currentNftCategoryIndex});
  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
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
                  child: Image.asset(
                    'assets/images/nft-empty.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  UiIcons.about,
                  color: theme.text,
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                localizations.nftListEmptyExplanation,
                style: theme.textStyleSize12W100Primary,
              )
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          primary: false,
          shrinkWrap: true,
          itemCount: accountTokenList.length,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemBuilder: (context, index) {
            final tokenInformations =
                accountTokenList[index].tokenInformations!;

            return NFTListDetail(
              tokenInformations: tokenInformations,
              index: index,
            );
          },
        ),
      ),
    );
  }
}

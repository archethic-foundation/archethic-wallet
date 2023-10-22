import 'dart:io';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConfigureCategoryList extends ConsumerStatefulWidget {
  const ConfigureCategoryList({super.key});

  @override
  ConsumerState<ConfigureCategoryList> createState() =>
      _ConfigureCategoryListState();
}

class _ConfigureCategoryListState extends ConsumerState<ConfigureCategoryList> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    final listNftCategory = ref
        .watch(
          NftCategoryProviders.selectedAccountNftCategories(
            context: context,
          ),
        )
        .valueOrNull;

    if (accountSelected == null || listNftCategory == null) {
      return const SizedBox();
    }

    final nftCategoryToHidden = ref.watch(
      NftCategoryProviders.listNFTCategoryHidden(
        context: context,
      ),
    );

    return Column(
      children: <Widget>[
        SheetHeader(
          title: localizations.customizeCategoryListHeader,
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: 20,
                ),
                child: ReorderableWidget(
                  nftCategory: listNftCategory,
                  nftCategoryToHidden: nftCategoryToHidden,
                  accountSelected: accountSelected,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReorderableWidget extends ConsumerWidget {
  const ReorderableWidget({
    super.key,
    required this.nftCategory,
    required this.nftCategoryToHidden,
    required this.accountSelected,
  });

  final List<NftCategory> nftCategory;
  final List<NftCategory> nftCategoryToHidden;
  final Account accountSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCategoryToSort = nftCategory;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                localizations.availableCategories,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onReorder: (oldIndex, newIndex) async {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  final nftCategory = nftCategoryToSort.removeAt(oldIndex);
                  nftCategoryToSort.insert(newIndex, nftCategory);

                  NftCategoryProvidersActions.updateNftCategoryList(
                    ref,
                    nftCategoryListCustomized: nftCategoryToSort,
                    account: accountSelected,
                  );
                },
                children: [
                  for (final NftCategory nftCategory in nftCategoryToSort)
                    Column(
                      key: ValueKey(nftCategory),
                      children: [
                        ListTile(
                          title: Text(
                            nftCategory.name!,
                            style:
                                ArchethicThemeStyles.textStyleSize12W400Primary,
                          ),
                          leading: nftCategory.id != 0
                              ? IconButton(
                                  icon: const Icon(
                                    Symbols.remove_circle,
                                    fill: 1,
                                  ),
                                  hoverColor: ArchethicTheme.text,
                                  onPressed: () {
                                    nftCategoryToSort.removeWhere(
                                      (element) => element.id == nftCategory.id,
                                    );

                                    NftCategoryProvidersActions
                                        .updateNftCategoryList(
                                      ref,
                                      nftCategoryListCustomized:
                                          nftCategoryToSort,
                                      account: accountSelected,
                                    );
                                  },
                                  color:
                                      Colors.redAccent[400]!.withOpacity(0.5),
                                )
                              : const SizedBox(),
                          trailing: (!kIsWeb &&
                                  (Platform.isAndroid || Platform.isIOS))
                              ? ReorderableDragStartListener(
                                  index: nftCategoryToSort.indexOf(nftCategory),
                                  child: const Icon(
                                    Symbols.drag_handle,
                                    weight: IconSize.weightM,
                                    opticalSize: IconSize.opticalSizeM,
                                    grade: IconSize.gradeM,
                                  ),
                                )
                              : null,
                        ),
                        const Divider(
                          height: 1,
                        ),
                      ],
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  localizations.hiddenCategories,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  textAlign: TextAlign.justify,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (final NftCategory nftCategory in nftCategoryToHidden)
                    if (nftCategory.id != 0)
                      Column(
                        key: ValueKey(nftCategory),
                        children: [
                          ListTile(
                            title: Text(
                              nftCategory.name!,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W400Primary,
                            ),
                            leading: IconButton(
                              icon: const Icon(
                                Symbols.add_circle,
                                fill: 1,
                              ),
                              onPressed: () {
                                nftCategoryToHidden.removeWhere(
                                  (element) => element.id == nftCategory.id,
                                );
                                nftCategoryToSort.add(nftCategory);

                                NftCategoryProvidersActions
                                    .updateNftCategoryList(
                                  ref,
                                  nftCategoryListCustomized: nftCategoryToSort,
                                  account: accountSelected,
                                );
                              },
                              color: Colors.greenAccent[400]!.withOpacity(0.5),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                        ],
                      ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  AppButtonTiny(
                    AppButtonTinyType.primaryOutline,
                    localizations.addNftNewCategory,
                    Dimens.buttonBottomDimens,
                    key: const Key('addNftNewCategory'),
                    onPressed: () {},
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

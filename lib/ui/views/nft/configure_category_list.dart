/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigureCategoryList extends ConsumerStatefulWidget {
  const ConfigureCategoryList({super.key});

  @override
  ConsumerState<ConfigureCategoryList> createState() => _ConfigureCategoryListState();
}

class _ConfigureCategoryListState extends ConsumerState<ConfigureCategoryList> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final listNftCategory = ref.read(
      NftCategoryProviders.fetchNftCategory(
        context,
        StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!,
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
                child: ReorderableWidget(nftCategory: listNftCategory),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReorderableWidget extends ConsumerStatefulWidget {
  const ReorderableWidget({super.key, required this.nftCategory});

  final List<NftCategory> nftCategory;

  @override
  ConsumerState<ReorderableWidget> createState() => _ReorderableWidgetState();
}

class _ReorderableWidgetState extends ConsumerState<ReorderableWidget> {
  List<NftCategory>? nftCategoryToHidden = List<NftCategory>.empty(growable: true);

  List<NftCategory>? nftCategoryToSort = List<NftCategory>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected = StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!;

    nftCategoryToHidden = ref.read(
      NftCategoryProviders.fetchNftCategory(context, accountSelected),
    );

    nftCategoryToSort = widget.nftCategory;
    for (final nftCategory in nftCategoryToSort!) {
      nftCategoryToHidden!.removeWhere((element) => element.id == nftCategory.id);
    }

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
                'Available categories',
                style: theme.textStyleSize12W100Primary,
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
                  setState(() {
                    final nftCategory = nftCategoryToSort!.removeAt(oldIndex);
                    nftCategoryToSort!.insert(newIndex, nftCategory);
                  });
                  ref.watch(
                    NftCategoryProviders.updateNftCategoryList(
                      nftCategoryListCustomized: nftCategoryToSort!,
                      account: accountSelected,
                    ),
                  );
                },
                children: [
                  for (NftCategory nftCategory in nftCategoryToSort!)
                    Column(
                      key: ValueKey(nftCategory),
                      children: [
                        ListTile(
                          title: Text(
                            nftCategory.name!,
                            style: theme.textStyleSize12W400Primary,
                          ),
                          leading: nftCategory.id != 0
                              ? IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  hoverColor: theme.text,
                                  onPressed: () async {
                                    nftCategoryToSort!.removeWhere(
                                      (element) => element.id == nftCategory.id,
                                    );
                                    setState(() {});
                                    ref.watch(
                                      NftCategoryProviders.updateNftCategoryList(
                                        nftCategoryListCustomized: nftCategoryToSort!,
                                        account: accountSelected,
                                      ),
                                    );
                                  },
                                  color: Colors.redAccent[400]!.withOpacity(0.5),
                                )
                              : const SizedBox(),
                          trailing: !kIsWeb && Platform.isIOS
                              ? ReorderableDragStartListener(
                                  index: nftCategoryToSort!.indexOf(nftCategory),
                                  child: const Icon(Icons.drag_handle),
                                )
                              : null,
                        ),
                        const Divider(
                          height: 1,
                        )
                      ],
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Hidden categories',
                  style: theme.textStyleSize12W100Primary,
                  textAlign: TextAlign.justify,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (NftCategory nftCategory in nftCategoryToHidden!)
                    if (nftCategory.id != 0)
                      Column(
                        key: ValueKey(nftCategory),
                        children: [
                          ListTile(
                            title: Text(
                              nftCategory.name!,
                              style: theme.textStyleSize12W400Primary,
                            ),
                            leading: IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () async {
                                nftCategoryToHidden!.removeWhere(
                                  (element) => element.id == nftCategory.id,
                                );
                                nftCategoryToSort!.add(nftCategory);

                                setState(() {});
                                ref.watch(
                                  NftCategoryProviders.updateNftCategoryList(
                                    nftCategoryListCustomized: nftCategoryToSort!,
                                    account: accountSelected,
                                  ),
                                );
                              },
                              color: Colors.greenAccent[400]!.withOpacity(0.5),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          )
                        ],
                      ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  AppButton.buildAppButtonTiny(
                    const Key('addNftNewCategory'),
                    context,
                    ref,
                    AppButtonType.primaryOutline,
                    localizations.addNftNewCategory,
                    Dimens.buttonBottomDimens,
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

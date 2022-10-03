/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/refresh_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';

class ConfigureCategoryList extends StatefulWidget {
  const ConfigureCategoryList({super.key});

  @override
  State<ConfigureCategoryList> createState() => _ConfigureCategoryListState();
}

class _ConfigureCategoryListState extends State<ConfigureCategoryList> {
  @override
  void dispose() {
    EventTaxiImpl.singleton().fire(RefreshEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SheetHeader(
          title: AppLocalization.of(context)!.customizeCategoryListHeader,
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
                  nftCategory: StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .getListNftCategory(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReorderableWidget extends StatefulWidget {
  const ReorderableWidget({super.key, required this.nftCategory});

  final List<NftCategory> nftCategory;

  @override
  State<ReorderableWidget> createState() => _ReorderableWidgetState();
}

class _ReorderableWidgetState extends State<ReorderableWidget> {
  List<NftCategory>? nftCategoryToHidden =
      List<NftCategory>.empty(growable: true);

  List<NftCategory>? nftCategoryToSort =
      List<NftCategory>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    nftCategoryToHidden = NftCategory.getListByDefault(context);
    nftCategoryToSort = widget.nftCategory;
    for (final NftCategory nftCategory in nftCategoryToSort!) {
      nftCategoryToHidden!
          .removeWhere((element) => element.id == nftCategory.id);
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
                style: AppStyles.textStyleSize12W100Primary(context),
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
                  await StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .updateNftCategoryList(nftCategoryToSort!);
                },
                children: [
                  for (NftCategory nftCategory in nftCategoryToSort!)
                    Column(
                      key: ValueKey(nftCategory),
                      children: [
                        ListTile(
                          title: Text(
                            nftCategory.name!,
                            style:
                                AppStyles.textStyleSize12W400Primary(context),
                          ),
                          leading: nftCategory.id != 0
                              ? IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  hoverColor:
                                      StateContainer.of(context).curTheme.text,
                                  onPressed: () async {
                                    nftCategoryToSort!.removeWhere(
                                      (element) => element.id == nftCategory.id,
                                    );
                                    setState(() {});
                                    await StateContainer.of(context)
                                        .appWallet!
                                        .appKeychain!
                                        .getAccountSelected()!
                                        .updateNftCategoryList(
                                          nftCategoryToSort!,
                                        );
                                  },
                                  color:
                                      Colors.redAccent[400]!.withOpacity(0.5),
                                )
                              : const SizedBox(),
                          trailing: !kIsWeb && Platform.isIOS
                              ? ReorderableDragStartListener(
                                  index:
                                      nftCategoryToSort!.indexOf(nftCategory),
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
                  style: AppStyles.textStyleSize12W100Primary(context),
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
                              style:
                                  AppStyles.textStyleSize12W400Primary(context),
                            ),
                            leading: IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () async {
                                nftCategoryToHidden!.removeWhere(
                                  (element) => element.id == nftCategory.id,
                                );
                                nftCategoryToSort!.add(nftCategory);

                                setState(() {});
                                await StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .updateNftCategoryList(
                                      nftCategoryToSort!,
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
                    AppButtonType.primaryOutline,
                    AppLocalization.of(context)!.addNftNewCategory,
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

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';

class ConfigureCategoryList extends StatefulWidget {
  const ConfigureCategoryList({
    super.key,
  });

  @override
  State<ConfigureCategoryList> createState() => _ConfigureCategoryListState();
}

class _ConfigureCategoryListState extends State<ConfigureCategoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SheetHeader(
            title: AppLocalization.of(context)!.customizeCategoryListHeader),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: 20,
              ),
              child: ReorderableWidget(
                nftCategoryToSort: StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .getListNftCategory(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReorderableWidget extends StatefulWidget {
  const ReorderableWidget({super.key, required this.nftCategoryToSort});

  final List<NftCategory> nftCategoryToSort;

  @override
  State<ReorderableWidget> createState() => _ReorderableWidgetState();
}

class _ReorderableWidgetState extends State<ReorderableWidget> {
  List<NftCategory>? nftCategoryToHidden =
      List<NftCategory>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    nftCategoryToHidden = NftCategory.getListByDefault(context);
    for (NftCategory nftCategory in widget.nftCategoryToSort) {
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
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Available categories',
                style: AppStyles.textStyleSize12W100Primary(context),
                textAlign: TextAlign.justify,
              ),
            ),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              onReorder: ((oldIndex, newIndex) async {
                setState(() {
                  final nftCategory =
                      widget.nftCategoryToSort.removeAt(oldIndex);
                  widget.nftCategoryToSort.insert(newIndex, nftCategory);
                });
                await StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .updateNftCategoryList(widget.nftCategoryToSort);
              }),
              children: [
                for (NftCategory nftCategory in widget.nftCategoryToSort)
                  Column(
                    key: ValueKey(nftCategory),
                    children: [
                      ListTile(
                        title: Text(nftCategory.name!),
                        leading: nftCategory.id != 0
                            ? IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: (() async {
                                  widget.nftCategoryToSort.removeWhere(
                                    (element) => element.id == nftCategory.id,
                                  );
                                  setState(() {});
                                  await StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .updateNftCategoryList(
                                          widget.nftCategoryToSort);
                                }),
                                color: Colors.redAccent[400]!.withOpacity(0.5))
                            : const SizedBox(),
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
                            title: Text(nftCategory.name!),
                            leading: IconButton(
                                icon: const Icon(Icons.add_circle),
                                onPressed: (() async {
                                  nftCategoryToHidden!.removeWhere(
                                    (element) => element.id == nftCategory.id,
                                  );
                                  widget.nftCategoryToSort.add(nftCategory);

                                  setState(() {});
                                  await StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .updateNftCategoryList(
                                          widget.nftCategoryToSort);
                                }),
                                color:
                                    Colors.greenAccent[400]!.withOpacity(0.5))),
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
                    onPressed: () {}),
              ],
            )
          ],
        )),
      ),
    );
  }
}

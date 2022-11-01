/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCreationFormSheet extends ConsumerWidget {
  const NftCreationFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected =
        StateContainer.of(context).appWallet!.appKeychain.getAccountSelected()!;

    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final listNftCategory = ref.watch(
      NftCategoryProviders.fetchNftCategory(
        context: context,
        account: accountSelected,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const BalanceIndicatorWidget(
                      displaySwitchButton: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            color: theme.backgroundDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.white10,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                listNftCategory[
                                        nftCreation.currentNftCategoryIndex]
                                    .image,
                                width: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  color: theme.text15,
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(height: 100),
                    child: ContainedTabBarView(
                      tabBarViewProperties: const TabBarViewProperties(
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      tabBarProperties: TabBarProperties(
                        labelColor: theme.text,
                        labelStyle: theme.textStyleSize10W100Primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: theme.text,
                      ),
                      tabs: [
                        Tab(
                          text: AppLocalization.of(context)!
                              .nftCreationProcessTabImportHeader,
                          icon: const Icon(UiIcons.nft_creation_process_import),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabDescriptionHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_description,
                          ),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabPropertiesHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_properties,
                          ),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabConfirmationHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_confirmation,
                          ),
                        ),
                      ],
                      views: const [
                        NFTCreationProcessImportTab(),
                        NFTCreationProcessInfosTab(),
                        NFTCreationProcessPropertiesTab(),
                        NFTCreationProcessConfirmationTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

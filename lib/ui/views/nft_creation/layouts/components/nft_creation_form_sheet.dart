import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
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

    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
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
                NFTHeader(
                  currentNftCategoryIndex: nftCreation.currentNftCategoryIndex,
                ),
                Divider(
                  height: 2,
                  color: theme.text15,
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(height: 100),
                    child: ContainedTabBarView(
                      initialIndex: nftCreation.indexTab,
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
                          text:
                              localizations.nftCreationProcessTabSummaryHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_summary,
                          ),
                        ),
                      ],
                      views: const [
                        NFTCreationProcessImportTab(),
                        NFTCreationProcessInfosTab(),
                        NFTCreationProcessPropertiesTab(),
                        NFTCreationProcessSummaryTab(),
                      ],
                      onChange: (index) {
                        final nftCreationArgs = ref.read(
                          NftCreationFormProvider.nftCreationFormArgs,
                        );
                        ref
                            .watch(
                              NftCreationFormProvider.nftCreationForm(
                                nftCreationArgs,
                              ).notifier,
                            )
                            .setIndexTab(index);
                        if (index == NftCreationTab.summary.index) {
                          ref
                              .watch(
                                NftCreationFormProvider.nftCreationForm(
                                  nftCreationArgs,
                                ).notifier,
                              )
                              .setFees(
                                context,
                              );
                          return;
                        }
                      },
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

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NftCreationFormSheet extends ConsumerStatefulWidget {
  const NftCreationFormSheet({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NftCreationFormSheetState();
}

class _NftCreationFormSheetState extends ConsumerState<NftCreationFormSheet> {
  final GlobalKey<ContainedTabBarViewState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final activeVibrations = ref.watch(
      SettingsProviders.settings.select((value) => value.activeVibrations),
    );
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (nftCreation.indexTab == 0)
                        AppButtonTinyWithoutExpanded(
                          AppButtonTinyType.primaryOutline,
                          localizations.previousButton,
                          Dimens.buttonTopDimens,
                          key: const Key('previous'),
                          width: 100,
                          onPressed: () {},
                        )
                      else
                        AppButtonTinyWithoutExpanded(
                          AppButtonTinyType.primary,
                          localizations.previousButton,
                          Dimens.buttonTopDimens,
                          key: const Key('previous'),
                          width: 100,
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  activeVibrations,
                                );
                            _key.currentState?.previous();
                          },
                        ),
                      if (nftCreation.indexTab == 3)
                        AppButtonTinyWithoutExpanded(
                          AppButtonTinyType.primaryOutline,
                          localizations.nextButton,
                          Dimens.buttonTopDimens,
                          key: const Key('next'),
                          width: 100,
                          onPressed: () {},
                        )
                      else
                        AppButtonTinyWithoutExpanded(
                          AppButtonTinyType.primary,
                          localizations.nextButton,
                          Dimens.buttonTopDimens,
                          key: const Key('next'),
                          width: 100,
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  activeVibrations,
                                );
                            _key.currentState?.next();
                          },
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(height: 150),
                    child: ContainedTabBarView(
                      key: _key,
                      initialIndex: nftCreation.indexTab,
                      tabBarViewProperties: const TabBarViewProperties(
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      tabBarProperties: TabBarProperties(
                        position: TabBarPosition.bottom,
                        labelColor: theme.text,
                        labelStyle: theme.textStyleSize10W100Primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: theme.text,
                      ),
                      tabs: [
                        Tab(
                          text: localizations
                              .nftCreationProcessTabDescriptionHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_description,
                          ),
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!
                              .nftCreationProcessTabImportHeader,
                          icon: const Icon(UiIcons.nft_creation_process_import),
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
                        NFTCreationProcessInfosTab(),
                        NFTCreationProcessImportTab(),
                        NFTCreationProcessPropertiesTab(),
                        NFTCreationProcessSummaryTab(),
                      ],
                      onChange: (index) {
                        final nftCreationArgs = ref.read(
                          NftCreationFormProvider.nftCreationFormArgs,
                        );
                        ref
                            .read(
                              NftCreationFormProvider.nftCreationForm(
                                nftCreationArgs,
                              ).notifier,
                            )
                            .setIndexTab(index);
                        if (index == NftCreationTab.summary.index) {
                          if (nftCreation.name.isEmpty ||
                              (nftCreation.fileDecodedForPreview == null &&
                                  nftCreation.isFileImportFile())) {
                            ref.read(
                              NftCreationFormProvider.nftCreationForm(
                                nftCreationArgs,
                              ).notifier,
                            )
                              ..controlFile(context)
                              ..controlName(context);
                          }
                          if (nftCreation.name.isEmpty ||
                              (nftCreation.fileDecodedForPreview == null &&
                                  nftCreation.isFileImportUrl())) {
                            ref.read(
                              NftCreationFormProvider.nftCreationForm(
                                nftCreationArgs,
                              ).notifier,
                            )
                              ..controlURL(context)
                              ..controlName(context);
                          }
                          ref
                              .read(
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

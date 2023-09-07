import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/popup_dialog.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  onPressBack: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const _NFTCreationBackPopup();
                      },
                    );
                  },
                ),
                Divider(
                  height: 2,
                  color: theme.text15,
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
                            Icons.description_outlined,
                          ),
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!
                              .nftCreationProcessTabImportHeader,
                          icon: const Icon(
                            Icons.download_outlined,
                          ),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabPropertiesHeader,
                          icon: const Icon(
                            Icons.settings_outlined,
                          ),
                        ),
                        Tab(
                          text:
                              localizations.nftCreationProcessTabSummaryHeader,
                          icon: const Icon(
                            Icons.check_circle_outlined,
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

class _NFTCreationBackPopup extends ConsumerWidget {
  const _NFTCreationBackPopup();

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

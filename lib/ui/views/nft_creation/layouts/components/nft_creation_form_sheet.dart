import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/popup_dialog.dart';
import 'package:aewallet/ui/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NftCreationFormSheet extends ConsumerStatefulWidget {
  const NftCreationFormSheet({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NftCreationFormSheetState();
}

class _NftCreationFormSheetState extends ConsumerState<NftCreationFormSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          child: SafeArea(
            child: Column(
              children: [
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
                const Expanded(
                  child: TabBarView(
                    children: [
                      NFTCreationProcessInfosTab(),
                      NFTCreationProcessImportTab(),
                      NFTCreationProcessPropertiesTab(),
                      NFTCreationProcessSummaryTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TabBar(
              labelColor: theme.text,
              indicatorColor: theme.text,
              labelPadding: EdgeInsets.zero,
              tabs: [
                TabItem(
                  icon: Symbols.description,
                  label: AppLocalizations.of(context)!
                      .nftCreationProcessTabDescriptionHeader,
                ),
                TabItem(
                  icon: Symbols.download,
                  label: AppLocalizations.of(context)!
                      .nftCreationProcessTabImportHeader,
                ),
                TabItem(
                  icon: Symbols.settings,
                  label: AppLocalizations.of(context)!
                      .nftCreationProcessTabPropertiesHeader,
                ),
                TabItem(
                  icon: Symbols.check_circle,
                  label: AppLocalizations.of(context)!
                      .nftCreationProcessTabSummaryHeader,
                ),
              ],
              onTap: (selectedIndex) {
                final nftCreationArgs = ref.read(
                  NftCreationFormProvider.nftCreationFormArgs,
                );
                ref
                    .read(
                      NftCreationFormProvider.nftCreationForm(
                        nftCreationArgs,
                      ).notifier,
                    )
                    .setIndexTab(selectedIndex);
                if (selectedIndex == NftCreationTab.summary.index) {
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

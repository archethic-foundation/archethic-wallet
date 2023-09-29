import 'dart:ui';

import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
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
        extendBodyBehindAppBar: true,
        extendBody: true,
        drawerEdgeDragWidth: 0,
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                theme.background4Small!,
              ),
              fit: BoxFit.fill,
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
                    AppDialogs.showConfirmDialog(
                      context,
                      ref,
                      AppLocalizations.of(context)!.exitNFTCreationProcessTitle,
                      AppLocalizations.of(context)!
                          .exitNFTCreationProcessSubtitle,
                      AppLocalizations.of(context)!.yes,
                      () {
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
                      cancelText: AppLocalizations.of(context)!.no,
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TabBar(
                    dividerColor: Colors.transparent,
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
                        enabled: nftCreation.canAccessToSummary,
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
                          ref
                              .read(
                                NftCreationFormProvider.nftCreationForm(
                                  nftCreationArgs,
                                ).notifier,
                              )
                              .controlFile(context);
                        }
                        if (nftCreation.name.isEmpty ||
                            (nftCreation.fileDecodedForPreview == null &&
                                nftCreation.isFileImportUrl())) {
                          ref
                              .read(
                                NftCreationFormProvider.nftCreationForm(
                                  nftCreationArgs,
                                ).notifier,
                              )
                              .controlURL(context);
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
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NftCreationFormSheet extends ConsumerStatefulWidget {
  const NftCreationFormSheet({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NftCreationFormSheetState();
}

class _NftCreationFormSheetState extends ConsumerState<NftCreationFormSheet>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController!.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    final selectedIndex = _tabController!.index;
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm,
    );
    ref
        .read(
          NftCreationFormProvider.nftCreationForm.notifier,
        )
        .setIndexTab(selectedIndex);
    if (selectedIndex == NftCreationTab.summary.index) {
      if (nftCreation.name.isEmpty ||
          (nftCreation.fileDecodedForPreview == null &&
              nftCreation.isFileImportFile())) {
        ref
            .read(
              NftCreationFormProvider.nftCreationForm.notifier,
            )
            .controlFile(context);
      }
      if (nftCreation.name.isEmpty ||
          (nftCreation.fileDecodedForPreview == null &&
              nftCreation.isFileImportUrl())) {
        ref
            .read(
              NftCreationFormProvider.nftCreationForm.notifier,
            )
            .controlURL(context);
      }
      ref
          .read(
            NftCreationFormProvider.nftCreationForm.notifier,
          )
          .setFees(
            context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm,
    );

    final myTabs = <TabItem>[
      TabItem(
        icon: Symbols.description,
        label: AppLocalizations.of(context)!
            .nftCreationProcessTabDescriptionHeader,
      ),
      TabItem(
        icon: Symbols.download,
        label: AppLocalizations.of(context)!.nftCreationProcessTabImportHeader,
      ),
      TabItem(
        icon: Symbols.settings,
        label:
            AppLocalizations.of(context)!.nftCreationProcessTabPropertiesHeader,
      ),
      TabItem(
        icon: Symbols.check_circle,
        label: AppLocalizations.of(context)!.nftCreationProcessTabSummaryHeader,
        enabled: nftCreation.canAccessToSummary,
      ),
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        drawerEdgeDragWidth: 0,
        resizeToAvoidBottomInset: false,
        backgroundColor: ArchethicTheme.background,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ArchethicTheme.backgroundSmall,
              ),
              fit: BoxFit.fitHeight,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                ArchethicTheme.backgroundDark,
                ArchethicTheme.background,
              ],
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
                        context.go(HomePage.routerPage);
                      },
                      cancelText: AppLocalizations.of(context)!.no,
                    );
                  },
                ),
                Divider(
                  height: 2,
                  color: ArchethicTheme.text15,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
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
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    labelColor: ArchethicTheme.text,
                    indicatorColor: ArchethicTheme.text,
                    labelPadding: EdgeInsets.zero,
                    tabs: myTabs,
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

import 'dart:ui';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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
    with SingleTickerProviderStateMixin
    implements SheetSkeletonInterface {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      sheetContent: getSheetContent(context, ref),
      menu: true,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return SheetAppBar(
      title: ' ',
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          AppDialogs.showConfirmDialog(
            context,
            ref,
            AppLocalizations.of(context)!.exitNFTCreationProcessTitle,
            AppLocalizations.of(context)!.exitNFTCreationProcessSubtitle,
            AppLocalizations.of(context)!.yes,
            () {
              context.go(HomePage.routerPage);
            },
            cancelText: AppLocalizations.of(context)!.no,
          );
        },
      ),
      widgetRight:
          connectivityStatusProvider == ConnectivityStatus.isDisconnected
              ? const Padding(
                  padding: EdgeInsets.only(right: 7, top: 7),
                  child: IconNetworkWarning(),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: BalanceIndicatorWidget(
                    displaySwitchButton: false,
                    allDigits: false,
                    displayLabel: false,
                  ),
                ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ArchethicTheme.backgroundSmall,
          ),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
          opacity: 0.7,
        ),
      ),
      child: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: const [
              NFTCreationProcessInfosTab(),
              NFTCreationProcessImportTab(),
              NFTCreationProcessPropertiesTab(),
              NFTCreationProcessSummaryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

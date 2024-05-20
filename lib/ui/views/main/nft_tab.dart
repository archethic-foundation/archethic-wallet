/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_provider.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:aewallet/ui/views/main/components/nft_search_bar.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft/layouts/configure_category_list.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_category_menu.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTTab extends ConsumerWidget {
  const NFTTab({
    super.key,
  });

  static const String routerPage = '/nftTab';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        NftSearchBarProvider.initialNftSearchBar.overrideWithValue(
          const NftSearchBarState(),
        ),
      ],
      child: const NFTTabBody(),
    );
  }
}

class NFTTabBody extends ConsumerWidget implements SheetSkeletonInterface {
  const NFTTabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    return SheetAppBar(
      title: AppLocalizations.of(context)!.nftHeader,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(HomePage.routerPage);
        },
      ),
      widgetRight: IconButton(
        icon: const Icon(
          Symbols.tune,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          context.push(ConfigureCategoryList.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return ArchethicRefreshIndicator(
      onRefresh: () => Future<void>.sync(() async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );

        final connectivityStatusProvider =
            ref.read(connectivityStatusProviders);
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
          return;
        }

        await ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();
      }),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.nftTabDescriptionHeader,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 20,
          ),
          const NFTSearchBar(),
          const SizedBox(
            height: 20,
          ),
          const NftCategoryMenu(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

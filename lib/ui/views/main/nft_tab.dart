/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_provider.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:aewallet/ui/views/main/components/nft_search_bar.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_category_menu.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTTab extends ConsumerWidget {
  const NFTTab({
    super.key,
  });

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

class NFTTabBody extends ConsumerWidget {
  const NFTTabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      bottom: MediaQuery.of(context).padding.bottom + 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.nftTabDescriptionHeader,
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

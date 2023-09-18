/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return Column(
      children: [
        Expanded(
          child: ArchethicRefreshIndicator(
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );

              final connectivityStatusProvider =
                  ref.read(connectivityStatusProviders);
              if (connectivityStatusProvider ==
                  ConnectivityStatus.isDisconnected) {
                return;
              }

              await ref
                  .read(AccountProviders.selectedAccount.notifier)
                  .refreshNFTs();
            }),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          theme.background3Small!,
                        ),
                        fit: BoxFit.fill,
                        opacity: 0.7,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .nftTabDescriptionHeader,
                            style: theme.textStyleSize12W400Primary,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const NFTSearchBar(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Expanded(
                            child: NftCategoryMenu(),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

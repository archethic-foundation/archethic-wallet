/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_category_menu.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft_tab.g.dart';

@riverpod
List<NftCategory> fetchNftCategory(
  FetchNftCategoryRef ref, {
  required Account account,
  required BuildContext context,
}) {
  final nftCategoryListCustomized = List<NftCategory>.empty(growable: true);
  if (account.nftCategoryList == null) {
    return ref.read(NftCategoryProviders.getListByDefault(context: context));
  }

  for (final nftCategoryId in account.nftCategoryList!) {
    nftCategoryListCustomized.add(
      ref
          .read(NftCategoryProviders.getListByDefault(context: context))
          .elementAt(nftCategoryId),
    );
  }
  return nftCategoryListCustomized;
}

class NFTTab extends ConsumerWidget {
  const NFTTab({super.key});

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
              await ref
                  .read(AccountProviders.selectedAccount.notifier)
                  .refreshNFTs();
            }),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
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
                        fit: BoxFit.fitHeight,
                        opacity: 0.7,
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          stretch: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          expandedHeight: 260,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                            ],
                            background: Stack(
                              children: [
                                DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: <Color>[
                                        theme.background!,
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/nft-create-new.jpg',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 250,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    AppLocalization.of(context)!
                                        .nftTabDescriptionHeader,
                                    style: theme.textStyleSize12W400Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const NftCategoryMenu(),
                      ],
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

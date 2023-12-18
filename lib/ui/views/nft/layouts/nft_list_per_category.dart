/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTListPerCategory extends ConsumerWidget {
  const NFTListPerCategory({
    super.key,
    required this.currentNftCategoryIndex,
  });
  final int currentNftCategoryIndex;

  static const routerPage = '/nft_list_per_category';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (accountSelected == null) return const SizedBox();
    return Scaffold(
      drawerEdgeDragWidth: 0,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: <Widget>[
          AppButtonTinyConnectivity(
            localizations.createNFT,
            Dimens.buttonBottomDimens,
            key: const Key('createNFT'),
            icon: Symbols.diamond,
            onPressed: () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );

              ref
                  .read(
                    NftCreationFormProvider.nftCreationFormArgs.notifier,
                  )
                  .state = NftCreationFormNotifierParams(
                currentNftCategoryIndex: currentNftCategoryIndex,
              );
              context.go(
                NftCreationProcessSheet.routerPage,
              );
            },
            disabled: !accountSelected.balance!.isNativeTokenValuePositive(),
          ),
        ],
      ),
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.createNFT,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
          },
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: NFTList(
                currentNftCategoryIndex: currentNftCategoryIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

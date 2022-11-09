/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_header.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTListPerCategory extends ConsumerWidget {
  const NFTListPerCategory({super.key, this.currentNftCategoryIndex});
  final int? currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected = ref
        .read(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (accountSelected == null) return const SizedBox();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background2Small!,
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
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Column(
              children: <Widget>[
                NFTHeader(
                  currentNftCategoryIndex: currentNftCategoryIndex ?? 0,
                  displayCategoryName: true,
                ),
                Expanded(
                  child: NFTList(
                    currentNftCategoryIndex: currentNftCategoryIndex ?? 0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    if (accountSelected.balance!.isNativeTokenValuePositive())
                      AppButton(
                        AppButtonType.primary,
                        localizations.createNFT,
                        Dimens.buttonBottomDimens,
                        key: const Key('createNFT'),
                        onPressed: () async {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                preferences.activeVibrations,
                              );
                          Navigator.of(context).pushNamed(
                            '/nft_creation',
                            arguments: {
                              'seed': ref
                                  .read(SessionProviders.session)
                                  .loggedIn!
                                  .wallet
                                  .seed,
                              'currentNftCategoryIndex':
                                  currentNftCategoryIndex,
                            },
                          );
                        },
                      )
                    else
                      AppButton(
                        AppButtonType.primaryOutline,
                        localizations.createNFT,
                        Dimens.buttonBottomDimens,
                        key: const Key('createNFT'),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

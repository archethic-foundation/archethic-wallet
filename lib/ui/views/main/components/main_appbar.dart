/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/accounts/layouts/account_list.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/add_account_button.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Symbols.menu,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () {
          context.go(SettingsSheetWallet.routerPage);
        },
      ),
      actions: [
        if (preferences.mainScreenCurrentPage == 0 ||
            preferences.mainScreenCurrentPage == 1)
          IconButton(
            icon: Icon(
              preferences.showBalances
                  ? Symbols.visibility
                  : Symbols.visibility_off,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
            ),
            onPressed: () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              final preferencesNotifier =
                  ref.read(SettingsProviders.settings.notifier);
              await preferencesNotifier
                  .setShowBalances(!preferences.showBalances);
            },
          ),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: preferences.mainScreenCurrentPage == 0
          ? _accountTab(context, ref)
          : preferences.mainScreenCurrentPage == 1
              ? _transactionsTab(context, ref)
              : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: AutoSizeText(
                    localizations.aeSwapHeader,
                    style: ArchethicThemeStyles.textStyleSize24W700Primary,
                  ),
                ).animate().fade(duration: const Duration(milliseconds: 300)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }

  Widget _accountTab(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;
    final keychain = ref.watch(
      sessionNotifierProvider.select(
        (value) => value.loggedIn?.wallet.appKeychain,
      ),
    );
    final selectedAccount = ref
        .watch(
          AccountProviders.accounts,
        )
        .valueOrNull
        ?.selectedAccount;
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: InkWell(
        onTap: () {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );

          showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.black.withOpacity(0.1),
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.85,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: InkWell(
                              onTap: () {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );
                                Clipboard.setData(
                                  ClipboardData(
                                    text: keychain?.address.toUpperCase() ?? '',
                                  ),
                                );
                                UIUtil.showSnackbar(
                                  localizations.keychainAddressCopied,
                                  context,
                                  ref,
                                  ArchethicTheme.text,
                                  ArchethicTheme.snackBarShadow,
                                  icon: Symbols.info,
                                );
                              },
                              child: Text(
                                localizations.accountHeader,
                                style: ArchethicThemeStyles
                                    .textStyleSize16W600Primary,
                              ),
                            ),
                          ),
                          const AccountsList(),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 20,
                        ),
                        child: const Row(
                          children: [
                            AddAccountButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            Text(
              selectedAccount?.nameDisplayed ?? ' ',
              style: ArchethicThemeStyles.textStyleSize24W700Primary.copyWith(
                color: aedappfm.AppThemeBase.secondaryColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Symbols.keyboard_arrow_down,
              color: ArchethicThemeBase.neutral0,
            ),
          ],
        ),
      ),
    ).animate().fade(duration: const Duration(milliseconds: 300));
  }

  Widget _transactionsTab(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;
    final keychain = ref.watch(
      sessionNotifierProvider.select(
        (value) => value.loggedIn?.wallet.appKeychain,
      ),
    );

    return InkWell(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        Clipboard.setData(
          ClipboardData(
            text: keychain?.address.toUpperCase() ?? '',
          ),
        );
        UIUtil.showSnackbar(
          localizations.addressCopied,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
          icon: Symbols.info,
        );
      },
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: AutoSizeText(
          localizations.transactionHeader,
          style: ArchethicThemeStyles.textStyleSize24W700Primary,
        ),
      ).animate().fade(duration: const Duration(milliseconds: 300)),
    );
  }
}

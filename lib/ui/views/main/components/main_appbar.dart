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
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_refresh.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    if (preferences.mainScreenCurrentPage == 4) {
      return const _MainAppbarForWebView();
    }

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
      leading: const _MenuButton(),
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
              final preferencesNotifier =
                  ref.read(SettingsProviders.settings.notifier);
              await preferencesNotifier
                  .setShowBalances(!preferences.showBalances);
            },
          )
        else if (preferences.mainScreenCurrentPage == 2)
          const SwapTokenIconRefresh(),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: preferences.mainScreenCurrentPage == 0
          ? _accountTab(context, ref)
          : preferences.mainScreenCurrentPage == 1
              ? _transactionsTab(context, ref)
              : preferences.mainScreenCurrentPage == 2
                  ? FittedBox(
                      fit: BoxFit.fitWidth,
                      child: AutoSizeText(
                        localizations.swapHeader,
                        style: ArchethicThemeStyles.textStyleSize24W700Primary,
                      ),
                    )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 300))
                  : preferences.mainScreenCurrentPage == 3
                      ? FittedBox(
                          fit: BoxFit.fitWidth,
                          child: AutoSizeText(
                            localizations.aeSwapEarnHeader,
                            style:
                                ArchethicThemeStyles.textStyleSize24W700Primary,
                          ),
                        )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 300))
                      : const SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }

  Widget _accountTab(BuildContext context, WidgetRef ref) {
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
        onTap: () async {
          await showCupertinoModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 1,
                child: Scaffold(
                  backgroundColor:
                      aedappfm.AppThemeBase.sheetBackground.withOpacity(0.2),
                  body: Stack(
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
                                  Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          keychain?.address.toUpperCase() ?? '',
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
                                  localizations.accountsHeader,
                                  style: ArchethicThemeStyles
                                      .textStyleSize16W600Primary,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 5),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(Icons.info, size: 16),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${localizations.accountsListWarningRemoveAccount}',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                    TextSpan(
                                      text:
                                          ' (${localizations.accountsListWarningRemoveAccountConfirmRequired})',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary
                                          .copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
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
    final localizations = AppLocalizations.of(context)!;
    final keychain = ref.watch(
      sessionNotifierProvider.select(
        (value) => value.loggedIn?.wallet.appKeychain,
      ),
    );

    return InkWell(
      onTap: () {
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

/// AppBar containing only the menu button.
/// Useful for webview screens.
class _MainAppbarForWebView extends ConsumerWidget {
  const _MainAppbarForWebView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Align(
              child: Text(
                localizations.aeBridgeHeader,
                style: ArchethicThemeStyles.textStyleSize24W700Primary,
              ).animate().fade(duration: const Duration(milliseconds: 300)),
            ),
          ),
          const Positioned(
            left: 5,
            child: _MenuButton(),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends ConsumerWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
        icon: const Icon(
          Symbols.menu,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () {
          context.push(SettingsSheetWallet.routerPage);
        },
      );
}

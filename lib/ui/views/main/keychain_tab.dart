import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/views/accounts/layouts/account_list.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/add_account_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lit_starfield/view.dart';

class KeychainTab extends ConsumerWidget {
  const KeychainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);
    final accountsList =
        ref.watch(AccountProviders.sortedAccounts).valueOrNull ?? [];

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ArchethicTheme.backgroundSmall,
          ),
          fit: BoxFit.fitHeight,
          opacity: 0.7,
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: LitStarfieldContainer(
              velocity: 0.2,
              number: MediaQuery.of(context).size.width >= 580 ? 600 : 300,
              starColor: ArchethicThemeBase.neutral0,
              scale: 3,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Opacity(
            opacity: 0.3,
            child: LitStarfieldContainer(
              velocity: 0.2,
              number: MediaQuery.of(context).size.width >= 580 ? 300 : 100,
              scale: 6,
              starColor: ArchethicThemeBase.blue500,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          AccountsListWidget(
                            currencyName: settings.currency.name,
                            accountsList: accountsList,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
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
            ),
          ),
        ],
      ),
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirDrop extends ConsumerWidget {
  const AirDrop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (accountSelected == null) return const SizedBox();

    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/airdrop.png',
                fit: BoxFit.fill,
              ),
              Container(
                height: 30,
                color: Colors.black.withOpacity(0.3),
              )
            ],
          ),
          Positioned(
            right: 5,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                localizations.getUCOCount,
                style: theme.textStyleSize12W100Primary,
              ),
            ),
          ),

          // TODO(chralu): check Egibility
          if (true == false)
            Positioned(
              top: 40,
              left: 170,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: AppButtonTiny(
                  AppButtonTinyType.primary,
                  'get UCO',
                  Dimens.buttonBottomDimens,
                  key: const Key('getUCO'),
                  width: 150,
                  onPressed: () {
                    AppDialogs.showInfoDialog(
                      context,
                      ref,
                      localizations.informations,
                      localizations.getUCOInformation,
                    );
                  },
                ),
              ),
            )
          else
            Positioned(
              top: 40,
              left: 170,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: AppButtonTiny(
                      AppButtonTinyType.primaryOutline,
                      localizations.getUCOButton,
                      Dimens.buttonBottomDimens,
                      key: const Key('getUCO'),
                      width: 150,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          Positioned.fill(
            top: 115,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: localizations.getUCODescription1,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                    ),
                    TextSpan(
                      text: 'UCO',
                      style: theme.textStyleSize24W700EquinoxPrimary,
                    ),
                    TextSpan(
                      text: 's',
                      style: theme.textStyleSize14W600EquinoxPrimary,
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

import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroNewWalletAccountConfirmationPopup extends ConsumerWidget {
  const IntroNewWalletAccountConfirmationPopup(this.name, {super.key});

  final String name;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;

    return aedappfm.PopupTemplate(
      popupContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: localizations.newAccountConfirmationDesc1,
                          style:
                              Theme.of(context).textTheme.bodySmallWithOpacity,
                        ),
                        TextSpan(
                          text: name,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmallWithOpacity
                              .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        TextSpan(
                          text: localizations.newAccountConfirmationDesc2,
                          style:
                              Theme.of(context).textTheme.bodySmallWithOpacity,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BtnPrimary(
                    buttonText: localizations.cancel,
                    onTap: () {
                      context.pop();
                    },
                    btnPrimaryType: BtnPrimaryType.outlinePrimary,
                  ),
                  BtnPrimary(
                    buttonText: localizations.confirm,
                    onTap: () {
                      context.go(
                        IntroNewWalletDisclaimer.routerPage,
                        extra: name,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      popupTitle: localizations.newAccount,
      displayCloseButton: false,
    );
  }
}

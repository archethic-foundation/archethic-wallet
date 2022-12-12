/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/faucet/provider.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/functional_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'faucet.g.dart';

/// True if the Faucet claim button should be active
@Riverpod(keepAlive: true)
bool _isFaucetRequestButtonActive(Ref ref) {
  final isFaucetEnabled = ref.watch(FaucetProviders.isFaucetEnabled).maybeWhen(
        data: id,
        orElse: () => false,
      );

  final isFaucetClaimRequestRunning =
      ref.watch(FaucetProviders.claimRequest).isLoading;

  return isFaucetEnabled && !isFaucetClaimRequestRunning;
}

class FaucetBanner extends ConsumerWidget {
  const FaucetBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (accountSelected == null) return const SizedBox();

    final theme = ref.watch(ThemeProviders.selectedTheme);

    final isFaucetRequestButtonActive = ref.watch(
      _isFaucetRequestButtonActiveProvider,
    );

    final isFaucetClaimRequestRunning =
        ref.watch(FaucetProviders.claimRequest).isLoading;

    final localizations = AppLocalization.of(context)!;
    ref.listen(
      FaucetProviders.claimRequest,
      (previous, next) {
        final error = next.error as Failure?;
        if (next.isLoading) {
          return;
        }

        if (error == null) {
          AppDialogs.showInfoDialog(
            context,
            ref,
            localizations.informations,
            localizations.getUCOInformation,
          );
          return;
        }

        UIUtil.showSnackbar(
          error.maybeMap(
            quotaExceeded: (value) =>
                localizations.getUCOInformationAlreadyReceived,
            insufficientFunds: (value) =>
                localizations.getUCOInformationInsufficientBalance,
            orElse: () => localizations.getUCOInformationBackendError,
          ),
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
      },
    );

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
          const Positioned(
            right: 5,
            child: Align(
              alignment: Alignment.topRight,
              child: _CooldownCounter(),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: AppButtonTinyWithoutExpanded(
                isFaucetRequestButtonActive
                    ? AppButtonTinyType.primary
                    : AppButtonTinyType.primaryOutline,
                localizations.getUCOButton,
                const <double>[14, 8, 14, 0],
                disabled: !isFaucetRequestButtonActive,
                showProgressIndicator: isFaucetClaimRequestRunning,
                key: const Key('getUCO'),
                width: 170,
                onPressed: isFaucetRequestButtonActive
                    ? () {
                        ref.read(FaucetProviders.claimRequest.notifier).claim();
                      }
                    : () {},
              ),
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

class _CooldownCounter extends ConsumerWidget {
  const _CooldownCounter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final cooldownRemainingTime =
        ref.watch(FaucetProviders.claimCooldown).valueOrNull;

    if (cooldownRemainingTime == null ||
        cooldownRemainingTime == Duration.zero) {
      return const SizedBox();
    }
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Text(
      localizations.getUCOCount
          .replaceAll(
            '%1',
            cooldownRemainingTime.inHours.toString().padLeft(2, '0'),
          )
          .replaceAll(
            '%2',
            ((cooldownRemainingTime.inMinutes % 60) + 1)
                .toString()
                .padLeft(2, '0'),
          ),
      style: theme.textStyleSize12W100Primary,
    );
  }
}

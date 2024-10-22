/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/application/verified_tokens.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifiedTokenIcon extends ConsumerWidget {
  const VerifiedTokenIcon({
    required this.address,
    this.iconSize = 14,
    super.key,
  });

  final String address;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (address.isUCO) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Tooltip(
          message: AppLocalizations.of(context)!.verifiedTokenIconTooltip,
          child: Icon(
            aedappfm.Iconsax.verify,
            color: aedappfm.ArchethicThemeBase.systemPositive500,
            size: iconSize,
          ),
        ),
      );
    }

    final isVerifiedToken = ref
        .watch(
          isVerifiedTokenProvider(
            address,
          ),
        )
        .valueOrNull;

    if (isVerifiedToken == null) return const CircularProgressIndicator();
    if (isVerifiedToken == false) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Tooltip(
        message: AppLocalizations.of(context)!.verifiedTokenIconTooltip,
        child: Icon(
          aedappfm.Iconsax.verify,
          color: aedappfm.ArchethicThemeBase.systemPositive500,
          size: iconSize,
        ),
      ),
    );
  }
}

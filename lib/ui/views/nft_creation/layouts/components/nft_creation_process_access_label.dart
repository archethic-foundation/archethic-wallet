/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessAccessLabel extends ConsumerWidget {
  const NFTCreationProcessAccessLabel({
    required this.publicKeysLength,
    this.isProperty = true,
    super.key,
  });

  final int publicKeysLength;
  final bool isProperty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    late final String label;
    if (isProperty) {
      switch (publicKeysLength) {
        case 0:
          label = localizations.nftPropertyNotProtected;
          break;
        case 1:
          label = localizations.nftPropertyProtected1PublicKey;
          break;
        default:
          label = localizations.nftPropertyProtectedPublicKeys.replaceAll(
            '%1',
            publicKeysLength.toString(),
          );
          break;
      }
    } else {
      switch (publicKeysLength) {
        case 0:
          label = localizations.nftAssetNotProtected;
          break;
        case 1:
          label = localizations.nftAssetProtected1PublicKey;
          break;
        default:
          label = localizations.nftAssetProtectedPublicKeys.replaceAll(
            '%1',
            publicKeysLength.toString(),
          );
          break;
      }
    }
    return Container(
      width: MediaQuery.of(context).size.width - 180,
      padding: const EdgeInsets.only(left: 20),
      child: AutoSizeText(
        label,
        style: theme.textStyleSize12W400Primary,
      ),
    );
  }
}

import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final localizations = AppLocalizations.of(context)!;

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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AutoSizeText(
            label,
            style: ArchethicThemeStyles.textStyleSize12W400Primary,
          ),
        ),
      ],
    );
  }
}

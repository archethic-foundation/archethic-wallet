import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountListItemTokenInfo extends ConsumerWidget {
  const AccountListItemTokenInfo({
    super.key,
    required this.account,
  });
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (account.balance != null && account.balance!.tokensFungiblesNb > 0)
          AutoSizeText(
            account.balance!.tokensFungiblesNb > 1
                ? '${account.balance!.tokensFungiblesNb} ${localizations.tokens}'
                : '${account.balance!.tokensFungiblesNb} ${localizations.token}',
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
            textAlign: TextAlign.end,
          )
        else
          AutoSizeText(
            localizations.noToken,
            style: ArchethicThemeStyles.textStyleSize12W100Primary60,
            textAlign: TextAlign.end,
          ),
        if (account.balance != null && account.balance!.nftNb > 0)
          AutoSizeText(
            '${account.balance!.nftNb} ${localizations.nft}',
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
            textAlign: TextAlign.end,
          )
        else
          AutoSizeText(
            localizations.noNFT,
            style: ArchethicThemeStyles.textStyleSize12W100Primary60,
            textAlign: TextAlign.end,
          ),
      ],
    );
  }
}

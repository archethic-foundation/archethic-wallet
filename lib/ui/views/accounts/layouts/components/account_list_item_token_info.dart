import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountListItemTokenInfo extends ConsumerWidget {
  const AccountListItemTokenInfo({
    super.key,
    required this.account,
  });
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (account.balance != null && account.balance!.tokensFungiblesNb > 0)
          AutoSizeText(
            account.balance!.tokensFungiblesNb > 1
                ? '${account.balance!.tokensFungiblesNb} ${localizations.tokens}'
                : '${account.balance!.tokensFungiblesNb} ${localizations.token}',
            style: theme.textStyleSize12W400Primary,
            textAlign: TextAlign.end,
          )
        else
          AutoSizeText(
            localizations.noToken,
            style: theme.textStyleSize12W400Primary45,
            textAlign: TextAlign.end,
          ),
        if (account.balance != null && account.balance!.nftNb > 0)
          AutoSizeText(
            '${account.balance!.nftNb} ${localizations.nft}',
            style: theme.textStyleSize12W400Primary,
            textAlign: TextAlign.end,
          )
        else
          AutoSizeText(
            localizations.noNFT,
            style: theme.textStyleSize12W400Primary45,
            textAlign: TextAlign.end,
          ),
      ],
    );
  }
}

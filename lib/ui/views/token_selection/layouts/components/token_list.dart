import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/token_selection/bloc/provider.dart';
import 'package:aewallet/ui/views/token_selection/layouts/components/token_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenList extends ConsumerWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenSelectionForm =
        ref.watch(TokenSelectionFormProvider.tokenSelectionForm);

    if (tokenSelectionForm.isAddress == false) {
      final tokens = ref.watch(
        DexTokensProviders.tokensFromAccount,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              AppLocalizations.of(context)!.token_selection_your_tokens_title,
              style: AppTextStyles.bodyLarge(context),
            ),
          ),
          SizedBox(
            child: tokens.map(
              data: (data) {
                return _TokensList(tokens: data.value);
              },
              error: (error) => const SizedBox(
                height: 200,
              ),
              loading: (loading) => Stack(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!
                                .token_selection_get_tokens_from_wallet,
                            style: AppTextStyles.bodyMedium(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return _TokensList(tokens: tokenSelectionForm.result!);
  }
}

class _TokensList extends ConsumerWidget {
  const _TokensList({required this.tokens});

  final List<DexToken> tokens;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenSelectionForm =
        ref.watch(TokenSelectionFormProvider.tokenSelectionForm);
    final tokensFiltered = [...tokens];
    if (tokenSelectionForm.searchText.isNotEmpty &&
        tokenSelectionForm.isAddress == false) {
      tokensFiltered.removeWhere(
        (element) =>
            element.symbol
                .toUpperCase()
                .contains(tokenSelectionForm.searchText.toUpperCase()) ==
            false,
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: tokensFiltered.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleToken(token: tokensFiltered[index]);
        },
      ),
    );
  }
}

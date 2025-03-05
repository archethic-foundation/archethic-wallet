import 'package:aewallet/ui/views/buy/bloc/buy_with_crypto_form_provider.dart';
import 'package:aewallet/ui/views/buy/layouts/components/dropdown.dart';
import 'package:aewallet/ui/views/buy/layouts/components/token_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TokenDropdown extends ConsumerWidget {
  const TokenDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(buyWithCryptoFormProvider).valueOrNull;

    return Dropdown(
      onTap: () async {
        final selectedToken = await CupertinoScaffold
            .showCupertinoModalBottomSheet<OnRampTokenDisplayData>(
          context: context,
          builder: (context) => TokenSelectionSheet(
            onSelect: (token) => context.pop(token),
          ),
        );

        if (selectedToken == null) return;

        await ref
            .read(buyWithCryptoFormProvider.notifier)
            .selectToken(selectedToken);
      },
      badge: _TokenBadge(token: form?.selectedToken),
    );
  }
}

class _TokenBadge extends ConsumerWidget {
  const _TokenBadge({
    super.key,
    this.token,
  });

  final OnRampTokenDisplayData? token;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return DropdownBadge(
      content: Row(
        children: [
          if (token != null) ...[
            Image.network(
              token!.iconUrl,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(token!.desc),
          ] else
            Text(localizations.btn_selectToken),
        ],
      ),
    );
  }
}

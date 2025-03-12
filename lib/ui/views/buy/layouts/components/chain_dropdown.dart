import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/ui/views/buy/bloc/buy_with_crypto_form_provider.dart';
import 'package:aewallet/ui/views/buy/layouts/components/chain_selection_sheet.dart';
import 'package:aewallet/ui/views/buy/layouts/components/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChainDropdown extends ConsumerWidget {
  const ChainDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(buyWithCryptoFormProvider).valueOrNull;
    final selectedToken = ref.watch(
      buyWithCryptoFormProvider
          .select((form) => form.valueOrNull?.selectedToken),
    );

    return Dropdown(
      onTap: selectedToken == null
          ? null
          : () async {
              final selectedChain = await CupertinoScaffold
                  .showCupertinoModalBottomSheet<OnRampChain>(
                context: context,
                builder: (context) => ChainSelectionSheet(
                  selectedToken: selectedToken,
                  onSelect: (token) => context.pop(token),
                ),
              );

              if (selectedChain == null) return;

              await ref
                  .read(buyWithCryptoFormProvider.notifier)
                  .selectChain(selectedChain);
            },
      badge: _ChainBadge(chain: form?.selectedChain),
    );
  }
}

class _ChainBadge extends ConsumerWidget {
  const _ChainBadge({
    this.chain,
  });

  final OnRampChain? chain;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return DropdownBadge(
      content: Row(
        children: [
          if (chain != null) ...[
            SvgPicture.string(
              chain!.svgIcon,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(
              chain!.displayName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ] else
            Text(
              localizations.btn_selectChain,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}

import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/buy/bloc/buy_with_crypto_form_provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:material_symbols_icons/symbols.dart';

class TokenSelectionSheet extends ConsumerWidget {
  const TokenSelectionSheet({
    super.key,
    required this.onSelect,
  });

  final void Function(OnRampTokenDisplayData? token) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final tokens = ref.watch(onrampTokenDisplayDataProvider).valueOrNull;

    if (tokens == null) return const SizedBox();

    return Stack(
      children: [
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () async {
              context.pop();
            },
            icon: const Icon(
              Symbols.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  localizations.onrampWithCryptoSelectTokenTitle,
                  style: AppTextStyles.bodyLarge(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 10,
                children: tokens.map((token) {
                  return _TokenSelector(
                    key: ValueKey(token),
                    token: token,
                    onTap: () {
                      onSelect(token);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TokenSelector extends StatelessWidget {
  const _TokenSelector({
    super.key,
    required this.token,
    required this.onTap,
  });

  final OnRampTokenDisplayData token;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            aedappfm.AppThemeBase.sheetBackgroundTertiary
                .withValues(alpha: 0.4),
            aedappfm.AppThemeBase.sheetBackgroundTertiary,
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              aedappfm.AppThemeBase.sheetBorderTertiary.withValues(alpha: 0.4),
              aedappfm.AppThemeBase.sheetBorderTertiary,
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            if (token.svgIcon != '')
              SvgPicture.string(
                token.svgIcon,
                width: 20,
              )
            else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    token.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

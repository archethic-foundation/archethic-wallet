import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_category_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTListDetailPopup {
  static Future getPopup(
    BuildContext context,
    WidgetRef ref,
    LongPressEndDetails details,
    String address,
    String tokenId,
  ) async {
    final theme = ref.read(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    return showMenu(
      color: theme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
        side: BorderSide(
          color: theme.text60!,
        ),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        _popupMenuItem(
          context,
          ref,
          label: localizations.nftCategoryChangeCategory,
          value: 'moveCategory',
          icon: Symbols.drive_file_move,
          address: address,
          tokenId: tokenId,
        ),
      ],
    );
  }

  static PopupMenuItem _popupMenuItem(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required IconData icon,
    required String value,
    required String address,
    required String tokenId,
  }) {
    final theme = ref.read(ThemeProviders.selectedTheme);

    final preferences = ref.read(SettingsProviders.settings);
    return PopupMenuItem(
      value: value,
      onTap: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        final nftCategoryChoosen =
            await NftCategoryDialog.getDialog(context, ref, tokenId);
        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        await selectedAccount?.updateNftInfosOffChain(
          tokenAddress: address,
          categoryNftIndex: nftCategoryChoosen!.id,
        );

        ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();
        ref.invalidate(AccountProviders.getAccountNFTFiltered);
        UIUtil.showSnackbar(
          AppLocalizations.of(context)!.nftCategoryChangeCategoryOk,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 3),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.text,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                label,
                style: theme.textStyleSize12W100Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

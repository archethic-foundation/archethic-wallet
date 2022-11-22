import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_category_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTListDetailPopup {
  static Future getPopup(
    BuildContext context,
    WidgetRef ref,
    LongPressEndDetails details,
    TokenInformations tokenInformations,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

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
          icon: Icons.drive_file_move_outlined,
          tokenInformations: tokenInformations,
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
    required TokenInformations tokenInformations,
  }) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final preferences = ref.watch(SettingsProviders.settings);
    return PopupMenuItem(
      value: value,
      onTap: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        final nftCategoryChoosen =
            await NftCategoryDialog.getDialog(context, ref, tokenInformations);
        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        await selectedAccount?.updateNftInfosOffChain(
          tokenAddress: tokenInformations.address,
          categoryNftIndex: nftCategoryChoosen!.id,
        );

        ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();
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

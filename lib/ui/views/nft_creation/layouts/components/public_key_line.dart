import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/property_access_recipient_formatters.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/item_remove_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublicKeyLine extends ConsumerWidget {
  const PublicKeyLine({
    super.key,
    required this.propertyName,
    required this.propertyAccessRecipient,
    required this.readOnly,
  });

  final String propertyName;
  final PropertyAccessRecipient propertyAccessRecipient;
  final bool readOnly;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ArchethicTheme.backgroundAccountsListCardSelected,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: ArchethicTheme.backgroundAccountsListCardSelected,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        color: ArchethicTheme.backgroundAccountsListCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                propertyAccessRecipient.format(localizations),
                style: ArchethicThemeStyles.textStyleSize12W600Primary,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (readOnly == false)
              ItemRemoveButton(
                onPressed: () {
                  AppDialogs.showConfirmDialog(
                      context,
                      ref,
                      localizations.removePublicKey,
                      localizations.areYouSure,
                      localizations.deleteOption, () {
                    ref
                        .read(
                          NftCreationFormProvider.nftCreationForm.notifier,
                        )
                        .removeAddress(
                          propertyName,
                          propertyAccessRecipient.address!.address!,
                        );
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/property_access_recipient_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/item_remove_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalization.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.backgroundAccountsListCardSelected!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: theme.backgroundAccountsListCardSelected,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        color: theme.backgroundAccountsListCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                propertyAccessRecipient.format(localizations),
                style: theme.textStyleSize12W600Primary,
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
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    ref
                        .watch(
                          NftCreationFormProvider.nftCreationForm(
                            ref.read(
                              NftCreationFormProvider.nftCreationFormArgs,
                            ),
                          ).notifier,
                        )
                        .removePublicKey(
                          propertyName,
                          propertyAccessRecipient.publicKey!.publicKey,
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

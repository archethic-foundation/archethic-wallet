/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/properties_access/nft_creation_process_access_label.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/properties_access/nft_creation_process_file_access_add_button.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/item_remove_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTCreationProcessPropertyAccess extends ConsumerWidget {
  const NFTCreationProcessPropertyAccess({
    required this.propertyName,
    required this.propertyValue,
    this.readOnly = false,
    this.propertiesHidden,
    super.key,
  });

  final String propertyName;
  final dynamic propertyValue;
  final bool readOnly;
  final List<String>? propertiesHidden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (propertiesHidden != null && propertiesHidden!.contains(propertyName)) {
      return const SizedBox();
    }

    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreationArgs = ref.watch(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        nftCreationArgs,
      ).notifier,
    );
    final fileProperty = nftCreation.properties
        .where((element) => element.propertyName == propertyName)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: fileProperty[0].publicKeys.isNotEmpty
              ? const BorderSide(
                  color: Colors.redAccent,
                  width: 2,
                )
              : BorderSide(
                  color: theme.backgroundAccountsListCardSelected!,
                ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: theme.backgroundAccountsListCardSelected,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 5,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: AutoSizeText(
                          propertyName,
                          style: theme.textStyleSize12W600Primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: AutoSizeText(
                          propertyValue,
                          style: theme.textStyleSize12W400Primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (readOnly == false ||
                          fileProperty[0].publicKeys.isNotEmpty)
                        NFTCreationProcessFileAccessAddButton(
                          propertyName: propertyName,
                          propertyValue: propertyValue,
                          readOnly: readOnly,
                        ),
                      ItemRemoveButton(
                        onPressed: () {
                          AppDialogs.showConfirmDialog(
                              context,
                              ref,
                              localizations.deleteProperty,
                              localizations.areYouSure,
                              AppLocalizations.of(context)!.deleteOption, () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            nftCreationNotifier.removeProperty(
                              propertyName,
                            );
                          });
                        },
                        readOnly: readOnly,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: NFTCreationProcessAccessLabel(
                    publicKeysLength: fileProperty[0].publicKeys.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

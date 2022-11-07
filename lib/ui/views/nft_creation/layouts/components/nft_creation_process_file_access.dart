/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_access_label.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_access_add_button.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_access_remove_button.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTCreationProcessFileAccess extends ConsumerWidget {
  const NFTCreationProcessFileAccess({
    this.readOnly = false,
    super.key,
  });

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    if (nftCreation.file == null) {
      return const SizedBox();
    }
    final nftCreationNotifier = ref.read(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalization.of(context)!;

    final fileProperty = nftCreation.properties
        .where((element) => element.propertyName == 'file')
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NFTCreationProcessAccessLabel(
                    publicKeysLength: fileProperty[0].publicKeys.length,
                    isProperty: false,
                  ),
                ],
              ),
              Row(
                children: [
                  NFTCreationProcessFileAccessAddButton(
                    propertyName: 'file',
                    propertyValue: '',
                    readOnly: readOnly,
                  ),
                  NFTCreationProcessFileAccessRemoveButton(
                    onPressed: () {
                      AppDialogs.showConfirmDialog(
                          context,
                          ref,
                          localizations.deleteFile,
                          localizations.areYouSure,
                          localizations.deleteOption, () {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        nftCreationNotifier.removeFileProperties();
                      });
                    },
                    readOnly: readOnly,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

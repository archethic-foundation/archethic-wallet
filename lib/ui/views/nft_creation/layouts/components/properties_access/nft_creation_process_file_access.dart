import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/properties_access/nft_creation_process_access_label.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/properties_access/nft_creation_process_file_access_add_button.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/item_remove_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFileAccess extends ConsumerWidget {
  const NFTCreationProcessFileAccess({
    this.readOnly = false,
    super.key,
  });

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    if (nftCreation.file == null) {
      return const SizedBox();
    }
    final nftCreationNotifier = ref.read(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    final localizations = AppLocalizations.of(context)!;

    final fileProperty = nftCreation.properties
        .where((element) => element.propertyName == 'raw')
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          side: fileProperty[0].addresses.isNotEmpty
              ? const BorderSide(
                  color: Colors.redAccent,
                  width: 2,
                )
              : BorderSide(
                  color: ArchethicTheme.backgroundAccountsListCardSelected,
                ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: ArchethicTheme.backgroundAccountsListCardSelected,
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
                    publicKeysLength: fileProperty[0].addresses.length,
                    isProperty: false,
                  ),
                ],
              ),
              Row(
                children: [
                  if (readOnly == false || fileProperty[0].addresses.isNotEmpty)
                    NFTCreationProcessFileAccessAddButton(
                      propertyName: 'content',
                      propertyValue: '',
                      readOnly: readOnly,
                    ),
                  ItemRemoveButton(
                    onPressed: () {
                      AppDialogs.showConfirmDialog(
                        context,
                        ref,
                        localizations.deleteFile,
                        localizations.areYouSure,
                        localizations.deleteOption,
                        nftCreationNotifier.removeContentProperties,
                      );
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

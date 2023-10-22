import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContactPublicKeyRecovered extends ConsumerWidget {
  const AddContactPublicKeyRecovered({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactCreation =
        ref.watch(ContactCreationFormProvider.contactCreationForm);

    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.contactPublicKeyGetAuto,
            textAlign: TextAlign.left,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
          ),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            contactCreation.publicKeyRecovered.toUpperCase(),
            textAlign: TextAlign.left,
            style: ArchethicThemeStyles.textStyleSize14W100Primary,
          ),
        ],
      ),
    );
  }
}

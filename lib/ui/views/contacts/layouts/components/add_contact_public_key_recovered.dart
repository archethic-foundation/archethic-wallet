/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContactPublicKeyRecovered extends ConsumerWidget {
  const AddContactPublicKeyRecovered({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactCreation =
        ref.watch(ContactCreationFormProvider.contactCreationForm);

    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

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
            style: theme.textStyleSize12W100Primary,
          ),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            contactCreation.publicKeyRecovered.toUpperCase(),
            textAlign: TextAlign.left,
            style: theme.textStyleSize14W100Primary,
          ),
        ],
      ),
    );
  }
}

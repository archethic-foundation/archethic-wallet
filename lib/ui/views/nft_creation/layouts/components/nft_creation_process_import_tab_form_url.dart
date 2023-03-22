/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabFormUrl extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTabFormUrl({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessImportTabFormUrl> createState() =>
      _NFTCreationProcessImportTabFormUrlState();
}

class _NFTCreationProcessImportTabFormUrlState
    extends ConsumerState<NFTCreationProcessImportTabFormUrl> {
  late TextEditingController urlController;
  late FocusNode urlFocusNode;

  @override
  void initState() {
    super.initState();
    urlFocusNode = FocusNode();
    urlController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    urlFocusNode.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);

    return AppTextField(
      focusNode: urlFocusNode,
      controller: urlController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: localizations.introNewWalletGetFirstInfosNameBlank,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(
          20,
        ),
        UpperCaseTextFormatter(),
      ],
      onChanged: (text) async {
        addAccountNotifier.setName(
          text,
        );
      },
    );
  }
}

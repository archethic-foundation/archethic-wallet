/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabTemplateForm extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTabTemplateForm({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.placeholder,
    required this.buttonLabel,
  });

  final void Function(String uri, BuildContext context) onConfirm;
  final String title;
  final String placeholder;
  final String buttonLabel;

  @override
  ConsumerState<NFTCreationProcessImportTabTemplateForm> createState() =>
      _NFTCreationProcessImportTabFormUrlState();
}

class _NFTCreationProcessImportTabFormUrlState
    extends ConsumerState<NFTCreationProcessImportTabTemplateForm> {
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
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: widget.title,
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: <Widget>[
                      AppTextField(
                        focusNode: urlFocusNode,
                        controller: urlController,
                        cursorColor: theme.text,
                        textInputAction: TextInputAction.next,
                        labelText: widget.placeholder,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        style: theme.textStyleSize16W600Primary,
                        suffixButton: PasteIcon(
                          onPaste: (String value) {
                            urlController.text = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (connectivityStatusProvider ==
                        ConnectivityStatus.isConnected)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        widget.buttonLabel,
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        Dimens.buttonBottomDimens,
                        key: const Key('addAccount'),
                        onPressed: () {
                          widget.onConfirm(urlController.text, context);
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        widget.buttonLabel,
                        Dimens.buttonBottomDimens,
                        key: const Key('addAccount'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

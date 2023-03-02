/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/url/provider.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabIPFSForm extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTabIPFSForm(
      {super.key, required this.onConfirm});

  final void Function(String uri) onConfirm;

  @override
  ConsumerState<NFTCreationProcessImportTabIPFSForm> createState() =>
      _NFTCreationProcessImportTabFormUrlState();
}

class _NFTCreationProcessImportTabFormUrlState
    extends ConsumerState<NFTCreationProcessImportTabIPFSForm> {
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
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.addAccount,
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
                        labelText:
                            localizations.introNewWalletGetFirstInfosNameBlank,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        style: theme.textStyleSize16W600Primary,
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
                        localizations.addAccount,
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        Dimens.buttonBottomDimens,
                        key: const Key('addAccount'),
                        onPressed: () {
                          void setError(String errorText) {
                            UIUtil.showSnackbar(
                              errorText,
                              context,
                              ref,
                              theme.text!,
                              theme.snackBarShadow!,
                            );
                          }

                          if (urlController.text.isEmpty) {
                            setError(localizations.enterEndpointBlank);
                            return;
                          }

                          final uriInput = ref.watch(
                            UrlProvider.cleanUri(
                              uri: urlController.text,
                            ),
                          );

                          if (!ref.watch(
                            UrlProvider.isUrlValid(
                              uri: uriInput,
                            ),
                          )) {
                            setError(localizations.enterEndpointNotValid);
                            return;
                          }

                          if (!ref.watch(
                            UrlProvider.isUrlIPFS(
                              uri: uriInput,
                            ),
                          )) {
                            setError(localizations.enterEndpointNotValid);
                            return;
                          }

                          widget.onConfirm(uriInput.toString());
                          Navigator.of(context).pop();
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.addAccount,
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

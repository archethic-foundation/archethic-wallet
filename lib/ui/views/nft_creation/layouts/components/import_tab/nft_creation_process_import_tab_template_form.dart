/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTCreationProcessImportTabTemplateForm extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTabTemplateForm({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.placeholder,
    required this.warningLabel,
    this.disclaimer = '',
  });

  final void Function(String uri, BuildContext context) onConfirm;
  final String title;
  final String placeholder;
  final String warningLabel;
  final String disclaimer;

  @override
  ConsumerState<NFTCreationProcessImportTabTemplateForm> createState() =>
      _NFTCreationProcessImportTabFormUrlState();
}

class _NFTCreationProcessImportTabFormUrlState
    extends ConsumerState<NFTCreationProcessImportTabTemplateForm>
    implements SheetSkeletonInterface {
  late TextEditingController urlController;
  late FocusNode urlFocusNode;

  @override
  void initState() {
    super.initState();
    urlFocusNode = FocusNode();
    urlController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    urlFocusNode.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return connectivityStatusProvider == ConnectivityStatus.isConnected
        ? AppButtonTiny(
            AppButtonTinyType.primary,
            localizations.confirm,
            Dimens.buttonBottomDimens,
            key: const Key('confirm'),
            onPressed: () {
              widget.onConfirm(urlController.text, context);
            },
          )
        : AppButtonTiny(
            AppButtonTinyType.primaryOutline,
            localizations.confirm,
            Dimens.buttonBottomDimens,
            key: const Key('confirm'),
            onPressed: () {},
          );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: widget.title,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Text(
          widget.warningLabel,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        AppTextField(
          focusNode: urlFocusNode,
          controller: urlController,
          cursorColor: ArchethicTheme.text,
          textInputAction: TextInputAction.next,
          labelText: widget.placeholder,
          autocorrect: false,
          maxLines: 10,
          keyboardType: TextInputType.text,
          style: ArchethicThemeStyles.textStyleSize14W200Primary,
          suffixButton: PasteIcon(
            onPaste: (String value) {
              urlController.text = value;
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        if (widget.disclaimer.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 10,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    Symbols.warning,
                    color: ArchethicTheme.warning,
                    size: 12,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.disclaimer,
                    style:
                        ArchethicThemeStyles.textStyleSize12W100PrimaryWarning,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

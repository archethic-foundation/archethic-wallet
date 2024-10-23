/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogsDialog {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
    String logs,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.logsDialogTitle,
          popupHeight: 500,
          popupContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.logsDesc,
                style: AppTextStyles.bodyMediumSecondaryColor(context),
              ),
              const SizedBox(
                height: 20,
              ),
              SelectableText(
                '${AppLocalizations.of(context)!.logsDialogTitle}:',
                style: AppTextStyles.bodyMediumSecondaryColor(context),
              ),
              Expanded(
                child: Container(
                  width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: aedappfm.ArchethicScrollbar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SelectableText(
                          logs,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LocalHistoryLogCopyBtn(
                content: logs,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LocalHistoryLogCopyBtn extends StatelessWidget {
  const LocalHistoryLogCopyBtn({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return aedappfm.AppButton(
      labelBtn: AppLocalizations.of(context)!.copy,
      onPressed: () {
        Clipboard.setData(
          ClipboardData(text: content),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: SelectableText(
              AppLocalizations.of(context)!.logsCopied,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.labelMedium!,
                    ),
                  ),
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.ok,
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}

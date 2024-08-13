import 'dart:ui';

import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_payload/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignPayloadConfirmationForm extends ConsumerWidget
    implements SheetSkeletonInterface {
  const SignPayloadConfirmationForm(
    this.command,
    this.description, {
    super.key,
  });

  final RPCCommand<awc.SignPayloadRequest> command;
  final Map<String, dynamic> description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: <Widget>[
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.cancel,
          Dimens.buttonBottomDimens,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.confirm,
          Dimens.buttonBottomDimens,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.transactionConfirmationFormHeader,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final locale = ref.read(LanguageProviders.selectedLocale);
    final descriptionLocale =
        description[locale.languageCode] ?? description['en'] ?? '';
    final localizations = AppLocalizations.of(context)!;
    final formState = ref.watch(
      SignPayloadsConfirmationProviders.form(command),
    );

    return formState.map(
      error: (error) => const SizedBox(),
      loading: (loading) => const SizedBox(),
      data: (formData) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: command.data.payloads.length == 1
                            ? localizations
                                .sign1PayloadCommandReceivedNotification
                                .replaceAll(
                                  '%1',
                                  formData
                                      .value.signTransactionCommand.origin.name,
                                )
                                .replaceAll(
                                  '%2',
                                  _getShortName(
                                    formData.value.signTransactionCommand.data
                                        .serviceName,
                                  ),
                                )
                            : localizations
                                .signXPayloadsCommandReceivedNotification
                                .replaceAll(
                                  '%1',
                                  formData
                                      .value.signTransactionCommand.origin.name,
                                )
                                .replaceAll(
                                  '%2',
                                  command.data.payloads.length.toString(),
                                )
                                .replaceAll(
                                  '%3',
                                  _getShortName(
                                    formData.value.signTransactionCommand.data
                                        .serviceName,
                                  ),
                                ),
                        style: ArchethicThemeStyles.textStyleSize14W200Primary,
                      ),
                    ],
                  ),
                ),
                if (descriptionLocale.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        descriptionLocale,
                        style: ArchethicThemeStyles.textStyleSize14W200Primary,
                      ),
                    ),
                  ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: command.data.payloads.length,
                  itemBuilder: (context, index) {
                    final rpcSignPayloadCommandData =
                        command.data.payloads[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${localizations.payload} #$index:',
                                style: ArchethicThemeStyles
                                    .textStyleSize14W600Primary,
                              ),
                              if (rpcSignPayloadCommandData.isHexa)
                                Text(
                                  ' (${localizations.hexadecimalFormat})',
                                  style: ArchethicThemeStyles
                                      .textStyleSize12W100Primary,
                                ),
                            ],
                          ),
                          SelectableText(
                            rpcSignPayloadCommandData.payload,
                            style:
                                ArchethicThemeStyles.textStyleSize14W200Primary,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getShortName(String name) {
    var result = name;
    if (name.startsWith('archethic-wallet-')) {
      result = result.replaceFirst('archethic-wallet-', '');
    }
    if (name.startsWith('aeweb-')) {
      result = result.replaceFirst('aeweb-', '');
    }

    return Uri.decodeFull(
      result,
    );
  }
}

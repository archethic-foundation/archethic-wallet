import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/bloc/provider.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/layouts/transaction_raw.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignTransactionsConfirmationForm extends ConsumerWidget
    implements SheetSkeletonInterface {
  const SignTransactionsConfirmationForm(
    this.addresses,
    this.command,
    this.estimatedFees, {
    super.key,
  });

  final RPCCommand<RPCSignTransactionsCommandData> command;
  final double estimatedFees;
  final List<String?> addresses;

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
    final localizations = AppLocalizations.of(context)!;
    final formState = ref.watch(
      SignTransactionsConfirmationProviders.form(command),
    );
    final language = ref.watch(
      LanguageProviders.selectedLanguage,
    );

    return formState.map(
      error: (error) =>
          const SizedBox(), // TODO(reddwarf): should we display an error/loading screen ?
      loading: (loading) => const SizedBox(),
      data: (formData) {
        return Column(
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: command.data.rpcSignTransactionCommandData.length == 1
                        ? localizations
                            .sign1TransactionCommandReceivedNotification
                            .replaceAll(
                              '%1',
                              formData.value.signTransactionCommand.origin.name,
                            )
                            .replaceAll(
                              '%2',
                              _getShortName(
                                formData.value.signTransactionCommand.data
                                    .serviceName,
                              ),
                            )
                        : localizations
                            .signXTransactionsCommandReceivedNotification
                            .replaceAll(
                              '%1',
                              formData.value.signTransactionCommand.origin.name,
                            )
                            .replaceAll(
                              '%2',
                              command.data.rpcSignTransactionCommandData.length
                                  .toString(),
                            )
                            .replaceAll(
                              '%3',
                              _getShortName(
                                formData.value.signTransactionCommand.data
                                    .serviceName,
                              ),
                            ),
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                  TextSpan(
                    text: ' ${estimatedFees.formatNumber(
                      language.getLocaleStringWithoutDefault(),
                    )}',
                    style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
                  ),
                  TextSpan(
                    text: ' UCO',
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                ],
              ),
            ),
            Column(
              children: command.data.rpcSignTransactionCommandData
                  .asMap()
                  .entries
                  .map((entry) {
                final index = entry.key;
                final rpcSignTransactionCommandData = entry;

                return TransactionRaw(
                  addresses[index],
                  rpcSignTransactionCommandData,
                );
              }).toList(),
            ),
          ],
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

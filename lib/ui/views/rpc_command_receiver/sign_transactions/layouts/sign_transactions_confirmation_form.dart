import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/rpc/command.dart';
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
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignTransactionsConfirmationForm extends ConsumerWidget
    implements SheetSkeletonInterface {
  const SignTransactionsConfirmationForm(
    this.command,
    this.estimatedFees, {
    super.key,
  });

  final RPCAuthenticatedCommand<awc.SignTransactionRequest> command;
  final double estimatedFees;

  static const String routerPage = '/sign_transaction_confirmation';

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
            context.pop(false);
          },
        ),
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.confirm,
          Dimens.buttonBottomDimens,
          onPressed: () {
            context.pop(true);
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
                    text: command.data.transactions.length == 1
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
                              command.data.transactions.length.toString(),
                            )
                            .replaceAll(
                              '%3',
                              _getShortName(
                                formData.value.signTransactionCommand.data
                                    .serviceName,
                              ),
                            ),
                    style: ArchethicThemeStyles.textStyleSize12W400Primary,
                  ),
                  TextSpan(
                    text: ' ${estimatedFees.formatNumber(
                      language.getLocaleStringWithoutDefault(),
                    )}',
                    style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
                  ),
                  TextSpan(
                    text: ' UCO',
                    style: ArchethicThemeStyles.textStyleSize12W400Primary,
                  ),
                ],
              ),
            ),
            Column(
              children: command.data.transactions
                  .asMap()
                  .entries
                  .map((rpcSignTransactionCommandData) {
                return TransactionRaw(
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

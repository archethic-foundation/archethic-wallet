import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/bloc/provider.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/layouts/transaction_raw.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignTransactionsConfirmationForm extends ConsumerWidget {
  const SignTransactionsConfirmationForm(
    this.command,
    this.estimatedFees, {
    super.key,
  });

  final RPCCommand<RPCSignTransactionsCommandData> command;
  final double estimatedFees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

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
        return SafeArea(
          minimum: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.035,
            bottom: MediaQuery.of(context).size.height * 0.035,
          ),
          child: Column(
            children: <Widget>[
              Text(
                localizations.transactionConfirmationFormHeader,
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
                        Text(
                          command.data.rpcSignTransactionCommandData.length == 1
                              ? localizations
                                  .sign1TransactionCommandReceivedNotification
                                  .replaceAll(
                                    '%1',
                                    formData.value.signTransactionCommand.origin
                                        .name,
                                  )
                                  .replaceAll(
                                    '%2',
                                    _getShortName(
                                      formData.value.signTransactionCommand.data
                                          .serviceName,
                                    ),
                                  )
                                  .replaceAll(
                                    '%3',
                                    estimatedFees.formatNumber(
                                      language.getLocaleStringWithoutDefault(),
                                    ),
                                  )
                              : localizations
                                  .signXTransactionsCommandReceivedNotification
                                  .replaceAll(
                                    '%1',
                                    formData.value.signTransactionCommand.origin
                                        .name,
                                  )
                                  .replaceAll(
                                    '%2',
                                    command.data.rpcSignTransactionCommandData
                                        .length
                                        .toString(),
                                  )
                                  .replaceAll(
                                    '%3',
                                    _getShortName(
                                      formData.value.signTransactionCommand.data
                                          .serviceName,
                                    ),
                                  )
                                  .replaceAll(
                                    '%4',
                                    estimatedFees.formatNumber(
                                      language.getLocaleStringWithoutDefault(),
                                    ),
                                  ),
                          style:
                              ArchethicThemeStyles.textStyleSize12W400Primary,
                        ),
                        Column(
                          children: command.data.rpcSignTransactionCommandData
                              .asMap()
                              .entries
                              .map((rpcSignTransactionCommandData) {
                            return TransactionRaw(
                              rpcSignTransactionCommandData,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
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
                    onPressed: () async {
                      context.pop(true);
                    },
                  ),
                ],
              ),
            ],
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

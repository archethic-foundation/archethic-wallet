import 'dart:convert';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendTransactionConfirmationForm extends ConsumerWidget {
  const SendTransactionConfirmationForm(this.command, {super.key});

  final RPCCommand<RPCSendTransactionCommandData> command;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final formState = ref.watch(
      SignTransactionConfirmationProviders.form(command),
    );
    final formNotifier = ref.watch(
      SignTransactionConfirmationProviders.form(command).notifier,
    );

    return formState.map(
      error: (error) =>
          const SizedBox(), // TODO(reddwarf): should we display an error/loading screen ?
      loading: (loading) => const SizedBox(),
      data: (formData) {
        return TapOutsideUnfocus(
          child: SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Column(
              children: <Widget>[
                SheetHeader(
                  title: localizations.transactionConfirmationFormHeader,
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
                            localizations
                                .transactionSignatureCommandReceivedNotification
                                .replaceAll(
                              '%1',
                              formData.value.signTransactionCommand.origin.name,
                            ),
                            style: theme.textStyleSize12W400Primary,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          displayInfoDetail(context, ref),
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
                        Navigator.of(context).pop(
                          const Result<TransactionConfirmation,
                              TransactionError>.failure(
                            TransactionError.userRejected(),
                          ),
                        );
                      },
                    ),
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.confirm,
                      Dimens.buttonBottomDimens,
                      onPressed: () async {
                        // Authenticate
                        final authMethod = AuthenticationMethod(
                          ref.read(
                            AuthenticationProviders.settings.select(
                              (settings) => settings.authenticationMethod,
                            ),
                          ),
                        );
                        final auth = await AuthFactory.authenticate(
                          context,
                          ref,
                          authMethod: authMethod,
                          activeVibrations: ref
                              .read(SettingsProviders.settings)
                              .activeVibrations,
                        );
                        if (auth) {
                          ShowSendingAnimation.build(
                            context,
                            theme,
                          );

                          final result = await formNotifier.send(
                            (progress) {
                              _showSendProgress(
                                context,
                                ref,
                                theme,
                                progress,
                              );
                            },
                          );

                          result.map(
                            success: (success) {},
                            failure: (failure) {
                              _showSendFailed(
                                context,
                                ref,
                                theme,
                                failure,
                              );
                            },
                          );

                          Navigator.of(context).pop(); // Hide SendingAnimation
                          Navigator.of(context).pop(result);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget displayInfoDetail(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    switch (command.data.type) {
      case 'keychain':
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SheetDetailCard(
                children: [
                  Text(
                    localizations.tokenName,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Expanded(
                    child: Text(
                      'addAccount.name',
                      style: theme.textStyleSize12W400Primary,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.estimatedFees,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    '0 ${AccountBalance.cryptoCurrencyLabel}',
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              /*SheetDetailCard(
                children: [
                  Text(
                    localizations.availableAfterCreation,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    AmountFormatters.standard(
                      accountSelected!.balance!.nativeTokenValue,
                      addAccount.symbolFees(context),
                    ),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),*/
            ],
          ),
        );

      case 'token':
        final token = Token.fromJson(jsonDecode(command.data.data.content!));
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  localizations.addTokenConfirmationMessage,
                  style: theme.textStyleSize12W400Primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.tokenName,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Expanded(
                    child: Text(
                      token.name ?? '',
                      style: theme.textStyleSize12W400Primary,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.tokenSymbol,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    token.symbol ?? '',
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.tokenInitialSupply,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    NumberUtil.formatThousands(token.supply ?? 0),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
            ],
          ),
        );
      /* case 'transfer':
        var amountInUco = command.data.data.ledger!.uco!.transfers[0].amount;
        final primaryCurrency =
            ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
      
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  child: AutoSizeText(
                    AmountFormatters.standard(
                      amountInUco,
                      transfer.symbol(context),
                    ),
                    style: theme.textStyleSize28W700Primary,
                  ),
                ),
              ),
              SheetDetailCard(
                children: [
                  Text(
                    '${localizations.txListFrom} ${accountSelected.name}',
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    '${localizations.txListTo} ${transfer.recipient.format(localizations)}',
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    AmountFormatters.standard(
                      amountInUco,
                      transfer.symbol(context),
                    ),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.estimatedFees,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    AmountFormatters.standardSmallValue(
                      transfer.feeEstimationOrZero,
                      AccountBalance.cryptoCurrencyLabel,
                    ),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.total,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    AmountFormatters.standard(
                      transfer.feeEstimationOrZero + amountInUco,
                      AccountBalance.cryptoCurrencyLabel,
                    ),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              SheetDetailCard(
                children: [
                  Text(
                    localizations.availableAfterTransfer,
                    style: theme.textStyleSize12W400Primary,
                  ),
                  Text(
                    AmountFormatters.standard(
                      accountSelected.balance!.nativeTokenValue -
                          (transfer.feeEstimationOrZero + amountInUco),
                      transfer.symbol(context),
                    ),
                    style: theme.textStyleSize12W400Primary,
                  ),
                ],
              ),
              if (transfer.message.isNotEmpty)
                SheetDetailCard(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.sendMessageConfirmHeader,
                            style: theme.textStyleSize12W400Primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              transfer.message,
                              style: theme.textStyleSize12W400Primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );*/

      default:
        return const SizedBox();
    }
  }

  void _showSendProgress(
    BuildContext context,
    WidgetRef ref,
    BaseTheme theme,
    UseCaseProgress event,
  ) {
    UIUtil.showSnackbar(
      event.progress == 1
          ? AppLocalizations.of(context)!
              .transactionConfirmed1
              .replaceAll('%1', event.progress.toString())
              .replaceAll('%2', event.total.toString())
          : AppLocalizations.of(context)!
              .transactionConfirmed
              .replaceAll('%1', event.progress.toString())
              .replaceAll('%2', event.total.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );
  }

  void _showSendFailed(
    BuildContext context,
    WidgetRef ref,
    BaseTheme theme,
    TransactionError error,
  ) {
    UIUtil.showSnackbar(
      error.localizedMessage(AppLocalizations.of(context)!),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
  }
}

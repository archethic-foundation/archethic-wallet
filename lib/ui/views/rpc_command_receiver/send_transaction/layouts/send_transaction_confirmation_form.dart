import 'dart:convert';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class SendTransactionConfirmationForm extends ConsumerWidget
    implements SheetSkeletonInterface {
  const SendTransactionConfirmationForm(
    this.command, {
    super.key,
  });

  final RPCCommand<awc.SendTransactionRequest> command;

  static const String routerPage = '/send_transaction_confirmation';

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
    final formNotifier = ref.watch(
      SignTransactionConfirmationProviders.form(command).notifier,
    );
    return Row(
      children: <Widget>[
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.cancel,
          Dimens.buttonBottomDimens,
          onPressed: () {
            context.pop(
              const Result<TransactionConfirmation, TransactionError>.failure(
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
            Navigator.of(context).push(
              AnimationLoadingOverlay(
                AnimationType.send,
                ArchethicTheme.animationOverlayStrong,
                title: AppLocalizations.of(context)!.pleaseWait,
              ),
            );

            final result = await formNotifier.send(
              (progress) {
                _showSendProgress(
                  context,
                  ref,
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
                  failure,
                );
              },
            );

            context
              ..pop() // Hide SendingAnimation
              ..pop(result);
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
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final formState = ref.watch(
      SignTransactionConfirmationProviders.form(command),
    );

    return formState.map(
      error: (error) =>
          const SizedBox(), // TODO(reddwarf): should we display an error/loading screen ?
      loading: (loading) => const SizedBox(),
      data: (formData) {
        return Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                SheetDetailCard(
                  children: [
                    Text(
                      localizations.estimatedFees,
                      style: ArchethicThemeStyles.textStyleSize12W400Primary,
                    ),
                    Text(
                      '${formData.value.feesEstimation} ${AccountBalance.cryptoCurrencyLabel}',
                      style: ArchethicThemeStyles.textStyleSize12W400Primary,
                    ),
                  ],
                ),
                SheetDetailCard(
                  children: [
                    Text(
                      localizations.availableAfterCreation,
                      style: ArchethicThemeStyles.textStyleSize12W400Primary,
                    ),
                    Text(
                      AmountFormatters.standard(
                        accountSelected!.balance!.nativeTokenValue -
                            formData.value.feesEstimation,
                        AccountBalance.cryptoCurrencyLabel,
                      ),
                      style: ArchethicThemeStyles.textStyleSize12W400Primary,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  localizations.signTransactionListTransactionsHeader
                      .replaceAll('%1', '')
                      .trim(),
                  style: ArchethicThemeStyles.textStyleSize12W400Primary,
                ),
                SizedBox.fromSize(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ArchethicTheme.backgroundTransferListOutline,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: ArchethicTheme.backgroundTransferListCard,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(
                        const JsonEncoder.withIndent('  ').convert(
                          command.data.data,
                        ),
                        style: ArchethicThemeStyles.textStyleSize12W400Primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSendProgress(
    BuildContext context,
    WidgetRef ref,
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
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
    );
  }

  void _showSendFailed(
    BuildContext context,
    WidgetRef ref,
    TransactionError error,
  ) {
    UIUtil.showSnackbar(
      error.localizedMessage(AppLocalizations.of(context)!),
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(seconds: 5),
    );
  }
}

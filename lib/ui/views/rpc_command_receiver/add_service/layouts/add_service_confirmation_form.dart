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
import 'package:aewallet/ui/views/rpc_command_receiver/add_service/bloc/provider.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
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

class AddServiceConfirmationForm extends ConsumerWidget
    implements SheetSkeletonInterface {
  const AddServiceConfirmationForm(
    this.serviceName,
    this.command, {
    super.key,
  });

  final RPCAuthenticatedCommand<awc.AddServiceRequest> command;
  final String serviceName;

  static const String routerPage = '/add_service_confirmation';

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

            final formNotifier = ref.read(
              AddServiceConfirmationProviders.form(command).notifier,
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
      AddServiceConfirmationProviders.form(command),
    );

    return formState.map(
      error: (error) =>
          const SizedBox(), // TODO(reddwarf): should we display an error/loading screen ?
      loading: (loading) => const SizedBox(),
      data: (formData) {
        return Column(
          children: <Widget>[
            Text(
              localizations.addServiceCommandReceivedNotification
                  .replaceAll(
                    '%1',
                    formData.value.signTransactionCommand.origin.name,
                  )
                  .replaceAll(
                    '%2',
                    accountSelected!.nameDisplayed,
                  ),
              style: ArchethicThemeStyles.textStyleSize12W400Primary,
            ),
            const SizedBox(
              height: 30,
            ),
            displayInfoDetail(context, ref),
          ],
        );
      },
    );
  }

  Widget displayInfoDetail(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SheetDetailCard(
            children: [
              Text(
                localizations.serviceName,
                style: ArchethicThemeStyles.textStyleSize12W400Primary,
              ),
              Expanded(
                child: Text(
                  serviceName,
                  style: ArchethicThemeStyles.textStyleSize12W400Primary,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedFees,
                style: ArchethicThemeStyles.textStyleSize12W400Primary,
              ),
              Text(
                '0 ${AccountBalance.cryptoCurrencyLabel}',
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
                  accountSelected!.balance!.nativeTokenValue,
                  AccountBalance.cryptoCurrencyLabel,
                ),
                style: ArchethicThemeStyles.textStyleSize12W400Primary,
              ),
            ],
          ),
        ],
      ),
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

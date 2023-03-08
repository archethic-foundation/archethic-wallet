import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/dialogs/accounts_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'widgets/account_selection_button.dart';

class TransactionConfirmationForm extends ConsumerWidget {
  const TransactionConfirmationForm(this.command, {super.key});

  final RPCCommand<RPCSendTransactionCommandData> command;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final formState = ref.watch(
      SignTransactionConfirmationProviders.form(command),
    );
    final formNotifier = ref.watch(
      SignTransactionConfirmationProviders.form(command).notifier,
    );

    return formState.map(
      error: (error) =>
          const SizedBox(), //TODO(reddwarf): should we display an error/loading screen ?
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
                            style: theme.textStyleSize14W600Primary,
                          ),
                          _AccountSelectionButton(
                            formNotifier: formNotifier,
                            formState: formData.value,
                          ),
                          const SizedBox(
                            height: 30,
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
                      localizations.send,
                      Dimens.buttonBottomDimens,
                      onPressed: () async {
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

  void _showSendProgress(
    BuildContext context,
    WidgetRef ref,
    BaseTheme theme,
    UseCaseProgress event,
  ) {
    UIUtil.showSnackbar(
      event.progress == 1
          ? AppLocalization.of(context)!
              .transactionConfirmed1
              .replaceAll('%1', event.progress.toString())
              .replaceAll('%2', event.total.toString())
          : AppLocalization.of(context)!
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
      error.localizedMessage(AppLocalization.of(context)!),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
  }
}

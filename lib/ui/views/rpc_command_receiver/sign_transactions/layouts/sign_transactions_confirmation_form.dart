import 'dart:convert';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignTransactionsConfirmationForm extends ConsumerWidget {
  const SignTransactionsConfirmationForm(
    this.command, {
    super.key,
  });

  final RPCCommand<RPCSignTransactionsCommandData> command;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final formState = ref.watch(
      SignTransactionsConfirmationProviders.form(command),
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
                            command.data.rpcSignTransactionCommandData.length ==
                                    1
                                ? localizations
                                    .sign1TransactionCommandReceivedNotification
                                    .replaceAll(
                                      '%1',
                                      formData.value.signTransactionCommand
                                          .origin.name,
                                    )
                                    .replaceAll('%2', accountSelected!.name)
                                : localizations
                                    .signXTransactionsCommandReceivedNotification
                                    .replaceAll(
                                      '%1',
                                      formData.value.signTransactionCommand
                                          .origin.name,
                                    )
                                    .replaceAll(
                                      '%2',
                                      command.data.rpcSignTransactionCommandData
                                          .length
                                          .toString(),
                                    )
                                    .replaceAll('%3', accountSelected!.name),
                            style: theme.textStyleSize12W400Primary,
                          ),
                          Column(
                            children: command.data.rpcSignTransactionCommandData
                                .asMap()
                                .entries
                                .map((rpcSignTransactionCommandData) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    localizations
                                        .signTransactionListTransactionsHeader
                                        .replaceAll(
                                      '%1',
                                      (rpcSignTransactionCommandData.key + 1)
                                          .toString(),
                                    ),
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                  SizedBox.fromSize(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: theme
                                              .backgroundTransferListOutline!,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      color: theme.backgroundTransferListCard,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SelectableText(
                                          const JsonEncoder.withIndent('  ')
                                              .convert(
                                            rpcSignTransactionCommandData
                                                .value.data,
                                          ),
                                          style:
                                              theme.textStyleSize12W400Primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                        Navigator.of(context).pop(false);
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
                          Navigator.of(context).pop(auth);
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
}

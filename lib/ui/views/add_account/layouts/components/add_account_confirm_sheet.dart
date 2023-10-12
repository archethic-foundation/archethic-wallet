/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:aewallet/ui/views/add_account/layouts/components/add_account_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddAccountConfirmSheet extends ConsumerStatefulWidget {
  const AddAccountConfirmSheet({
    super.key,
  });

  @override
  ConsumerState<AddAccountConfirmSheet> createState() =>
      _AddAccountConfirmState();
}

class _AddAccountConfirmState extends ConsumerState<AddAccountConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok') {
        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalizations.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      icon: Symbols.info,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) async {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalizations.of(context)!
              .addAccountConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalizations.of(context)!
              .addAccountConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
    );
    await ref.read(SessionProviders.session.notifier).refresh();
    await ref
        .read(AccountProviders.selectedAccount.notifier)
        .refreshRecentTransactions();

    if (mounted) {
      Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
    }
  }

  void _showSendFailed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) {
    // Send failed
    if (animationOpen!) {
      Navigator.of(context).pop();
    }
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    animationOpen = false;
  }

  @override
  void dispose() {
    _sendTxSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: localizations.addAccount,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    localizations.addAccountConfirmationMessage,
                    style: theme.textStyleSize14W600Primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AddAccountDetail(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.confirm,
                      Dimens.buttonTopDimens,
                      key: const Key('confirm'),
                      icon: Icon(
                        Symbols.check,
                        color: theme.mainButtonLabel,
                        size: 14,
                      ),
                      onPressed: () async {
                        ShowSendingAnimation.build(
                          context,
                          theme,
                        );
                        await ref
                            .read(
                              AddAccountFormProvider.addAccountForm.notifier,
                            )
                            .send(context);
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.cancel,
                      Dimens.buttonBottomDimens,
                      key: const Key('cancel'),
                      icon: Icon(
                        Symbols.arrow_back_ios,
                        color: theme.mainButtonLabel,
                        size: 14,
                      ),
                      onPressed: () {
                        addAccountNotifier.setAddAccountProcessStep(
                          AddAccountProcessStep.form,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

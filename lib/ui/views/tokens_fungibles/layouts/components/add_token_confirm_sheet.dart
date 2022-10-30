// ignore_for_file: cancel_subscriptions, avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/components/add_token_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:

class AddTokenConfirmSheet extends ConsumerStatefulWidget {
  const AddTokenConfirmSheet({
    super.key,
  });

  @override
  ConsumerState<AddTokenConfirmSheet> createState() => _AddTokenConfirmState();
}

class _AddTokenConfirmState extends ConsumerState<AddTokenConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      final addTokenNotifier =
          ref.watch(AddTokenFormProvider.addTokenForm.notifier);
      addTokenNotifier.send(context);
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok' &&
          TransactionConfirmation.isEnoughConfirmations(
            event.nbConfirmations!,
            event.maxConfirmations!,
          )) {
        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalization.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) async {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalization.of(context)!
              .addTokenConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalization.of(context)!
              .addTokenConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );

    setState(() {
      StateContainer.of(context).requestUpdate();
    });
    Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
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
    _authSub?.cancel();
    _sendTxSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final addToken = ref.watch(AddTokenFormProvider.addTokenForm);
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: localizations.createToken,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    localizations.addTokenConfirmationMessage,
                    style: theme.textStyleSize14W600Primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AddTokenDetail(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButton(
                      AppButtonType.primary,
                      localizations.confirm,
                      Dimens.buttonTopDimens,
                      key: const Key('confirm'),
                      onPressed: () async {
                        // Authenticate
                        final preferences = await Preferences.getInstance();
                        final authMethod = preferences.getAuthMethod();
                        final auth = await AuthFactory.authenticate(
                          context,
                          ref,
                          authMethod: authMethod,
                          activeVibrations: ref
                              .watch(SettingsProviders.settings)
                              .activeVibrations,
                        );
                        if (auth) {
                          EventTaxiImpl.singleton().fire(AuthenticatedEvent());
                        }
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    AppButton(
                      AppButtonType.primary,
                      localizations.cancel,
                      Dimens.buttonBottomDimens,
                      key: const Key('cancel'),
                      onPressed: () {
                        addTokenNotifier.setAddTokenProcessStep(
                          AddTokenProcessStep.form,
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

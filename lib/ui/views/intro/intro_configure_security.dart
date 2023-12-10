import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog_help.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroConfigureSecurity extends ConsumerStatefulWidget {
  const IntroConfigureSecurity({
    super.key,
    this.accessModes,
    required this.seed,
    required this.name,
    required this.fromPage,
    this.extra,
  });
  final List<PickerItem>? accessModes;
  final String? seed;
  final String? name;
  final String fromPage;
  final Object? extra;

  static const routerPage = '/intro_configure_security';

  @override
  ConsumerState<IntroConfigureSecurity> createState() =>
      _IntroConfigureSecurityState();
}

class _IntroConfigureSecurityState
    extends ConsumerState<IntroConfigureSecurity> {
  PickerItem? _accessModesSelected;
  bool? animationOpen;

  StreamSubscription<TransactionSendEvent>? _sendTxSub;
  StreamSubscription<AuthenticatedEvent>? _authSub;
  bool keychainAccessRequested = false;
  bool newWalletRequested = false;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      await createKeychain();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final localizations = AppLocalizations.of(context)!;

      if (event.response != 'ok' && event.nbConfirmations == 0) {
        UIUtil.showSnackbar(
          '${localizations.sendError} (${event.response!})',
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
        );

        return;
      }

      if (event.response != 'ok') {
        UIUtil.showSnackbar(
          localizations.notEnoughConfirmations,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
        );
        return;
      }

      switch (event.transactionType!) {
        case TransactionSendEventType.keychain:
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? localizations.keychainCreationTransactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : localizations.keychainCreationTransactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            duration: const Duration(milliseconds: 5000),
            icon: Symbols.info,
          );

          if (keychainAccessRequested) break;

          setState(() {
            keychainAccessRequested = true;
          });
          await KeychainUtil().createKeyChainAccess(
            ref.read(SettingsProviders.settings).network,
            widget.seed,
            event.params!['keychainAddress']! as String,
            event.params!['originPrivateKey']! as String,
            event.params!['keychain']! as Keychain,
          );
          break;
        case TransactionSendEventType.keychainAccess:
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? localizations.keychainAccessCreationTransactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : localizations.keychainAccessCreationTransactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            duration: const Duration(milliseconds: 5000),
            icon: Symbols.info,
          );

          if (newWalletRequested) break;

          setState(() {
            newWalletRequested = true;
          });
          var error = false;
          try {
            await ref
                .read(SessionProviders.session.notifier)
                .createNewAppWallet(
                  seed: widget.seed!,
                  keychainAddress: event.params!['keychainAddress']! as String,
                  keychain: event.params!['keychain']! as Keychain,
                  name: widget.name,
                );
          } catch (e) {
            error = true;
            UIUtil.showSnackbar(
              '${localizations.sendError} ($e)',
              context,
              ref,
              ArchethicTheme.text,
              ArchethicTheme.snackBarShadow,
            );
          }
          if (error == false) {
            context.go(HomePage.routerPage);
          }
          break;
        case TransactionSendEventType.transfer:
          break;
        case TransactionSendEventType.token:
          break;
      }
    });
  }

  void _destroyBus() {
    _sendTxSub?.cancel();
    _authSub?.cancel();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  @override
  void initState() {
    log('initstate');
    _registerBus();
    animationOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: ArchethicTheme.text,
                            onPressed: () {
                              context.go(widget.fromPage, extra: widget.extra);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () async {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    preferences.activeVibrations,
                                  );
                              return AuthentificationMethodDialogHelp.getDialog(
                                context,
                                ref,
                              );
                            },
                            child: Icon(
                              Symbols.help,
                              color: ArchethicTheme.text,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              localizations.securityHeader,
                              style: ArchethicThemeStyles
                                  .textStyleSize24W700Primary,
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              stepGranularity: 0.5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                left: 20,
                                right: 20,
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              child: AutoSizeText(
                                localizations.configureSecurityIntro,
                                style: ArchethicThemeStyles
                                    .textStyleSize14W600Primary,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: AutoSizeText(
                                localizations.configureSecurityExplanation,
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                                textAlign: TextAlign.justify,
                                maxLines: 6,
                                stepGranularity: 0.5,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (widget.accessModes != null)
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: PickerWidget(
                                  pickerItems: widget.accessModes,
                                  onSelected: (value) async {
                                    setState(() {
                                      _accessModesSelected = value;
                                    });
                                    if (_accessModesSelected == null) return;
                                    final authMethod = _accessModesSelected!
                                        .value as AuthMethod;
                                    var authenticated = false;
                                    switch (authMethod) {
                                      case AuthMethod.biometrics:
                                        authenticated = await sl
                                            .get<BiometricUtil>()
                                            .authenticateWithBiometrics(
                                              context,
                                              localizations.unlockBiometrics,
                                            );
                                        break;
                                      case AuthMethod.password:
                                        authenticated = (await context.push(
                                          SetPassword.routerPage,
                                          extra: {
                                            'header':
                                                localizations.setPasswordHeader,
                                            'description': AppLocalizations.of(
                                              context,
                                            )!
                                                .configureSecurityExplanationPassword,
                                            'seed': widget.seed,
                                          },
                                        ))! as bool;
                                        break;
                                      case AuthMethod.pin:
                                        authenticated = (await context.push(
                                          PinScreen.routerPage,
                                          extra: {
                                            'type': PinOverlayType.newPin,
                                          },
                                        ))! as bool;
                                        break;
                                      case AuthMethod.yubikeyWithYubicloud:
                                        authenticated = (await context.push(
                                          SetYubikey.routerPage,
                                          extra: {
                                            'header':
                                                localizations.seYubicloudHeader,
                                            'description': localizations
                                                .seYubicloudDescription,
                                          },
                                        ))! as bool;

                                        break;
                                      case AuthMethod.biometricsUniris:
                                        break;
                                      case AuthMethod.ledger:
                                        break;
                                    }
                                    if (authenticated) {
                                      await ref
                                          .read(
                                            AuthenticationProviders
                                                .settings.notifier,
                                          )
                                          .setAuthMethod(authMethod);
                                      EventTaxiImpl.singleton()
                                          .fire(AuthenticatedEvent());
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createKeychain() async {
    final localizations = AppLocalizations.of(context)!;

    ShowSendingAnimation.build(
      context,
      title: localizations.appWalletInitInProgress,
    );

    try {
      await sl.get<DBHelper>().clearAppWallet();
      final vault = await HiveVaultDatasource.getInstance();
      await vault.setSeed(widget.seed!);

      final originPrivateKey = sl.get<ApiService>().getOriginKey();

      await KeychainUtil().createKeyChain(
        ref.read(SettingsProviders.settings).network,
        widget.seed,
        widget.name,
        originPrivateKey,
      );
    } catch (e) {
      final localizations = AppLocalizations.of(context)!;

      UIUtil.showSnackbar(
        '${localizations.sendError} ($e)',
        context,
        ref,
        ArchethicTheme.text,
        ArchethicTheme.snackBarShadow,
      );
    }
  }
}

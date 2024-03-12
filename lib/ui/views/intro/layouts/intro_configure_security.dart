import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/intro/bloc/provider.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog_help.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
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
    required this.seed,
    required this.name,
  });
  final String? seed;
  final String? name;

  static const routerPage = '/intro_configure_security';

  @override
  ConsumerState<IntroConfigureSecurity> createState() =>
      _IntroConfigureSecurityState();
}

class _IntroConfigureSecurityState extends ConsumerState<IntroConfigureSecurity>
    implements SheetSkeletonInterface {
  PickerItem? _accessModesSelected;
  bool? animationOpen;

  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      backgroundImage: ArchethicTheme.backgroundWelcome,
    );
  }

  @override
  void initState() {
    animationOpen = false;
    super.initState();
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return SheetAppBar(
      title: localizations.securityHeader,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
      widgetRight:
          connectivityStatusProvider == ConnectivityStatus.isDisconnected
              ? const Padding(
                  padding: EdgeInsets.only(
                    right: 7,
                    top: 7,
                  ),
                  child: IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
                )
              : Padding(
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
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final accessModes =
        ref.watch(IntroProviders.accessModesProvider).valueOrNull;

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          alignment: AlignmentDirectional.centerStart,
          child: AutoSizeText(
            localizations.configureSecurityIntro,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          child: AutoSizeText(
            localizations.configureSecurityExplanation,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
            textAlign: TextAlign.justify,
            maxLines: 6,
            stepGranularity: 0.5,
          ),
        ),
        if (accessModes != null)
          PickerWidget(
            pickerItems: accessModes
                .map(
                  (accessMode) => accessMode.pickerItem(context),
                )
                .toList(),
            onSelected: (value) async {
              setState(() {
                _accessModesSelected = value;
              });
              if (_accessModesSelected == null) return;
              final authMethod = _accessModesSelected!.value as AuthMethod;
              var authenticated = false;
              switch (authMethod) {
                case AuthMethod.biometrics:
                  authenticated =
                      await sl.get<BiometricUtil>().authenticateWithBiometrics(
                            context,
                            localizations.unlockBiometrics,
                          );
                  break;
                case AuthMethod.password:
                  authenticated = (await context.push(
                    SetPassword.routerPage,
                    extra: {
                      'header': localizations.setPasswordHeader,
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
                      'type': PinOverlayType.newPin.name,
                    },
                  ))! as bool;
                  break;
                case AuthMethod.yubikeyWithYubicloud:
                  authenticated = (await context.push(
                    SetYubikey.routerPage,
                    extra: {
                      'header': localizations.setYubicloudHeader,
                      'description': localizations.setYubicloudDescription,
                    },
                  ))! as bool;

                  break;
                case AuthMethod.ledger:
                  break;
              }
              if (authenticated) {
                await ref
                    .read(
                      AuthenticationProviders.settings.notifier,
                    )
                    .setAuthMethod(authMethod);
                EventTaxiImpl.singleton().fire(AuthenticatedEvent());
              }
            },
          ),
      ],
    );
  }
}

extension AuthMethodPickerItemX on AuthMethod {
  PickerItem pickerItem(BuildContext context) => PickerItem(
        AuthenticationMethod(this).getDisplayName(context),
        null,
        AuthenticationMethod.getIcon(this),
        ArchethicTheme.pickerItemIconEnabled,
        this,
        true,
        key: Key(name),
      );
}

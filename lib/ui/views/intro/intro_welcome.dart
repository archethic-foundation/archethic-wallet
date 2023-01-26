/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/settings/version.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/banner_connectivity_not_available.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/dialogs/language_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroWelcome extends ConsumerStatefulWidget {
  const IntroWelcome({super.key});

  @override
  ConsumerState<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends ConsumerState<IntroWelcome> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.8,
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    const _Main(),
                    _Footer(
                      isConnectivityAvailable: connectivityStatusProvider ==
                          ConnectivityStatus.isConnected,
                      checkedValue: checkedValue,
                      onToggleCGU: (newValue) {
                        setState(() {
                          checkedValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const BannerConnectivityNotAvailable(),
                const _Language(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Language extends ConsumerWidget {
  const _Language();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(
          UiIcons.language,
          color: Colors.blue,
          size: 25,
        ),
        onPressed: () async {
          await LanguageDialog.getDialog(context, ref);
        },
      ),
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _LogoArchethic(),
            _WelcomTextFirst(),
            _WelcomTextSecond(),
          ],
        ),
      ),
    );
  }
}

class _LogoArchethic extends ConsumerWidget {
  const _LogoArchethic();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SizedBox(
          height: 200,
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: Image.asset(
              '${theme.assetsFolder!}${theme.logo!}.png',
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomTextFirst extends ConsumerWidget {
  const _WelcomTextFirst();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: AutoSizeText(
        localizations.welcomeText,
        maxLines: 3,
        style: theme.textStyleSize16W400Primary,
      ),
    );
  }
}

class _WelcomTextSecond extends ConsumerWidget {
  const _WelcomTextSecond();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      child: AutoSizeText(
        localizations.welcomeText2,
        maxLines: 5,
        style: theme.textStyleSize12W100Primary,
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({
    required this.isConnectivityAvailable,
    required this.checkedValue,
    required this.onToggleCGU,
  });

  final bool isConnectivityAvailable;
  final bool checkedValue;
  final Function(bool? newValue) onToggleCGU;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        _CGU(
          isConnectivityAvailable: isConnectivityAvailable,
          checkedValue: checkedValue,
          onToggleCGU: onToggleCGU,
        ),
        const SizedBox(
          height: 10,
        ),
        _ButtonNewWallet(
          checkedValue: checkedValue,
        ),
        _ButtonImportWallet(
          checkedValue: checkedValue,
        ),
      ],
    );
  }
}

class _CGU extends ConsumerWidget {
  const _CGU({
    required this.isConnectivityAvailable,
    required this.checkedValue,
    required this.onToggleCGU,
  });

  final bool isConnectivityAvailable;
  final bool checkedValue;
  final Function(bool? newValue) onToggleCGU;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isConnectivityAvailable)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          localizations.welcomeDisclaimerChoice,
                          style: theme.textStyleSize14W600Primary,
                        ),
                        value: checkedValue,
                        onChanged: onToggleCGU,
                        checkColor: theme.background,
                        activeColor: theme.text,
                        controlAffinity: ListTileControlAffinity.leading,
                        secondary: TextFieldButton(
                          icon: UiIcons.privacy_policy,
                          onPressed: () {
                            UIUtil.showWebview(
                              context,
                              'https://archethic.net/aewallet-privacy.html',
                              localizations.welcomeDisclaimerLink,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(
                right: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Consumer(
                    builder: (context, ref, child) {
                      final asyncVersionString = ref.watch(
                        versionStringProvider(
                          AppLocalization.of(context)!,
                        ),
                      );

                      return Text(
                        asyncVersionString.asData?.value ?? '',
                        textAlign: TextAlign.left,
                        style: theme.textStyleSize10W100Primary,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtonNewWallet extends ConsumerWidget {
  const _ButtonNewWallet({required this.checkedValue});

  final bool checkedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return _ButtonAction(
      key: const Key('newWallet'),
      outline: !checkedValue,
      label: localizations.newWallet,
      onPressed: () async {
        if (checkedValue) {
          await ref.read(SettingsProviders.settings.notifier).setNetwork(
                const NetworksSetting(
                  network: AvailableNetworks.archethicMainNet,
                  networkDevEndpoint: '',
                ),
              );
          Navigator.of(context).pushNamed(
            '/intro_welcome_get_first_infos',
          );
        }
      },
    );
  }
}

class _ButtonImportWallet extends ConsumerWidget {
  const _ButtonImportWallet({required this.checkedValue});

  final bool checkedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return _ButtonAction(
      key: const Key('importWallet'),
      outline: !checkedValue,
      label: localizations.importWallet,
      onPressed: () async {
        if (checkedValue) {
          await NetworkDialog.getDialog(
            context,
            ref,
            ref.read(
              SettingsProviders.settings.select(
                (settings) => settings.network,
              ),
            ),
          );
          Navigator.of(context).pushNamed('/intro_import');
        }
      },
    );
  }
}

class _ButtonAction extends ConsumerWidget {
  const _ButtonAction({
    required super.key,
    required this.outline,
    required this.onPressed,
    required this.label,
  });

  final bool outline;
  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: <Widget>[
        // Import Wallet Button
        AppButtonTiny(
          outline
              ? AppButtonTinyType.primaryOutline
              : AppButtonTinyType.primary,
          label,
          Dimens.buttonBottomDimens,
          key: key,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

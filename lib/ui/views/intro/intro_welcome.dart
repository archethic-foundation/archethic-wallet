/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/version.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/dialogs/language_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lit_starfield/lit_starfield.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroWelcome extends ConsumerStatefulWidget {
  const IntroWelcome({super.key});

  @override
  ConsumerState<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends ConsumerState<IntroWelcome> {
  bool cguChecked = false;

  @override
  Widget build(BuildContext context) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const _AppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundWelcome,
            ),
            fit: MediaQuery.of(context).size.width >= 400
                ? BoxFit.fitWidth
                : BoxFit.fitHeight,
            alignment: Alignment.centerRight,
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.8,
              child: LitStarfieldContainer(
                velocity: 0.2,
                number: 600,
                starColor: ArchethicThemeBase.neutral0,
                scale: 3,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            Opacity(
              opacity: 0.3,
              child: LitStarfieldContainer(
                velocity: 0.5,
                number: 300,
                scale: 6,
                starColor: ArchethicThemeBase.blue500,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                ),
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        const _Main(),
                        _Footer(
                          isConnectivityAvailable: connectivityStatusProvider ==
                              ConnectivityStatus.isConnected,
                          cguChecked: cguChecked,
                          onToggleCGU: (newValue) {
                            setState(() {
                              cguChecked = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 40),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              const _Language(),
              if (connectivityStatusProvider ==
                  ConnectivityStatus.isDisconnected)
                const IconNetworkWarning(
                  alignment: Alignment.topRight,
                ),
            ],
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
    return IconButton(
      padding: const EdgeInsets.only(bottom: 4),
      icon: Icon(
        Symbols.translate,
        color: ArchethicTheme.iconDrawer,
        size: 25,
        weight: IconSize.weightM,
        opticalSize: IconSize.opticalSizeM,
        grade: IconSize.gradeM,
      ),
      onPressed: () async {
        await LanguageDialog.getDialog(context, ref);
      },
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _LogoArchethic(),
            _WelcomeTextFirst(),
            _WelcomeTextSecond(),
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
            child: SvgPicture.asset(
              '${ArchethicTheme.assetsFolder}Archethic - Logo.svg',
              colorFilter:
                  ColorFilter.mode(ArchethicTheme.text, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeTextFirst extends ConsumerWidget {
  const _WelcomeTextFirst();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: AutoSizeText(
        localizations.welcomeText,
        maxLines: 3,
        style: ArchethicThemeStyles.textStyleSize20W700Primary,
      ),
    );
  }
}

class _WelcomeTextSecond extends ConsumerWidget {
  const _WelcomeTextSecond();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      child: AutoSizeText(
        localizations.welcomeText2,
        maxLines: 5,
        style: ArchethicThemeStyles.textStyleSize12W100Primary,
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({
    required this.isConnectivityAvailable,
    required this.cguChecked,
    required this.onToggleCGU,
  });

  final bool isConnectivityAvailable;
  final bool cguChecked;
  final Function(bool? newValue) onToggleCGU;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isConnectivityAvailable)
                  _CGU(
                    cguChecked: cguChecked,
                    onToggleCGU: onToggleCGU,
                  ),
                const _VersionInfo(),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _ButtonNewWallet(
          cguChecked: cguChecked,
        ),
        _ButtonImportWallet(
          cguChecked: cguChecked,
        ),
      ],
    );
  }
}

class _CGU extends ConsumerWidget {
  const _CGU({
    required this.cguChecked,
    required this.onToggleCGU,
  });

  final bool cguChecked;
  final Function(bool? newValue) onToggleCGU;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: CheckboxListTile(
              title: InkWell(
                onTap: () {
                  UIUtil.showWebview(
                    context,
                    'https://archethic.net/aewallet-privacy.html',
                    localizations.welcomeDisclaimerLink,
                  );
                },
                child: Text(
                  localizations.welcomeDisclaimerChoice,
                  style:
                      ArchethicThemeStyles.textStyleSize12W400UnderlinePrimary,
                ),
              ),
              value: cguChecked,
              onChanged: onToggleCGU,
              checkColor: ArchethicTheme.background,
              activeColor: ArchethicTheme.text,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        ),
      ],
    );
  }
}

class _VersionInfo extends ConsumerWidget {
  const _VersionInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
                  AppLocalizations.of(context)!,
                ),
              );

              return Text(
                asyncVersionString.asData?.value ?? '',
                textAlign: TextAlign.left,
                style: ArchethicThemeStyles.textStyleSize10W100Primary,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ButtonNewWallet extends ConsumerWidget {
  const _ButtonNewWallet({required this.cguChecked});

  final bool cguChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.newWallet,
          Dimens.buttonTopDimens,
          key: const Key('newWallet'),
          onPressed: () async {
            if (cguChecked) {
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
          disabled: !cguChecked,
        ),
      ],
    );
  }
}

class _ButtonImportWallet extends ConsumerWidget {
  const _ButtonImportWallet({required this.cguChecked});

  final bool cguChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.importWallet,
          Dimens.buttonBottomDimens,
          key: const Key('importWallet'),
          onPressed: () async {
            if (cguChecked) {
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
          disabled: !cguChecked,
        ),
      ],
    );
  }
}

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/security_configuration.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroBackupConfirm extends ConsumerStatefulWidget {
  const IntroBackupConfirm({
    required this.name,
    required this.seed,
    this.welcomeProcess = true,
    super.key,
  });
  final String? name;
  final String? seed;
  final bool welcomeProcess;

  static const routerPage = '/intro_backup_confirm';

  @override
  ConsumerState<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends ConsumerState<IntroBackupConfirm>
    with SecurityConfigurationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> wordListSelected = List<String>.empty(growable: true);
  List<String> wordListToSelect = List<String>.empty(growable: true);
  List<String> originalWordsList = List<String>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    // TODO(reddwarf03): LanguageSeed seems to be local to "import wallet" and "create wallet" screens. Maybe it should not be stored in preferences ? (3)
    final languageSeed = ref.read(
      SettingsProviders.settings.select((settings) => settings.languageSeed),
    );
    wordListToSelect = AppMnemomics.seedToMnemonic(
      widget.seed!,
      languageCode: languageSeed,
    );
    wordListToSelect.sort(
      (a, b) => a.compareTo(b),
    );
    originalWordsList = AppMnemomics.seedToMnemonic(
      widget.seed!,
      languageCode: languageSeed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
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
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: ArchethicTheme.text,
                            onPressed: () {
                              context.go(
                                IntroBackupSeedPage.routerPage,
                                extra: widget.name,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              child: AutoSizeText(
                                localizations.confirmSecretPhrase,
                                style: ArchethicThemeStyles
                                    .textStyleSize24W700Primary,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                                top: 15,
                              ),
                              child: AutoSizeText(
                                localizations.confirmSecretPhraseExplanation,
                                style: ArchethicThemeStyles
                                    .textStyleSize14W600Primary,
                                textAlign: TextAlign.justify,
                                maxLines: 6,
                                stepGranularity: 0.5,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                                top: 15,
                              ),
                              child: Wrap(
                                spacing: 10,
                                children: wordListSelected
                                    .asMap()
                                    .entries
                                    .map((MapEntry entry) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            child: Text(
                                              (entry.key + 1).toString(),
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W100Primary60,
                                            ),
                                          ),
                                          label: Text(
                                            entry.value,
                                            style: ArchethicThemeStyles
                                                .textStyleSize12W400Primary,
                                          ),
                                          onDeleted: () {
                                            setState(() {
                                              wordListToSelect.add(entry.value);
                                              wordListSelected
                                                  .removeAt(entry.key);
                                            });
                                          },
                                          deleteIconColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            Divider(
                              height: 15,
                              color: ArchethicTheme.text60,
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                                top: 15,
                              ),
                              child: Wrap(
                                spacing: 10,
                                children: wordListToSelect
                                    .asMap()
                                    .entries
                                    .map((MapEntry entry) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            wordListSelected.add(entry.value);
                                            wordListToSelect
                                                .removeAt(entry.key);
                                            setState(() {});
                                          },
                                          child: Chip(
                                            label: Text(
                                              entry.value,
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W400Primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AppButtonTinyConnectivity(
                              localizations.confirm,
                              Dimens.buttonTopDimens,
                              key: const Key('confirm'),
                              onPressed: () async {
                                var orderOk = true;

                                for (var i = 0;
                                    i < originalWordsList.length;
                                    i++) {
                                  if (originalWordsList[i] !=
                                      wordListSelected[i]) {
                                    orderOk = false;
                                  }
                                }
                                if (orderOk == false) {
                                  setState(() {
                                    UIUtil.showSnackbar(
                                      localizations.confirmSecretPhraseKo,
                                      context,
                                      ref,
                                      ArchethicTheme.text,
                                      ArchethicTheme.snackBarShadow,
                                    );
                                  });
                                } else {
                                  ref.read(
                                    RecoveryPhraseSavedProvider
                                        .setRecoveryPhraseSaved(true),
                                  );

                                  if (widget.welcomeProcess) {
                                    await launchSecurityConfiguration(
                                      context,
                                      ref,
                                      widget.seed!,
                                      widget.name!,
                                      IntroBackupConfirm.routerPage,
                                      {
                                        'name': widget.name,
                                        'seed': widget.seed,
                                      },
                                    );
                                  } else {
                                    UIUtil.showSnackbar(
                                      localizations.confirmSecretPhraseOk,
                                      context,
                                      ref,
                                      ArchethicTheme.text,
                                      ArchethicTheme.snackBarShadow,
                                      icon: Symbols.info,
                                    );
                                    context.pop();
                                  }
                                }
                              },
                              disabled: wordListSelected.length != 24,
                            ),
                          ],
                        ),
                        if (widget.welcomeProcess)
                          Row(
                            children: <Widget>[
                              AppButtonTinyConnectivity(
                                localizations.pass,
                                Dimens.buttonBottomDimens,
                                key: const Key('pass'),
                                onPressed: () {
                                  AppDialogs.showConfirmDialog(
                                    context,
                                    ref,
                                    localizations
                                        .passBackupConfirmationDisclaimer,
                                    localizations.passBackupConfirmationMessage,
                                    localizations
                                        .passRecoveryPhraseBackupSecureLater,
                                    () async {
                                      ref.read(
                                        RecoveryPhraseSavedProvider
                                            .setRecoveryPhraseSaved(false),
                                      );
                                      await launchSecurityConfiguration(
                                        context,
                                        ref,
                                        widget.seed!,
                                        widget.name!,
                                        IntroBackupConfirm.routerPage,
                                        {
                                          'name': widget.name,
                                          'seed': widget.seed,
                                        },
                                      );
                                    },
                                    titleStyle: ArchethicThemeStyles
                                        .textStyleSize14W600PrimaryRed,
                                    additionalContent:
                                        localizations.archethicDoesntKeepCopy,
                                    additionalContentStyle: ArchethicThemeStyles
                                        .textStyleSize12W300PrimaryRed,
                                    cancelText: localizations
                                        .passRecoveryPhraseBackupSecureNow,
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
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
}

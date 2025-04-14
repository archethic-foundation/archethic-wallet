import 'dart:async';
import 'dart:ui';

import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/blockchain_tx_version.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/usecases.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/domain/usecases/new_keychain.usecase.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/divider/divider_custom.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed_pass_popup.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:event_taxi/event_taxi.dart';
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
    with KeychainServiceMixin
    implements SheetSkeletonInterface {
  List<String> wordListSelected = List<String>.empty(growable: true);
  List<String> wordListToSelect = List<String>.empty(growable: true);
  List<String> originalWordsList = List<String>.empty(growable: true);

  StreamSubscription<AuthenticatedEvent>? _authSub;

  bool keychainAccessRequested = false;
  bool newWalletRequested = false;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      await createKeychain();
    });
  }

  void _destroyBus() {
    _authSub?.cancel();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();

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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      backgroundImage: ArchethicTheme.backgroundWelcome,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        BtnFooterPrimary(
          key: const Key('confirm'),
          buttonText: localizations.confirm,
          onTap: () async {
            var orderOk = true;

            for (var i = 0; i < originalWordsList.length; i++) {
              if (originalWordsList[i] != wordListSelected[i]) {
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
                RecoveryPhraseSavedProvider.setRecoveryPhraseSaved(true),
              );

              if (widget.welcomeProcess) {
                await context.push(
                  IntroConfigureSecurity.routerPage,
                  extra: {
                    'isImportProfile': false,
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
                context.go(
                  HomePage.routerPage,
                );
              }
            }
          },
          isLocked: wordListSelected.length != 24,
        ),
        if (widget.welcomeProcess)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: BtnFooterPrimary(
              key: const Key('pass'),
              buttonText: localizations.pass,
              onTap: () async {
                await showDialog<bool>(
                  barrierDismissible: false,
                  useRootNavigator: false,
                  context: context,
                  builder: (context) {
                    return IntroBackupSeedPassPopup(
                      widget.name!,
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return SheetAppBar(
      title: localizations.confirmRecoveryPhraseDisclaimerTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          if (widget.welcomeProcess == false) {
            context.pop();
          } else {
            context.go(
              IntroBackupSeedPage.routerPage,
              extra: widget.name,
            );
          }
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
              : const SizedBox.shrink(),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final textStyleWithOpacity =
        Theme.of(context).textTheme.bodySmallWithOpacity;

    final boldTextStyle = textStyleWithOpacity.copyWith(
      fontWeight: FontWeightTelegraf.fontWeightBold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildRichText(
          localizations.confirmRecoveryPhraseDisclaimerDesc1,
          localizations.confirmRecoveryPhraseDisclaimerDesc2,
          localizations.confirmRecoveryPhraseDisclaimerDesc3,
          textStyleWithOpacity,
          boldTextStyle,
        ),
        const SizedBox(height: 20),
        Text(
          localizations.confirmRecoveryPhraseDisclaimerDesc4,
          style: textStyleWithOpacity,
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 10,
          children: wordListSelected.asMap().entries.map((MapEntry entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFF262626).withValues(alpha: 0.3),
                          border: Border.all(
                            color: const Color(0xFF343434),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Chip(
                          backgroundColor: Colors.transparent,
                          color:
                              const WidgetStatePropertyAll(Colors.transparent),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color(0xFF343434)
                                  .withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          avatar: Container(
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF343434),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              (entry.key + 1).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                            ),
                          ),
                          label: Text(
                            entry.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                          ),
                          onDeleted: () {
                            setState(() {
                              wordListToSelect.add(entry.value);
                              wordListSelected.removeAt(entry.key);
                            });
                          },
                          deleteIconColor: Colors.white,
                        ),
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
        const DividerCustom(),
        Wrap(
          spacing: 10,
          children: wordListToSelect.asMap().entries.map((MapEntry entry) {
            return Column(
              children: [
                SizedBox(
                  height: 45,
                  child: GestureDetector(
                    onTap: () {
                      wordListSelected.add(entry.value);
                      wordListToSelect.removeAt(entry.key);
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF262626)
                                  .withValues(alpha: 0.3),
                              border:
                                  Border.all(color: const Color(0xFF505050)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    entry.value,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Future<void> createKeychain() async {
    final localizations = AppLocalizations.of(context)!;
    context.loadingOverlay.show(
      title: localizations.appWalletInitInProgress,
    );

    try {
      final apiService = ref.read(apiServiceProvider);
      final blockchainTxVersion = await ref.read(
        blockchainTxCurrentVersionProvider.future,
      );
      await ref.read(createNewAppWalletCaseProvider).run(
            widget.seed!,
            apiService,
            ['archethic-wallet-${widget.name!}'],
            blockchainTxVersion,
          );

      context.loadingOverlay.hide();
      context.go(
        HomePage.routerPage,
      );
    } catch (e) {
      final localizations = AppLocalizations.of(context)!;

      UIUtil.showSnackbar(
        '${localizations.sendError} (${_getErrorMessage(e)})',
        context,
        ref,
        ArchethicTheme.text,
        ArchethicTheme.snackBarShadow,
      );
      context.loadingOverlay.hide();

      if (widget.welcomeProcess == false) {
        context.pop();
      } else {
        context.go(
          IntroBackupSeedPage.routerPage,
          extra: widget.name,
        );
      }
    }
  }

  Widget _buildRichText(
    String text1,
    String text2,
    String text3,
    TextStyle textStyle,
    TextStyle boldTextStyle,
  ) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text1, style: textStyle),
          TextSpan(text: text2, style: boldTextStyle),
          TextSpan(text: text3, style: textStyle),
        ],
      ),
    );
  }

  String _getErrorMessage(Object e) {
    if (e is archethic.ArchethicConnectionException) {
      return e.cause;
    } else if (e is archethic.ArchethicInvalidResponseException) {
      return e.cause;
    } else if (e is ArchethicNewKeychainErrorException) {
      return e.cause;
    } else if (e is ArchethicNewKeychainAccessErrorException) {
      return e.cause;
    }
    return e.toString();
  }
}

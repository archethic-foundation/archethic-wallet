/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/network_choice_infos.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_account_confirmation_popup.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/dialogs/environment_dialog.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroNewWalletGetFirstInfos extends ConsumerStatefulWidget {
  const IntroNewWalletGetFirstInfos({super.key});

  static const routerPage = '/intro_welcome_get_first_infos';

  @override
  ConsumerState<IntroNewWalletGetFirstInfos> createState() =>
      _IntroNewWalletDisclaimerState();
}

class _IntroNewWalletDisclaimerState
    extends ConsumerState<IntroNewWalletGetFirstInfos>
    implements SheetSkeletonInterface {
  late TextEditingController nameController;
  final FocusNode nameFocusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    nameFocusNode.addListener(_onFocusChange);
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = nameFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return BtnFooterPrimary(
      buttonText: localizations.next,
      key: const Key('okButton'),
      onTap: () async {
        if (nameController.text.trim().isEmpty) {
          UIUtil.showSnackbar(
            localizations.introNewWalletGetFirstInfosNameBlank,
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
          );
        } else {
          await showDialog<bool>(
            barrierDismissible: false,
            useRootNavigator: false,
            context: context,
            builder: (context) {
              return IntroNewWalletAccountConfirmationPopup(
                nameController.text,
              );
            },
          );
        }
      },
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return SheetAppBar(
      title: '',
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(IntroWelcome.routerPage);
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
              : NetworkChoiceInfos(
                  onTap: () async {
                    final environment =
                        await context.push(EnvironmentDialog.routerPage);
                    if (environment != null) {
                      await ref
                          .read(SettingsProviders.settings.notifier)
                          .setEnvironment(environment as aedappfm.Environment);
                    }

                    FocusScope.of(context).requestFocus(nameFocusNode);
                  },
                ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          localizations.introNewWalletGetFirstInfosWelcome,
          style: ArchethicThemeStyles.textStyleSize24W700Primary,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 30,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!
                    .introNewWalletGetFirstInfosDesc1,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
              TextSpan(
                text: AppLocalizations.of(context)!
                    .introNewWalletGetFirstInfosDesc2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmallWithOpacity
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!
                    .introNewWalletGetFirstInfosDesc3,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!
                .introNewWalletGetFirstInfosTextfieldLabel,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeightTelegraf.fontWeightSemibold),
          ),
        ),
        TextField(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _hasFocus ? Colors.black : null,
              ),
          autocorrect: false,
          controller: nameController,
          focusNode: nameFocusNode,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(
              20,
            ),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor:
                _hasFocus ? Colors.white : Colors.white.withOpacity(0.15),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 10),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

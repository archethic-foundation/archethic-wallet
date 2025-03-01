/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroNewWalletDisclaimer extends ConsumerWidget
    implements SheetSkeletonInterface {
  const IntroNewWalletDisclaimer({super.key, this.name});
  final String? name;

  static const routerPage = '/intro_backup_safety';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BtnFooterPrimary(
          buttonText: localizations.readAndUnderstandButton,
          onTap: () {
            context.go(
              IntroBackupSeedPage.routerPage,
              extra: name,
            );
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return SheetAppBar(
      title: localizations.secureRecoveryPhraseDisclaimerTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(IntroNewWalletGetFirstInfos.routerPage);
        },
      ),
      widgetRight:
          connectivityStatusProvider == ConnectivityStatus.isDisconnected
              ? const Padding(
                  padding: EdgeInsets.only(right: 7, top: 7),
                  child: IconNetworkWarning(alignment: Alignment.topRight),
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
      children: <Widget>[
        const SizedBox(height: 20),
        _buildRichText(
          localizations.secureRecoveryPhraseDisclaimerDesc1,
          localizations.secureRecoveryPhraseDisclaimerDesc2,
          localizations.secureRecoveryPhraseDisclaimerDesc3,
          textStyleWithOpacity,
          boldTextStyle,
        ),
        const SizedBox(height: 20),
        Text(
          localizations.secureRecoveryPhraseDisclaimerDesc4,
          style: textStyleWithOpacity,
        ),
        const SizedBox(height: 30),
        _buildDisclaimerList(
          localizations,
          Theme.of(context).textTheme.bodySmall!,
          Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeightTelegraf.fontWeightBold,
              ),
        ),
      ],
    );
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

  Widget _buildDisclaimerList(
    AppLocalizations localizations,
    TextStyle textStyle,
    TextStyle boldTextStyle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDisclaimerItem(
          icon: Icons.looks_one_outlined,
          text1: localizations.secureRecoveryPhraseDisclaimerDescItem1Desc1,
          text2: localizations.secureRecoveryPhraseDisclaimerDescItem1Desc2,
          text3: localizations.secureRecoveryPhraseDisclaimerDescItem1Desc3,
          textStyle: textStyle,
          boldTextStyle: boldTextStyle,
        ),
        const SizedBox(height: 10),
        _buildDisclaimerItem(
          icon: Icons.looks_two_outlined,
          text1: localizations.secureRecoveryPhraseDisclaimerDescItem2Desc1,
          text2: localizations.secureRecoveryPhraseDisclaimerDescItem2Desc2,
          textStyle: textStyle,
          boldTextStyle: boldTextStyle,
        ),
        const SizedBox(height: 10),
        _buildDisclaimerItem(
          icon: Icons.looks_3_outlined,
          text1: localizations.secureRecoveryPhraseDisclaimerDescItem3Desc1,
          text2: localizations.secureRecoveryPhraseDisclaimerDescItem3Desc2,
          textStyle: textStyle,
          boldTextStyle: boldTextStyle,
        ),
      ],
    );
  }

  Widget _buildDisclaimerItem({
    required IconData icon,
    required String text1,
    String? text2,
    String? text3,
    required TextStyle textStyle,
    required TextStyle boldTextStyle,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.9,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: text1, style: boldTextStyle),
                    if (text2 != null) TextSpan(text: text2, style: textStyle),
                    if (text3 != null)
                      TextSpan(text: text3, style: boldTextStyle),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Flutter imports:
// ignore_for_file: unnecessary_const

// Flutter imports:
import 'package:aewallet/ui/views/home_page_aewallet.dart';
import 'package:aemail/ui/views/home_page_aemail.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/ui/views/sheets/all_apps_sheet.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:bin/ui/widgets/menu/settings_drawer_bin.dart';
import 'package:core/appstate_container.dart';
import 'package:core/localization.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/dialog.dart';
import 'package:core/ui/widgets/components/icon_widget.dart';
import 'package:core/ui/widgets/menu/abstract_menu_widget.dart';
import 'package:core/util/case_converter.dart';
import 'package:core/util/preferences.dart';
import 'package:core/util/service_locator.dart';
import 'package:core/util/vault.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuWidgetBin extends AbstractMenuWidget {
  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  @override
  Widget buildMainMenuIcons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                StateContainer.of(context).currentAEApp = AEApps.aemail;
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => const AppHomePageAEMail(),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  buildIconDataWidget(
                    context,
                    FontAwesomeIcons.envelope,
                    30,
                    30,
                  ),
                  const SizedBox(height: 5),
                  Text(AppLocalization.of(context)!.appAEMailTitle,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  buildIconDataWidget(context, FontAwesomeIcons.globe, 30, 30,
                      enabled: false),
                  const SizedBox(height: 5),
                  Text(AppLocalization.of(context)!.appAEWebTitle,
                      style: AppStyles.textStyleSize14W600PrimaryDisabled(
                          context)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  buildIconDataWidget(
                      context, FontAwesomeIcons.stackOverflow, 30, 30,
                      enabled: false),
                  const SizedBox(height: 5),
                  Text(AppLocalization.of(context)!.appAEStakingTitle,
                      style: AppStyles.textStyleSize14W600PrimaryDisabled(
                          context)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                StateContainer.of(context).currentAEApp = AEApps.aewallet;
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => const AppHomePageAEWallet(),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  buildIconDataWidget(context, FontAwesomeIcons.wallet, 30, 30),
                  const SizedBox(height: 5),
                  Text(AppLocalization.of(context)!.appAEWalletTitle,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSecondMenuIcons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierColor: StateContainer.of(context)
                      .curTheme
                      .backgroundDark!
                      .withOpacity(0.8),
                  barrierDismissible: false,
                  barrierLabel: '',
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) {
                    return const AllAppsSheet();
                  },
                );
              },
              child: buildIconDataWidget(context, Icons.apps_rounded, 20, 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                AppDialogs.showConfirmDialog(
                    context,
                    CaseChange.toUpperCase(
                        AppLocalization.of(context)!.warning, context),
                    AppLocalization.of(context)!.logoutDetail,
                    AppLocalization.of(context)!.logoutAction.toUpperCase(),
                    () {
                  // Show another confirm dialog
                  AppDialogs.showConfirmDialog(
                      context,
                      AppLocalization.of(context)!.logoutAreYouSure,
                      AppLocalization.of(context)!.logoutReassurance,
                      CaseChange.toUpperCase(
                          AppLocalization.of(context)!.yes, context), () {
                    // Delete all data
                    sl.get<DBHelper>().dropAll();
                    Vault.getInstance().then((Vault _vault) {
                      _vault.deleteAll();
                    });
                    Preferences.getInstance().then((Preferences _preferences) {
                      _preferences.deleteAll();
                      StateContainer.of(context).logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    });
                  });
                });
              },
              child: buildIconDataWidget(
                  context, Icons.power_settings_new, 20, 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildContextMenu(BuildContext context) {
    return const SettingsSheetBin();
  }
}

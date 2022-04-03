// Flutter imports:
// ignore_for_file: unnecessary_const

// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/all_apps_sheet.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/menu/settings_drawer_universe.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aewallet/ui/views/home_page_aewallet.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:core/localization.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/widgets/menu/abstract_menu_widget.dart';
import 'package:core_ui/util/case_converter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuWidgetUniverse extends AbstractMenuWidget {
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
                        AppLocalization.of(context)!.warning,
                        context,
                        StateContainer.of(context)
                            .curLanguage
                            .getLocaleString()),
                    AppLocalization.of(context)!.removeWalletDetail,
                    AppLocalization.of(context)!
                        .removeWalletAction
                        .toUpperCase(), () {
                  // Show another confirm dialog
                  AppDialogs.showConfirmDialog(
                      context,
                      AppLocalization.of(context)!.removeWalletAreYouSure,
                      AppLocalization.of(context)!.removeWalletReassurance,
                      CaseChange.toUpperCase(
                          AppLocalization.of(context)!.yes,
                          context,
                          StateContainer.of(context)
                              .curLanguage
                              .getLocaleString()), () {
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
    return const SettingsSheetUniverse();
  }
}

// Dart imports:
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/settings_list_item.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsSheetWeb extends StatefulWidget {
  const SettingsSheetWeb({Key? key}) : super(key: key);

  @override
  _SettingsSheetWebState createState() => _SettingsSheetWebState();
}

class _SettingsSheetWebState extends State<SettingsSheetWeb>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  String versionString = '';

  bool notNull(Object o) => o != null;

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString =
            AppLocalization.of(context)!.version + ' ${packageInfo.version}';
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  Future<bool> _onBackButtonPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: StateContainer.of(context).curTheme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            buildMainSettings(context),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.primary30!,
                width: 1),
          )),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 10.0, bottom: 10.0),
                      child: Text('Deploy',
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context, 'Files', '',
                        icon: 'packages/aeweb/assets/icons/file.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawerColor!,
                        onPressed: () {}),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context, 'Folders', '',
                        icon: 'packages/aeweb/assets/icons/folder.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawerColor!,
                        onPressed: () {}),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context, 'Sites', '',
                        icon: 'packages/aeweb/assets/icons/site.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawerColor!,
                        onPressed: () {}),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
                //List Bottom Gradient
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark00!,
                          StateContainer.of(context).curTheme.backgroundDark!
                        ],
                        begin: const AlignmentDirectional(0.5, -1),
                        end: const AlignmentDirectional(0.5, 0.5),
                      ),
                    ),
                  ),
                ), //List Bottom Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }
}

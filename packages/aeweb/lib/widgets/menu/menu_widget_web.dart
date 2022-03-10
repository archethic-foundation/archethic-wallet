// Flutter imports:

// Flutter imports:
import 'package:aeweb/widgets/menu/settings_drawer_web.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/ae_apps.dart';
import 'package:core_ui/ui/widgets/menu/abstract_menu_widget.dart';
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';

class MenuWidgetWeb extends AbstractMenuWidget {
  @override
  Widget buildMainMenuIcons(BuildContext context) {
    return const SizedBox();
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
                StateContainer.of(context).currentAEApp = AEApps.bin;
                Navigator.pop(context);
              },
              child: buildIconDataWidget(context, Icons.home, 20, 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildContextMenu(BuildContext context) {
    return const SettingsSheetWeb();
  }
}

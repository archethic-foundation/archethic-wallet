import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RawInfoPopup {
  static Future getPopup(
    BuildContext context,
    WidgetRef ref,
    LongPressEndDetails details,
    String info,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return showMenu(
      color: theme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
        side: BorderSide(
          color: theme.text60!,
        ),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'info',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      info,
                      style: theme.textStyleSize12W100Primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

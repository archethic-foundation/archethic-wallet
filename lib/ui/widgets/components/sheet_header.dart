/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.title,
    this.widgetLeft,
    this.widgetRight,
    this.widgetBeforeTitle,
    this.widgetAfterTitle,
  });

  final String title;
  final Widget? widgetLeft;
  final Widget? widgetRight;
  final Widget? widgetBeforeTitle;
  final Widget? widgetAfterTitle;

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widgetLeft != null)
              widgetLeft!
            else
              const SizedBox(
                width: 60,
                height: 40,
              ),
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: theme.text60,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 140,
                  ),
                  child: Column(
                    children: <Widget>[
                      if (widgetBeforeTitle != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: widgetBeforeTitle,
                        ),
                      AutoSizeText(
                        title,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                      if (widgetAfterTitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: widgetAfterTitle,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (widgetRight != null)
              widgetRight!
            else
              const SizedBox(
                width: 60,
                height: 40,
              ),
          ],
        ),
      ],
    );
  }
}

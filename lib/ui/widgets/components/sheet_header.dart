/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SheetHeader extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
                    color: ArchethicTheme.text60,
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
                        style: ArchethicThemeStyles.textStyleSize24W700Primary,
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

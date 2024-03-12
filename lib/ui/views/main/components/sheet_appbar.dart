/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SheetAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SheetAppBar({
    required this.title,
    this.styleTitle,
    this.widgetLeft,
    this.widgetRight,
    this.widgetBeforeTitle,
    this.widgetAfterTitle,
    super.key,
  });

  final String title;
  final Widget? widgetLeft;
  final Widget? widgetRight;
  final Widget? widgetBeforeTitle;
  final Widget? widgetAfterTitle;
  final TextStyle? styleTitle;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: widgetLeft,
      actions: widgetRight == null
          ? []
          : [
              widgetRight!,
            ],
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: AutoSizeText(
          title,
          style: styleTitle ?? ArchethicThemeStyles.textStyleSize24W700Primary,
        ),
      ).animate().fade(duration: const Duration(milliseconds: 300)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }
}

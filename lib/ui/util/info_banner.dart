/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoBanner extends ConsumerWidget {
  const InfoBanner(
    this.message, {
    this.height = 50.0,
    this.fontSize = 12.0,
    super.key,
  });

  final String message;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (message.isEmpty) {
      return SizedBox(
        height: height,
      );
    }
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.text!.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: theme.background,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              message,
              style: TextStyle(
                color: theme.text,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

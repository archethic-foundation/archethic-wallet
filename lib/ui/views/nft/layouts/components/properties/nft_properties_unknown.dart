/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';

import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTPropertiesUnknown extends ConsumerWidget {
  const NFTPropertiesUnknown({
    super.key,
    required this.properties,
  });

  final Map<String, dynamic> properties;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectableText(
      const JsonEncoder.withIndent('  ').convert(
        properties,
      ),
      style: ArchethicThemeStyles.textStyleSize10W100Primary,
    );
  }
}

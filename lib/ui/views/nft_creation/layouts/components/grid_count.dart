/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridCount extends ConsumerWidget {
  const GridCount({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      crossAxisCount:
          Responsive.isDesktop(context) || Responsive.isTablet(context) ? 3 : 2,
      crossAxisSpacing: 20,
      childAspectRatio: 0.8,
      children: children,
    );
  }
}

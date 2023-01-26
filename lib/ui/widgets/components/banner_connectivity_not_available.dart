/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/util/main_appBar_icon_network_warning.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BannerConnectivityNotAvailable extends ConsumerWidget {
  const BannerConnectivityNotAvailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Align(
      alignment: Alignment.topRight,
      child: MainAppBarIconNetworkWarning(),
    );
  }
}

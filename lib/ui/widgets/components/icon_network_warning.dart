import 'dart:async';
import 'package:aewallet/ui/views/sheets/connectivity_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class IconNetworkWarning extends ConsumerWidget {
  const IconNetworkWarning({
    super.key,
    this.alignment = Alignment.center,
  });

  final Alignment alignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: alignment,
      child: IconButton(
        icon: const Icon(
          Symbols.signal_cellular_connected_no_internet_0_bar,
          color: Colors.red,
        ),
        onPressed: () async {
          unawaited(context.push(ConnectivityWarning.routerPage));
        },
      ),
    );
  }
}

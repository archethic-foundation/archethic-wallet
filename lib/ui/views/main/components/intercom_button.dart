import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/intercom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntercomButton extends ConsumerWidget {
  const IntercomButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIntercomEnabled = ref.watch(isIntercomEnabledProvider);
    if (isIntercomEnabled == false) {
      return const SizedBox.shrink();
    }

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(
        Symbols.contact_support,
        size: 18,
      ),
      onPressed: () async {
        await ref.read(connectIntercomProvider.future);
        await Intercom.instance.displayMessenger();
      },
    );
  }
}

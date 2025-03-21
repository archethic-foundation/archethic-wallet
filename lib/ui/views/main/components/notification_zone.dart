import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationZone extends ConsumerWidget {
  const NotificationZone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          ..._buildOnRampMessageBoxes(context, ref),
        ],
      );

  List<Widget> _buildOnRampMessageBoxes(BuildContext context, WidgetRef ref) {
    return ref
        .watch(onRampProviderOrdersProvider)
        .map(
          (order) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: MessageBox(
              key: Key(order.orderId),
              messageBoxType: switch (order.status) {
                OnRampProviderOrderStatus.processing =>
                  MessageBoxType.processing,
                OnRampProviderOrderStatus.failed ||
                OnRampProviderOrderStatus.canceled =>
                  MessageBoxType.warning,
                OnRampProviderOrderStatus.completed => MessageBoxType.success,
              },
              content: const Text('Order in process...'),
              onTap: () {
                final uri = ref
                    .read(
                      onrampProviderRepositoryProvider(order.onRampProvider),
                    )
                    .orderTrackUrl(orderId: order.orderId);
                launchUrl(uri);
              },
              trailing: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                iconSize: 14,
                padding: EdgeInsets.zero,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  ref
                      .read(onRampProviderOrdersProvider.notifier)
                      .dismiss(order);
                },
              ),
            )
                .animate()
                .fade(
                  duration: const Duration(milliseconds: 200),
                )
                .scale(
                  duration: const Duration(milliseconds: 200),
                ),
          ),
        )
        .toList();
  }
}

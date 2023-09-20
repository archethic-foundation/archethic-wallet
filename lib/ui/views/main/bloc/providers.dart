import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainTabControllerProvider =
    StateNotifierProvider.autoDispose<TabControllerNotifier, TabController?>(
        (ref) {
  return TabControllerNotifier();
});

class TabControllerNotifier extends StateNotifier<TabController?> {
  TabControllerNotifier() : super(null) {
    if (FeatureFlags.messagingActive) {
      tabCount++;
    }
  }

  int tabCount = 4;

  void initState(TickerProvider tickerProvider) {
    state = TabController(
      length: tabCount,
      vsync: tickerProvider,
    );
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainTabControllerProvider =
    StateNotifierProvider.autoDispose<TabControllerNotifier, TabController?>(
        (ref) {
  return TabControllerNotifier();
});

class TabControllerNotifier extends StateNotifier<TabController?> {
  TabControllerNotifier() : super(null);

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

final listenAddressesProvider =
    StateNotifierProvider.autoDispose<ListenAddressesNotifier, List<String>>(
        (ref) {
  return ListenAddressesNotifier();
});

class ListenAddressesNotifier extends StateNotifier<List<String>> {
  ListenAddressesNotifier() : super([]);

  void addListenAddresses(List<String> listenAddresses) {
    state = [
      ...state,
      ...listenAddresses,
    ];
  }

  void removeListenAddresses(List<String> listenAddresses) {
    // https://stackoverflow.com/questions/59423310/remove-list-from-another-list-in-dart
    final set1 = Set.from(state);
    final set2 = Set.from(listenAddresses);

    state = [
      ...List.from(set1.difference(set2)),
    ];
  }
}

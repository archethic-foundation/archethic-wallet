import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainTabControllerProvider =
    StateNotifierProvider<TabControllerNotifier, TabController?>((ref) {
  return TabControllerNotifier();
});

class TabControllerNotifier extends StateNotifier<TabController?> {
  TabControllerNotifier() : super(null);

  TabController? get provider => state;

  set provider(TabController? tabController) {
    state = tabController;
  }
}

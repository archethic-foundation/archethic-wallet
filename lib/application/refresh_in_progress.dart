import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshInProgressNotifier extends StateNotifier<bool> {
  RefreshInProgressNotifier() : super(false);

  void setRefreshInProgress(bool refreshInProgress) {
    state = refreshInProgress;
  }
}

final refreshInProgressProviders =
    StateNotifierProvider<RefreshInProgressNotifier, bool>(
  (ref) => RefreshInProgressNotifier(),
  name: 'refreshInProgressProvider',
);

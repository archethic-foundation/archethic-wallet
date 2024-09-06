import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_in_progress.g.dart';

@riverpod
class RefreshInProgressNotifier extends _$RefreshInProgressNotifier {
  @override
  bool build() {
    return false;
  }

  // ignore: avoid_setters_without_getters
  set refreshInProgress(bool refreshInProgress) {
    state = refreshInProgress;
  }
}

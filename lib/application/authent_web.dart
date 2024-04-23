import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthentWebNotifier extends StateNotifier<String> {
  AuthentWebNotifier() : super('');

  void setAuthentWeb(String authentWeb) {
    state = authentWeb;
  }
}

final authentWebProviders = StateNotifierProvider<AuthentWebNotifier, String>(
  (ref) => AuthentWebNotifier(),
  name: 'authentWebProvider',
);

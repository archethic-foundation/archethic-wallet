import 'dart:async';

class BrowserExtensionAWS {
  BrowserExtensionAWS() {
    throw UnimplementedError(
      'Browser extension is not supported on the desktop platform.',
    );
  }

  static bool get isPlatformCompatible => false;

  Future<void> run() async {}

  void stop() {}
}

//chrome.runtime.onConnect.addListener((port) => {console.log('connection interne'); port.onMessage.addListener((message) => {console.log(`message received ${message}`)})})

// @JS()
// library aws;

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:js/js.dart';

// @JS()
// external BrowserExtensionAWSStub? get aws;

// @JS('AWS')
// class BrowserExtensionAWSStub {
//   external set onConnect(Future<void> Function(IWebMessagePort port) callback);
// }

// @JS()
// class BrowserExtensionAWSPort {
//   external set onMessage(Function(dynamic message) callback);
//   external void postMessage(dynamic message);
// }
@JS('chrome')
library aws; // library name can be whatever you want

import 'package:js/js.dart';

@JS('runtime.connect')
external BrowserExtensionPort connect();

@JS('extension')
external dynamic get browserExtension;

bool get isWebBrowserExtension => browserExtension != null;

@JS('runtime.Port')
class BrowserExtensionPort {
  @JS('onMessage')
  external BrowserExtensionEvent get onMessage;

  @JS('disconnect')
  external disconnect();

  @JS('postMessage')
  external postMessage(dynamic message);
}

@JS()
class BrowserExtensionEvent {
  @JS('addListener')
  external addListener(
    void Function(
      dynamic message,
      BrowserExtensionPort port,
    ) callback,
  );
}
